import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/colors.dart';
import 'rotating_image_bloc.dart';

class RotatingImageContainer extends StatefulWidget {
  final Size size;

  const RotatingImageContainer({super.key, required this.size});

  @override
  State<RotatingImageContainer> createState() => _RotatingImageContainerState();
}

class _RotatingImageContainerState extends State<RotatingImageContainer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getHeightBasedOnSize(double width) {
    if (width > 900) return widget.size.width * 0.24;
    if (width > 600) return widget.size.width * 0.45;
    return widget.size.width * 0.60;
  }

  double _getWidthBasedOnSize(double width) {
    if (width > 900) return widget.size.width * 0.18;
    if (width > 600) return widget.size.width * 0.35;
    return widget.size.width * 0.45;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('RotatingImageContainer'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_hasAnimated) {
          _controller.forward();
          _hasAnimated = true;
        } else if (info.visibleFraction == 0 && _hasAnimated) {
          _hasAnimated = false;
        }
      },
      child: BlocBuilder<RotatingImageBloc, RotatingImageState>(
          builder: (context, state) {
        if (state is RotatingImageLoading) {
          return const SizedBox();
        }
        if (state is RotatingImageError) {
          return Text(state.errorMessage);
        }
        if (state is RotatingImageLoaded) {
          final profileData = state.profileImg;
          final hoverState = state.hoverState;
          final imageUrl = profileData['img'];

          if (imageUrl == null || imageUrl.isEmpty) {
            return const Text('No services data available.');
          }

          return SlideTransition(
            position: _offsetAnimation,
            child: MouseRegion(
              onEnter: (_) =>
                  context.read<RotatingImageBloc>().add(HoverEntered()),
              onExit: (_) =>
                  context.read<RotatingImageBloc>().add(HoverExited()),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.rotationZ(hoverState ? 0 : math.pi / 36),
                height: _getHeightBasedOnSize(widget.size.width),
                width: _getWidthBasedOnSize(widget.size.width),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageUrl),
                  ),
                  border: Border.all(color: AppColors.studioLight, width: 1.2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        }
        return const Text("No data");
      }),
    );
  }
}
