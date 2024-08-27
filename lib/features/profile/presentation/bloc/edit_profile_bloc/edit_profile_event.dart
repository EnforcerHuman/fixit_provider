part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

final class SetInitialValues extends EditProfileEvent {
  final Map<String, dynamic> serviceProvider;

  SetInitialValues(this.serviceProvider);
}

final class UpdateValues extends EditProfileEvent {
  final String hourlyPayment;
  final String experience;
  final String description;
  UpdateValues(
    this.hourlyPayment,
    this.experience,
    this.description,
  );
}
