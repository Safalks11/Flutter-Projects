import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class MenuSectionWidget extends StatelessWidget {
  final Size size;
  final VoidCallback onProfileClick;
  final VoidCallback onServiceClick;
  final VoidCallback onWorksClick;
  final VoidCallback onContactsClick;
  const MenuSectionWidget({
    super.key,
    required this.size,
    required this.onProfileClick,
    required this.onServiceClick,
    required this.onWorksClick,
    required this.onContactsClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width > 900
          ? size.width * 0.40
          : size.width > 600
              ? size.width * 0.60
              : size.width * 0.70,
      margin: size.width > 900
          ? const EdgeInsets.only(top: 20)
          : size.width > 600
              ? const EdgeInsets.symmetric(horizontal: 75, vertical: 50)
              : const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.appBarColor,
          border: Border.all(color: AppColors.paleSlate.withOpacity(0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(AppColors.rouge),
            ),
            onPressed: onProfileClick,
            child: const Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(AppColors.rouge)),
              onPressed: onServiceClick,
              child: const Text(
                'Services',
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              )),
          TextButton(
              style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(AppColors.rouge)),
              onPressed: onWorksClick,
              child: const Text(
                'Works',
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              )),
          TextButton(
              style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(AppColors.rouge)),
              onPressed: onContactsClick,
              child: const Text(
                'Contact',
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              )),
        ],
      ),
    );
  }
}
