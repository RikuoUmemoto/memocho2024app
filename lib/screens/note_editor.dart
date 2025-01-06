/*メモ作成と編集をする*/
import '../backend/database_manager.dart';
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatefulWidget {
  final String? noteId;

  const NoteEditorScreen({Key? key, this.noteId}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final FirebaseManager _firebaseManager = FirebaseManager();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  bool _isLoading = false;
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      _loadNoteData();
    }
  }

  Future<void> _loadNoteData() async {
    setState(
      () {
        _isLoading = true;
      },
    );

    try {
      final noteData = await _firebaseManager.getNoteById(widget.noteId!);

      // noteDataがnullでない場合、タイトルとコンテンツを設定
      if (noteData != null) {
        _titleController.text = noteData.title; // nullチェックは不要
        _contentController.text = noteData.content; // nullチェックは不要
        _tags = List<String>.from(noteData.tags); // タグをリストに設定
      } else {
        // noteDataがnullの場合
        _titleController.text = '';
        _contentController.text = '';
        _tags = [];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load note: $e')),
      );
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.noteId == null) {
        await _firebaseManager.addNote(title, content, _tags);
      } else {
        await _firebaseManager.updateNote(
            widget.noteId!, title, content, _tags);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(
        () {
          _tags.add(tag);
          _tagController.clear();
        },
      );
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (widget.noteId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await _firebaseManager.deleteNote(widget.noteId!);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete note: $e')),
                  );
                }
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 8,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tagController,
                          decoration: const InputDecoration(
                            labelText: 'Tag',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addTag,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0,
                    children: _tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              onDeleted: () => _removeTag(_tags.indexOf(tag)),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveNote,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
    );
  }
}
