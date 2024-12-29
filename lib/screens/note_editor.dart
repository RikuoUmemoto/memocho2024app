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
  bool _isLoading = false;

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
      _titleController.text = noteData['title'] ?? '';
      _contentController.text = noteData['content'] ?? '';
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

    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.noteId == null) {
        await _firebaseManager.addNote(title, content);
      } else {
        await _firebaseManager.updateNote(widget.noteId!, title, content);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (widget.noteId != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await _firebaseManager.deleteNote(widget.noteId!);
                  Navigator.pop(context);
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
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 8,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveNote,
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
    );
  }
}
