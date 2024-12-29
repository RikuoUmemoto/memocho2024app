import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ログイン状態の確認
  User? get currentUser => _auth.currentUser;

  // ログアウト
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
