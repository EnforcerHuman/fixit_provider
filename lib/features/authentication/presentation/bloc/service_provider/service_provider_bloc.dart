import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixit_provider/features/authentication/data/datasources/firebase_storage_services.dart';
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

      print('Current ServiceProvider State: ${_serviceProvider.name}');
      print('Current ServiceProvider State: ${_serviceProvider.phoneNumber}');
      print(
          '***************************************************************************');
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
    print('Current ServiceProvider State: ${_serviceProvider.name}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(email: event.email);
    print('Current ServiceProvider State: ${_serviceProvider.email}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateBusinessName(
      UpdateBusinessName event, Emitter<ServiceProviderState> emit) async {
    _serviceProvider = _serviceProvider.copyWith(name: event.businessName);
    print('Current ServiceProvider State: ${_serviceProvider.name}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdatePhoneNumber(
      UpdatePhoneNumber event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(phoneNumber: event.phoneNumber);
    print('Current ServiceProvider State: $_serviceProvider');
  }

  void _onUpdateLocation(
      UpdateLocation event, Emitter<ServiceProviderState> emit) async {
    _serviceProvider = _serviceProvider.copyWith(location: event.location);
    print('Current ServiceProvider State: ${_serviceProvider.name}');
    print('Current ServiceProvider State: ${_serviceProvider.phoneNumber}');
    print('Current ServiceProvider State: ${_serviceProvider.email}');
    print('Current ServiceProvider State: ${_serviceProvider.location}');
    print('Current ServiceProvider State: ${_serviceProvider.businessAddress}');
    await FirebaseFirestore.instance
        .collection('serviceProviders')
        .doc(_serviceProvider.id)
        .set(_serviceProvider.toJson()

            // Add any other user data here
            );
    print('Current ServiceProvider State: $_serviceProvider');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateId(UpdateUserId event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(id: event.id);
    print('Current ServiceProvider State: ${_serviceProvider.id}');
    print(
        '***************************************************************************');
    print(
        '***************************************************************************');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateBusinessAdress(
      UpdateBusinessAdress event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(businessAddress: event.businessAdress);
    print(
        'Current ServiceProvider State businedss adress: ${_serviceProvider.businessAddress}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateExperience(
      UpdateExperience event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(experience: event.experience);
    print('Current ServiceProvider State: ${_serviceProvider.experience}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateServiceType(
      UpdateServiceType event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(serviceTypes: event.serviceType);
    print(
        'Current ServiceProvider State service type: ${_serviceProvider.serviceTypes}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateArea(UpdateArea event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(serviceArea: event.serviceArea);
    print(
        'Current ServiceProvider State service area: ${_serviceProvider.serviceArea}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateWorkingFrom(
      UpdateWorkingFrom event, Emitter<ServiceProviderState> emit) {
    _serviceProvider =
        _serviceProvider.copyWith(workingFrom: event.workingFrom);
    print(
        'Current ServiceProvider State working from: ${_serviceProvider.workingFrom}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateWorkingUntil(
      UpdateWorkingUntil event, Emitter<ServiceProviderState> emit) {
    _serviceProvider = _serviceProvider.copyWith(workingTo: event.workingUntil);
    print(
        'Current ServiceProvider Stat working to: ${_serviceProvider.workingTo}');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateLicense(
      UpdateLicense event, Emitter<ServiceProviderState> emit) {
    print(event.license);
    _serviceProvider = _serviceProvider.copyWith(license: event.license);
    print('Current ServiceProvider State: ${_serviceProvider.license}');
    print(
        '***************************************************************************');
    print(
        '***************************************************************************');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateCertification(
      UpdateCertificate event, Emitter<ServiceProviderState> state) {
    _serviceProvider =
        _serviceProvider.copyWith(certificate: event.certificate);
    print('Current ServiceProvider State: ${_serviceProvider.certificate}');
    print(
        '***************************************************************************');
    print(
        '***************************************************************************');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdatePhoto(UpdatePhoto event, Emitter<ServiceProviderState> emit) {
    print('photo is : ${event.profilePhoto}');
    _serviceProvider =
        _serviceProvider.copyWith(profileImage: event.profilePhoto);
    print('Current ServiceProvider State: ${_serviceProvider.profileImage}');
    print(
        '***************************************************************************');
    print(
        '***************************************************************************');
    emit(ServiceProviderLoaded(_serviceProvider));
  }

  void _onUpdateHourlyPayment(
      UpdateHourlyPayment event, Emitter<ServiceProviderState> emit) {
    print('PAyemt per hour is : ${event.hourlyPay}');
    _serviceProvider = _serviceProvider.copyWith(hourlyPay: event.hourlyPay);
    print('Current ServiceProvider State: ${_serviceProvider.hourlyPay}');
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
    print('Current ServiceProvider State: ${_serviceProvider.profileImage}');
    print(
        'Current ServiceProvider State certificate : ${_serviceProvider.certificate}');
    print(
        'Current ServiceProvider Stat working to: ${_serviceProvider.workingTo}');
    print(
        '***************************************************************************');
    print(
        '***************************************************************************');
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

    print('Attempting to store data for Service Provider');
    print(' Hourly Pay  ${_serviceProvider.hourlyPay}');
    print('ID: ${_serviceProvider.id}');
    print('Name: ${_serviceProvider.name}');
    print('Email: ${_serviceProvider.email}');
    print('Phone: ${_serviceProvider.phoneNumber}');
    print('##&&&&&&&&&&@@@@@@@@@@@@@@@@*****&&&&&&&&&');
    // Add more fields as necessary

    if (_serviceProvider.id.isEmpty) {
      print('Error: Service Provider ID is empty despite expectation');
      return;
    }

    try {
      await collectionRef
          .doc(_serviceProvider.id)
          .set(_serviceProvider.toJson());
      print('ServiceProvider data stored successfully!');
    } on FirebaseException catch (e) {
      print('FirebaseException while storing ServiceProvider data:');
      print('Error message: ${e.message}');
      print('Error code: ${e.code}');
      print('Error details: ${e.toString()}');
    } catch (e) {
      print('Unexpected error while storing ServiceProvider data:');
      print(e.toString());
      print(StackTrace.current);
    }
  }
}
