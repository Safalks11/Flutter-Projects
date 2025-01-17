import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safal_portfolio/screens/widgets/social_widget.dart';
import 'package:safal_portfolio/screens/widgets/text_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants/colors.dart';
import '../profile/bloc/profile_bloc.dart';
import 'download_cv_widget.dart';

class HeaderTextWidget extends StatefulWidget {
  final Size size;

  const HeaderTextWidget({super.key, required this.size});

  @override
  State<HeaderTextWidget> createState() => _HeaderTextWidgetState();
}

class _HeaderTextWidgetState extends State<HeaderTextWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInSine,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return const SizedBox();
      } else if (state is ProfileLoaded) {
        final profileData = state.profileData;

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: widget.size.width * 0.07,
          ),
          child: Column(
            crossAxisAlignment: widget.size.width > 900
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                sSize: widget.size,
                text: "I am ${profileData['name']}",
                color: Colors.white70,
                size: 26,
                fw: FontWeight.bold,
                alignment: TextAlign.center,
              ),
              ScaleTransition(
                scale: _animation,
                child: GradientTextWidget(
                  size: widget.size,
                  alignment: TextAlign.center,
                  text1: "${profileData['role']}",
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: widget.size.width * 0.5,
                child: TextWidget(
                    sSize: widget.size,
                    alignment: TextAlign.center,
                    text: "${profileData['aboutme']}",
                    size: 16,
                    color: Colors.white54,
                    fw: FontWeight.normal),
              ),
            ],
          ),
        );
      } else {
        return const Center(child: Text('Welcome to Profile Page'));
      }
    });
  }
}

class GradientTextWidget extends StatelessWidget {
  final TextAlign? alignment;
  final String? text1;
  final Color? color1;
  final Color? color2;
  final double? fsize;
  final FontWeight? fw;

  const GradientTextWidget(
      {super.key,
      required this.size,
      this.alignment,
      this.fw,
      this.color1,
      this.text1,
      this.color2,
      this.fsize});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      textAlign: size.width < 900 && alignment != null ? alignment : null,
      "$text1".replaceAll('\\n', '\n'),
      colors: const [
        AppColors.studio,
        AppColors.paleSlate,
      ],
      style: TextStyle(
        fontSize: size.width * 0.040,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SocialLarge extends StatelessWidget {
  const SocialLarge({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.5,
      child: const Row(
        children: [
          DownloadCvWidget(),
          SizedBox(
            width: 20,
          ),
          SocialWidget()
        ],
      ),
    );
  }
}
