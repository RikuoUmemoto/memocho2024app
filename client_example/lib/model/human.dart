import 'package:freezed_annotation/freezed_annotation.dart';

part 'human.freezed.dart';

part 'human.g.dart';

@freezed
abstract class Human with _$Human {
  const factory Human({
    required String name,
    required int age,
  }) = _Human;

  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);
}
