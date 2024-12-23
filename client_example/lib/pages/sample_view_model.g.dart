// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SampleViewModelStateImpl _$$SampleViewModelStateImplFromJson(
        Map<String, dynamic> json) =>
    _$SampleViewModelStateImpl(
      human: json['human'] == null
          ? null
          : Human.fromJson(json['human'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SampleViewModelStateImplToJson(
        _$SampleViewModelStateImpl instance) =>
    <String, dynamic>{
      'human': instance.human,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sampleViewModelHash() => r'7ba60f90b5c905b87de824115d691d52b0a3fba5';

/// See also [SampleViewModel].
@ProviderFor(SampleViewModel)
final sampleViewModelProvider = AutoDisposeAsyncNotifierProvider<
    SampleViewModel, SampleViewModelState>.internal(
  SampleViewModel.new,
  name: r'sampleViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sampleViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SampleViewModel = AutoDisposeAsyncNotifier<SampleViewModelState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
