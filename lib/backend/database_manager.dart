import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class FirebaseManager {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  // メモを追加
  Future<void> addNote(String title, String content) async {
    final note = Note(
      id: _notesCollection.doc().id,
      title: title,
      content: content,
      createdAt: DateTime.now(), // 現在の日時を設定
    );
    await _notesCollection.doc(note.id).set(note.toMap());
  }

  // メモのリアルタイムデータを取得する
  Stream<List<Note>> getNotesStream() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // メモを取得
  Future<List<Note>> getNotes() async {
    final querySnapshot = await _notesCollection.get();
    return querySnapshot.docs
        .map((doc) => Note.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // メモを ID で取得
  Future<Map<String, dynamic>> getNoteById(String id) async {
    final docSnapshot = await _notesCollection.doc(id).get();
    if (docSnapshot.exists) {
      return docSnapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('Note not found');
    }
  }

  // メモを更新
  Future<void> updateNote(String id, String title, String content) async {
    await _notesCollection.doc(id).update({
      'title': title,
      'content': content,
    });
  }

  // メモを削除
  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
