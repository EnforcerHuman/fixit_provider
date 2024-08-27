import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/domain/usecases/service_type_converting.dart';
import 'package:meta/meta.dart';

part 'service_type_event.dart';
part 'service_type_state.dart';

class ServiceTypeBloc extends Bloc<ServiceTypeEvent, ServiceTypeState> {
  final ServiceTypeConverting serviceTypeConverting;
  ServiceTypeBloc(this.serviceTypeConverting) : super(ServiceTypeInitial()) {
    on<LoadServices>((event, emit) async {
      try {
        await emit.forEach<List<String>>(
          serviceTypeConverting.execute(),
          onData: (services) => ServiceTypesLoaded(services),
          onError: (error, stackTrace) {
            return ServiceTypeError();
          },
        );
      } catch (e) {
        emit(ServiceTypeError());
      }
    });
  }
}
