import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safal_portfolio/screens/profile/bloc/profile_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/colors.dart';

class DownloadCvWidget extends StatelessWidget {
  const DownloadCvWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return const SizedBox();
      } else if (state is ProfileLoaded) {
        final profileData = state.profileData;
        return Container(
          height: 50,
          width: 225,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border:
                  Border.all(color: AppColors.studioLight.withOpacity(0.5))),
          child: TextButton.icon(
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(AppColors.studioLight),
                overlayColor: WidgetStateProperty.all(AppColors.paleSlate)),
            iconAlignment: IconAlignment.end,
            onPressed: () {launchUrlString('${profileData['resume']}');},
            label: const Text(
              'Download CV',
              style: TextStyle(
                  color: AppColors.studioLight, fontFamily: 'Poppins'),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.download,
              color: AppColors.studioLight,
              size: 18,
            ),
          ),
        );
      } else {
        return Text('No Data');
      }
    });
  }
}
