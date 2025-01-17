import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CountSection extends StatelessWidget {
  const CountSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: size.width > 900
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountWidget(
                  size: size,
                  text1: '1',
                  text2: "+",
                  text3: "Years of \nExperience",
                ),
                CountWidget(
                  size: size,
                  text1: '5',
                  text2: "+",
                  text3: "Projects \nCompleted",
                ),
                CountWidget(
                  size: size,
                  text1: '2',
                  text2: "+",
                  text3: "Live \nProject",
                ),
                CountWidget(
                  size: size,
                  text1: '1',
                  text2: "",
                  text3: "App on \nPlaystore",
                ),
              ],
            )
          : Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountWidget(
                    size: size,
                    text1: '1',
                    text2: "+",
                    text3: "Years of \nExperience",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: AppColors.paleSlate,
                    indent: size.width * 0.05,
                    endIndent: size.width * 0.05,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CountWidget(
                    size: size,
                    text1: '5',
                    text2: "",
                    text3: "Projects \nCompleted",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: AppColors.paleSlate,
                    indent: size.width * 0.05,
                    endIndent: size.width * 0.05,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CountWidget(
                    size: size,
                    text1: '2',
                    text2: "+",
                    text3: "Live \nProject",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: AppColors.paleSlate,
                    indent: size.width * 0.05,
                    endIndent: size.width * 0.05,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CountWidget(
                    size: size,
                    text1: '1',
                    text2: "",
                    text3: "App on \nPlaystore",
                  ),
                ],
              ),
            ),
    );
  }
}

class CountWidget extends StatelessWidget {
  final Size size;
  final String text1;
  final String text2;
  final String text3;
  const CountWidget(
      {super.key,
      required this.size,
      required this.text2,
      required this.text3,
      required this.text1});

  @override
  Widget build(BuildContext context) {
    final int targetValue = int.tryParse(text1) ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: targetValue),
          duration: const Duration(milliseconds: 1500), // Animation duration
          builder: (context, value, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$value', // Animated number
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.04,
                  ),
                ),
                SizedBox(width: 3),
                Text(
                  text2,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.03,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text3,
          style: TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
          ),
        )
      ],
    );
  }
}
