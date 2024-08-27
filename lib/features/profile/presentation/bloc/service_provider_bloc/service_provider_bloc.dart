import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/profile/domain/usecases/get_provider_details.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'service_provider_event.dart';
part 'service_provider_state.dart';

class ServiceProviderDetailsBloc
    extends Bloc<ServiceProviderEvent, ServiceProviderDetailsState> {
  final GetProviderDetails getProviderDetails;
  ServiceProviderDetailsBloc(this.getProviderDetails)
      : super(ServiceProviderInitial()) {
    on<GetServiceProviderData>((event, emit) async {
      try {
        await emit.forEach<Map<String, dynamic>>(
          getProviderDetails.execute(),
          onData: (data) => ServiceProviderDataLoaded(data),
          onError: (error, stackTrace) =>
              ServiceProviderDataError(error.toString()),
        );
      } catch (e) {
        emit(ServiceProviderDataError(e.toString()));
      }
    });
  }
}
