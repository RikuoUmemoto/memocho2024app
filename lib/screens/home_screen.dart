import 'package:flutter/material.dart';
import '../models/note.dart';
import '../backend/database_manager.dart';
import 'note_editor.dart';
import 'login_screen.dart';
import '../backend/logout.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseManager _databaseService = FirebaseManager();
  final AuthService _authService = AuthService(); // AuthService のインスタンスを作成

  // ログアウト処理
  Future<void> handleLogout(BuildContext context) async {
    try {
      await _authService.signOut(); // AuthService の signOut メソッドを呼び出す
      // ログアウト後、ログイン画面に戻す
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()), // LoginScreen に遷移
      );
    } catch (e) {
      // エラーが発生した場合にエラーメッセージを表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ログアウト失敗: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ帳'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                handleLogout(context), // ログアウトボタンが押されたら handleLogout を呼び出す
          ),
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: _databaseService.getNotesStream(), // リアルタイムでデータを監視
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
                  // 編集画面に遷移
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteEditorScreen(noteId: note.id),
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
            MaterialPageRoute(builder: (context) => NoteEditorScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
