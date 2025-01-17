# memochou

メモ帳アプリです。  
2024年度法政大学アプリケーション開発演習の授業の最終課題として製作しました。  
ユーザーは自由にメモを追加、編集、削除することができます。また、Firebase Authenticationを使用したユーザー認証機能も搭載しており、各ユーザーが個別にメモを管理できるようになっています。  
データベースサーバーとして、Firestoreを使用しています。

# 説明
2024ミライケータイのアプリ開発にて主にバックエンドを担当しました。  
得られた知識を活かす力試しとして、FirebaseのFirestoreを利用してデータベースとの連携を実装しています。  
Firebase Authenticationを利用して、ユーザーごとにメモのデータを管理。ログインしているユーザーだけが自分のメモにアクセスできるようになっています。  
Firebase Firestoreを使用して、データのリアルタイム同期を実現しています。メモを追加、編集、削除した際、すべての変更が即座にクラウド上で反映されます。

# 便利機能
- **検索機能**: ユーザーはメモをタイトルや内容で検索でき、素早く目的のメモを見つけられます。  
- **タグ機能**: メモにタグを付けて分類することができ、タグを使って関連するメモを簡単に表示できます。  
- **オフライン**: Firestoreのオフライン機能を活用し、インターネット接続がない場合でもメモを操作できるようになっています。  
- **自動同期**: 接続が復帰すると、自動的にデータが同期されます。

# 動作環境
- **Flutter SDK**: version ^3.5.3
- **firebase_auth**: version ^4.5.0（Firebase Authentication）
- **firebase_auth_web**: version ^5.8.14（Firebase Authentication for Web）
- **firebase_core**: version ^2.32.0（Firebase Core）
- **cloud_firestore**: version ^4.17.5（Firestore）
- **flutterfire_cli**: version ^1.0.0（FlutterFire CLI）
- **cupertino_icons**: version ^1.0.8（Cupertinoアイコン）

# 動作プラットフォーム
- **Android**: Androidで動作する前提でfirebase等の設定を行っていますが、動作確認ができていません。
- **Web**: ChromeやEdgeブラウザでの動作確認が完了しています。

# データ階層
Firestore<br>
├── users (コレクション)<br>
│   ├── {userID} (ドキュメント)<br>
│       ├── username: string<br>
│       ├── email: string<br>
│       ├── profileImageURL: string<br>
│       └── notes (サブコレクション)<br>
│           ├── {noteID} (ドキュメント)<br>
│               ├── title: string<br>
│               ├── content: string<br>
│               ├── tags: array<string><br>
│               ├── createdAt: timestamp<br>
│               ├── updatedAt: timestamp<br>
