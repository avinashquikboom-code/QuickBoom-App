import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/counter.dart';

part 'counter_view_model.g.dart';

@riverpod
class CounterViewModel extends _$CounterViewModel {
  @override
  Counter build() {
    return const Counter(value: 0);
  }

  void increment() {
    state = state.copyWith(value: state.value + 1);
  }
}
