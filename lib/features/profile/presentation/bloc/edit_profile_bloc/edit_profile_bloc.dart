import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/model/location.dart';
import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';
import 'package:fixit_provider/features/profile/data/service_provider_data_source.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ServiceProviderDataSource serviceProviderDataSource;
  ServiceProvider _serviceProvider = ServiceProvider(
    id: '',
    name: '',
    email: '',
    phoneNumber: '',
    location: Location(latitude: 0.0, longitude: 0.0, address: ''),
    serviceTypes: '',
    rating: 0.0,
    profileImage: '',
    certificate: null,
    license: null,
    hourlyPay: '',
    registrationDate: DateTime.now(),
    isVerified: false,
    experience: '',
    workingFrom: '',
    workingTo: '',
    skills: '',
    businessAddress: '',
    info: '',
    serviceArea: '',
  );
  EditProfileBloc(this.serviceProviderDataSource)
      : super(EditProfileInitial()) {
    on<SetInitialValues>((event, emit) {
      _serviceProvider = ServiceProvider.fromJson(event.serviceProvider);
    });

    on<UpdateValues>((event, emit) async {
      _serviceProvider =
          _serviceProvider.copyWith(hourlyPay: event.hourlyPayment);
      _serviceProvider =
          _serviceProvider.copyWith(experience: event.experience);
      _serviceProvider = _serviceProvider.copyWith(info: event.description);

      try {
        serviceProviderDataSource.updateProviderDetails(
            _serviceProvider.id, _serviceProvider);
        emit(ProfileEdited());
      } catch (e) {
        emit(ProfileEditFailed());
      }
    });
  }
}
