part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class FetchProfileData extends ProfileEvent {}

final class FetchProjectData extends ProfileEvent {}
