part of 'services_bloc.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final Map<String, dynamic> serviceData;
  final List<bool> hoverState; // Added hoverState to manage hover interactions

  ServicesLoaded({required this.serviceData, required this.hoverState});
}

class ServiceError extends ServicesState {
  final String errorMessage;

  ServiceError({required this.errorMessage});
}
