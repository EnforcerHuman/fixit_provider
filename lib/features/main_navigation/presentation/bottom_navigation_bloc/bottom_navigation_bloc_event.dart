abstract class MainNavigationEvent {}

class NavigateToIndex extends MainNavigationEvent {
  final int index;
  NavigateToIndex(this.index);
}
