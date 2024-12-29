import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  // メモを追加
  Future<void> addNote(String title, String content) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ログイン中のユーザーのUIDを使用して、ユーザー専用のコレクションにメモを追加
      final note = Note(
        id: _usersCollection
            .doc(user.uid)
            .collection('notes')
            .doc()
            .id, // ユーザーごとの「notes」サブコレクションにメモを追加
        title: title,
        content: content,
        createdAt: DateTime.now(), // 現在の日時を設定
      );
      await _usersCollection
          .doc(user.uid)
          .collection('notes')
          .doc(note.id)
          .set(note.toMap());
    } else {
      throw Exception('User not logged in');
    }
  }

  // メモのリアルタイムデータを取得する
  Stream<List<Note>> getNotesStream() {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return _usersCollection.doc(user.uid).collection('notes').snapshots().map(
        (snapshot) {
          return snapshot.docs
              .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
        },
      );
    } else {
      throw Exception('User not logged in');
    }
  }

  // メモを取得
  Future<List<Note>> getNotes() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final querySnapshot =
          await _usersCollection.doc(user.uid).collection('notes').get();
      return querySnapshot.docs
          .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('User not logged in');
    }
  }

  // メモを ID で取得
  Future<Map<String, dynamic>> getNoteById(String id) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final docSnapshot = await _usersCollection
          .doc(user.uid)
          .collection('notes')
          .doc(id)
          .get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception('Note not found');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  // メモを更新
  Future<void> updateNote(String id, String title, String content) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await _usersCollection.doc(user.uid).collection('notes').doc(id).update({
        'title': title,
        'content': content,
      });
    } else {
      throw Exception('User not logged in');
    }
  }

  // メモを削除
  Future<void> deleteNote(String id) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await _usersCollection.doc(user.uid).collection('notes').doc(id).delete();
    } else {
      throw Exception('User not logged in');
    }
  }
}
