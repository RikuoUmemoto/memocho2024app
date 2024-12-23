import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../di.dart';
import '../model/human.dart';

part 'sample_view_model.g.dart';

part 'sample_view_model.freezed.dart';

@freezed
class SampleViewModelState with _$SampleViewModelState {
  const factory SampleViewModelState({
    required Human? human,
  }) = _SampleViewModelState;

  factory SampleViewModelState.fromJson(Map<String, dynamic> json) =>
      _$SampleViewModelStateFromJson(json);
}

@riverpod
final class SampleViewModel extends _$SampleViewModel {
  @override
  FutureOr<SampleViewModelState> build() async {
    return const SampleViewModelState(
      human: null,
    );
  }

  Future<void> getHuman() async {
    final human = await ref.read(getHumanUseCaseProvider).getHuman();
    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(
        current.copyWith(
          human: human,
        ),
      );
    } else {
      state = AsyncValue.data(
        SampleViewModelState(
          human: human,
        ),
      );
    }
  }
}
