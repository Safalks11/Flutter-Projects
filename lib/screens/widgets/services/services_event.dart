part of 'services_bloc.dart';

abstract class ServicesEvent {}

final class FetchServicesData extends ServicesEvent {}

class HoverEntered extends ServicesEvent {
  final int index;
  HoverEntered(this.index);
}

class HoverExited extends ServicesEvent {
  final int index;
  HoverExited(this.index);
}
