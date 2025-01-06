import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart'; // HomeScreenをインポート

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebaseの初期化
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'メモ帳',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // 初期画面を設定
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(), // '/login' ルートを追加
      },
      debugShowCheckedModeBanner: false, // Debugタグを非表示にする
    );
  }
}
