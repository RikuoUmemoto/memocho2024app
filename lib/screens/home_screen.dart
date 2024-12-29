/*ホーム画面*/

import 'package:flutter/material.dart';
import '../models/note.dart';
import '../backend/database_manager.dart';
import 'note_editor.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseManager _databaseService = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ帳'),
      ),
      body: FutureBuilder<List<Note>>(
        future: _databaseService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('メモがありません'));
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoteEditorScreen(noteId: note.id), // メモIDを渡す
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditorScreen()), // 修正
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}