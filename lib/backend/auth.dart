import 'package:firebase_auth/firebase_auth.dart';

Future<void> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("ログイン成功！");
  } catch (e) {
    print("ログイン失敗: $e");
  }
}

Future<void> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("アカウント作成成功！");
  } catch (e) {
    print("アカウント作成失敗: $e");
  }
}
