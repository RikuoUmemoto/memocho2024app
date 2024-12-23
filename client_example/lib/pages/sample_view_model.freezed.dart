// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SampleViewModelState _$SampleViewModelStateFromJson(Map<String, dynamic> json) {
  return _SampleViewModelState.fromJson(json);
}

/// @nodoc
mixin _$SampleViewModelState {
  Human? get human => throw _privateConstructorUsedError;

  /// Serializes this SampleViewModelState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SampleViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SampleViewModelStateCopyWith<SampleViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleViewModelStateCopyWith<$Res> {
  factory $SampleViewModelStateCopyWith(SampleViewModelState value,
          $Res Function(SampleViewModelState) then) =
      _$SampleViewModelStateCopyWithImpl<$Res, SampleViewModelState>;
  @useResult
  $Res call({Human? human});

  $HumanCopyWith<$Res>? get human;
}

/// @nodoc
class _$SampleViewModelStateCopyWithImpl<$Res,
        $Val extends SampleViewModelState>
    implements $SampleViewModelStateCopyWith<$Res> {
  _$SampleViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SampleViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? human = freezed,
  }) {
    return _then(_value.copyWith(
      human: freezed == human
          ? _value.human
          : human // ignore: cast_nullable_to_non_nullable
              as Human?,
    ) as $Val);
  }

  /// Create a copy of SampleViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HumanCopyWith<$Res>? get human {
    if (_value.human == null) {
      return null;
    }

    return $HumanCopyWith<$Res>(_value.human!, (value) {
      return _then(_value.copyWith(human: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SampleViewModelStateImplCopyWith<$Res>
    implements $SampleViewModelStateCopyWith<$Res> {
  factory _$$SampleViewModelStateImplCopyWith(_$SampleViewModelStateImpl value,
          $Res Function(_$SampleViewModelStateImpl) then) =
      __$$SampleViewModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Human? human});

  @override
  $HumanCopyWith<$Res>? get human;
}

/// @nodoc
class __$$SampleViewModelStateImplCopyWithImpl<$Res>
    extends _$SampleViewModelStateCopyWithImpl<$Res, _$SampleViewModelStateImpl>
    implements _$$SampleViewModelStateImplCopyWith<$Res> {
  __$$SampleViewModelStateImplCopyWithImpl(_$SampleViewModelStateImpl _value,
      $Res Function(_$SampleViewModelStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SampleViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? human = freezed,
  }) {
    return _then(_$SampleViewModelStateImpl(
      human: freezed == human
          ? _value.human
          : human // ignore: cast_nullable_to_non_nullable
              as Human?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SampleViewModelStateImpl implements _SampleViewModelState {
  const _$SampleViewModelStateImpl({required this.human});

  factory _$SampleViewModelStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleViewModelStateImplFromJson(json);

  @override
  final Human? human;

  @override
  String toString() {
    return 'SampleViewModelState(human: $human)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleViewModelStateImpl &&
            (identical(other.human, human) || other.human == human));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, human);

  /// Create a copy of SampleViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleViewModelStateImplCopyWith<_$SampleViewModelStateImpl>
      get copyWith =>
          __$$SampleViewModelStateImplCopyWithImpl<_$SampleViewModelStateImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleViewModelStateImplToJson(
      this,
    );
  }
}

abstract class _SampleViewModelState implements SampleViewModelState {
  const factory _SampleViewModelState({required final Human? human}) =
      _$SampleViewModelStateImpl;

  factory _SampleViewModelState.fromJson(Map<String, dynamic> json) =
      _$SampleViewModelStateImpl.fromJson;

  @override
  Human? get human;

  /// Create a copy of SampleViewModelState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SampleViewModelStateImplCopyWith<_$SampleViewModelStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
