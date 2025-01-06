class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final List<String> tags; // タグを追加

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags, // タグを保存
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      tags: List<String>.from(map['tags'] ?? []), // タグを復元
    );
  }
}
