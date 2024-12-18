part of 'base_screen_navigation_cubit.dart';

abstract class BaseScreenNavigationState {}

// class BaseScreenNavigationInitial extends BaseScreenNavigationState {
//   final HomeNavigationBarTabs navigationBarTab;
//   final int index;
//
//   BaseScreenNavigationInitial(
//       {required this.navigationBarTab, required this.index});
// }
class NavigationBarStateSucces extends BaseScreenNavigationState {}

class NevbarInitial extends BaseScreenNavigationState {}
class NavigationBarStateError   extends BaseScreenNavigationState {}