import 'package:fixit_provider/features/authentication/data/datasources/get_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocation getCurrentLocation;

  LocationBloc({required this.getCurrentLocation}) : super(LocationInitial()) {
    on<GetLocationEvent>(_onGetLocation);
    on<SelectLocationEvent>(_onSelectLocation);
  }

  Future<void> _onGetLocation(
      GetLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final position = await getCurrentLocation();
      emit(LocationLoaded(position: position));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  void _onSelectLocation(
      SelectLocationEvent event, Emitter<LocationState> emit) {
    print(' Location : ${event.position}');
    print(event.adress);
    emit(LocationSelected(event.adress, selectedPosition: event.position));
  }
}
