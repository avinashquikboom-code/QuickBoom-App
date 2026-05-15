import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'constants.dart';

part 'providers.g.dart';

@riverpod
class SidebarSelection extends _$SidebarSelection {
  @override
  SidebarItem build() => SidebarItem.dashboard;

  void select(SidebarItem item) => state = item;
}
