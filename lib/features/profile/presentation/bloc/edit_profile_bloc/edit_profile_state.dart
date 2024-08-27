part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class ProfileEdited extends EditProfileState {}

final class ProfileEditFailed extends EditProfileState {}

final class ProfileEditing extends EditProfileState {}
