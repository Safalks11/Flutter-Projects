part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;
  final Map<String, dynamic> projectData;

  ProfileLoaded({
    required this.profileData,
    required this.projectData,
  });
}

final class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError({required this.errorMessage});
}
