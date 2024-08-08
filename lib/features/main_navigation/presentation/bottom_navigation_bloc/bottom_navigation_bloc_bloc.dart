import 'package:fixit_provider/features/main_navigation/presentation/bottom_navigation_bloc/bottom_navigation_bloc_event.dart';
import 'package:fixit_provider/features/main_navigation/presentation/bottom_navigation_bloc/bottom_navigation_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationBloc
    extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(MainNavigationState(0)) {
    on<NavigateToIndex>(
        (event, emit) => emit(MainNavigationState(event.index)));
  }
}
