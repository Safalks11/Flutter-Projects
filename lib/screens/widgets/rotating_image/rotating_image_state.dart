part of 'rotating_image_bloc.dart';

abstract class RotatingImageState {}

class RotatingImageInitial extends RotatingImageState {}

class RotatingImageLoading extends RotatingImageState {}

class RotatingImageLoaded extends RotatingImageState {
  final Map<String, dynamic> profileImg;
  final bool hoverState;
  RotatingImageLoaded({required this.profileImg, required this.hoverState});
}

class HoverInProgress extends RotatingImageState {
  final bool isHovered;
  HoverInProgress(this.isHovered);
}

class RotatingImageError extends RotatingImageState {
  final String errorMessage;
  RotatingImageError({required this.errorMessage});
}
