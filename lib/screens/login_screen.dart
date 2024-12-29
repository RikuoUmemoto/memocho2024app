import 'package:flutter/material.dart';
import '../backend/auth.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleLogin() async {
    try {
      await signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // ログイン成功時にHomeScreenへ遷移
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      // ログイン失敗時にエラーメッセージを表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ログイン失敗: ${e.toString()}")),
      );
    }
  }

  Future<void> handleSignUp() async {
    try {
      await signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // 新規登録成功時の通知
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("アカウント作成成功！ログインしてください。")),
      );
    } catch (e) {
      // 新規登録失敗時の通知
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("アカウント作成失敗: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ログイン")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "メールアドレス",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "パスワード",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: handleLogin, // ログイン処理を呼び出し
              child: Text("ログイン"),
            ),
            TextButton(
              onPressed: handleSignUp, // 新規登録処理を呼び出し
              child: Text("新規登録"),
            ),
          ],
        ),
      ),
    );
  }
}
