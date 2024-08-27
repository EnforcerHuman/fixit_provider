import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/authentication/data/datasources/service_provider_repository.dart';
import 'package:fixit_provider/features/authentication/data/model/location.dart';
import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';
import 'package:fixit_provider/features/authentication/domain/usecases/store_service_provider_data.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_state.dart';

class ServiceProviderBloc
    extends Bloc<ServiceProviderEvent, ServiceProviderState> {
  ServiceProviderBloc() : super(ServiceProviderInitial()) {
    on<UpdateName>(_onUpdateName);
    on<UpdateEmail>(_onUpdateEmail);
    // on<UpdatePhoneNumber>(_onUpdatePhoneNumber);
    on<UpdateBusinessName>(_onUpdateBusinessName);
    on<UpdateLocation>(_onUpdateLocation);
    on<UpdateUserId>(_onUpdateId);
    on<UpdateBusinessAdress>(_onUpdateBusinessAdress);
    on<UpdateExperience>(_onUpdateExperience);
    on<UpdateServiceType>(_onUpdateServiceType);
    on<UpdateArea>(_onUpdateArea);
    on<UpdateWorkingFrom>(_onUpdateWorkingFrom);
    on<UpdateWorkingUntil>(_onUpdateWorkingUntil);
    on<UpdateLicense>(_onUpdateLicense);
    on<UpdateCertificate>(_onUpdateCertification);
    on<UpdatePhoto>(_onUpdatePhoto);
    on<UpdateHourlyPayment>(_onUpdateHourlyPayment);
    on<UpdateMoreInfo>(_onUdateMoreInfo);
    on<UpdateIsVerified>(_onUpdateIsVerified);
    on<SubmitServiceProvider>(_onSubmitServiceProvider);
    on<UpdatePhoneNumber>((event, emit) async {
      _serviceProvider =
          _serviceProvider.copyWith(phoneNumber: event.phoneNumber);

      emit(ServiceProviderLoaded(_serviceProvider));
    });
  }

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

  void _onUpdateName(UpdateName event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(name: event.name);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(email: event.email);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateBusinessName(
      UpdateBusinessName event, Emitter<ServiceProviderState> emit) async {
    _serviceProvider = _serviceProvider.copyWith(name: event.businessName);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  // void _onUpdatePhoneNumber(
  //     UpdatePhoneNumber event, Emitter<ServiceProviderState> emit) {
  //   _serviceProvider =
  //       _serviceProvider.copyWith(phoneNumber: event.phoneNumber);
  // }

  void _onUpdateLocation(
      UpdateLocation event, Emitter<ServiceProviderState> emit) async {
    _serviceProvider = _serviceProvider.copyWith(location: event.location);

    await FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(_serviceProvider.id)
        .set(_serviceProvider.toJson()

            // Add any other user data here
            );
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateId(UpdateUserId event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(id: event.id);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateBusinessAdress(
      UpdateBusinessAdress event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(businessAddress: event.businessAdress);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateExperience(
      UpdateExperience event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(experience: event.experience);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateServiceType(
      UpdateServiceType event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(serviceTypes: event.serviceType);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateArea(UpdateArea event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(serviceArea: event.serviceArea);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateWorkingFrom(
      UpdateWorkingFrom event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(workingFrom: event.workingFrom);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateWorkingUntil(
      UpdateWorkingUntil event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(workingTo: event.workingUntil);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateLicense(
      UpdateLicense event, Emitter<ServiceProviderState> emit) {
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateCertification(
      UpdateCertificate event, Emitter<ServiceProviderState> state) {
    _serviceProvider =
        _serviceProvider.copyWith(certificate: event.certificate);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdatePhoto(UpdatePhoto event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(profileImage: event.profilePhoto);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateHourlyPayment(
      UpdateHourlyPayment event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(hourlyPay: event.hourlyPay);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUdateMoreInfo(
      UpdateMoreInfo event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(info: event.moreInfo);
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateIsVerified(
      UpdateIsVerified event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(isVerified: event.isverified);

    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onSubmitServiceProvider(
      SubmitServiceProvider event, Emitter<ServiceProviderState> emit) async {
    emit(ServiceProviderCreating());
    StoreServiceProviderData storeServiceProviderData =
        StoreServiceProviderData(ServiceProviderRepository());
    bool saved = await storeServiceProviderData(_serviceProvider);
    if (saved) {
      emit(ServiceProviderCreated());
    } else {
      emit(ServiceProviderError('Someting is happeneed'));
    }
  }

  Future<void> storeServiceProviderData() async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('ServiceProviders');

    // Add more fields as necessary

    if (_serviceProvider.id.isEmpty) {
      return;
    }

    try {
      await collectionRef
          .doc(_serviceProvider.id)
          .set(_serviceProvider.toJson());
    } on FirebaseException catch (e) {
      //
    } catch (e) {
      //
    }
  }
}
