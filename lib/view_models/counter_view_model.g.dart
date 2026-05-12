// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CounterViewModel)
final counterViewModelProvider = CounterViewModelProvider._();

final class CounterViewModelProvider
    extends $NotifierProvider<CounterViewModel, Counter> {
  CounterViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counterViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counterViewModelHash();

  @$internal
  @override
  CounterViewModel create() => CounterViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Counter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Counter>(value),
    );
  }
}

String _$counterViewModelHash() => r'a6e476b13ecd0748356762e68b63ee23fa45ce9c';

abstract class _$CounterViewModel extends $Notifier<Counter> {
  Counter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Counter, Counter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Counter, Counter>,
              Counter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
