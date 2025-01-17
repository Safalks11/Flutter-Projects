part of 'rotating_image_bloc.dart';

abstract class RotatingImageEvent {}

final class FetchProfileImg extends RotatingImageEvent {}

class HoverEntered extends RotatingImageEvent {}

class HoverExited extends RotatingImageEvent {}
