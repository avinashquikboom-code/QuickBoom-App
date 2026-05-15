// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SidebarSelection)
final sidebarSelectionProvider = SidebarSelectionProvider._();

final class SidebarSelectionProvider
    extends $NotifierProvider<SidebarSelection, SidebarItem> {
  SidebarSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sidebarSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sidebarSelectionHash();

  @$internal
  @override
  SidebarSelection create() => SidebarSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SidebarItem value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SidebarItem>(value),
    );
  }
}

String _$sidebarSelectionHash() => r'6808cd7cfd02387f858aca3cc8f76dd3ca95f34c';

abstract class _$SidebarSelection extends $Notifier<SidebarItem> {
  SidebarItem build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SidebarItem, SidebarItem>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SidebarItem, SidebarItem>,
              SidebarItem,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
