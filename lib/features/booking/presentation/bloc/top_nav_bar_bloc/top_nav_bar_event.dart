part of 'top_nav_bar_bloc.dart';

@immutable
sealed class TopNavBarEvent {}

class NavigateToIndex extends TopNavBarEvent {
  final int index;

  NavigateToIndex(this.index);
}
