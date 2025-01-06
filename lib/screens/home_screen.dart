import '../backend/database_manager.dart';
import 'note_editor.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseManager _firebaseManager = FirebaseManager();
  List<Map<String, dynamic>> _notes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    setState(
      () {
        _isLoading = true;
      },
    );

    try {
      // Note のリストを取得
      final List<Note> notes = await _firebaseManager.getNotes();

      // List<Note> を List<Map<String, dynamic>> に変換
      final List<Map<String, dynamic>> notesMap =
          notes.map((note) => note.toMap()).toList();

      setState(
        () {
          _notes = notesMap;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch notes: $e')),
      );
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  Future<void> _navigateToEditor({String? noteId}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NoteEditorScreen(noteId: noteId),
      ),
    );
    _fetchNotes();
  }

  // ログアウト処理
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ログアウト後の遷移など、必要な処理を追加
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully logged out')),
      );
      // ログアウト後にホーム画面をリダイレクトする場合
      Navigator.pushReplacementNamed(context, '/login'); // ログイン画面に遷移
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ一覧'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? const Center(child: Text('No notes available'))
              : ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, dynamic> note = _notes[index];
                    final List<String> tags =
                        List<String>.from(note['tags'] ?? []);

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(note['title']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note['content'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              children: tags
                                  .map<Widget>((tag) => Chip(label: Text(tag)))
                                  .toList(),
                            ),
                          ],
                        ),
                        onTap: () {
                          _navigateToEditor(noteId: note['id']);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToEditor();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
