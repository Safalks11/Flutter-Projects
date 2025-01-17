import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safal_portfolio/screens/profile/bloc/profile_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/colors.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const SizedBox();
        } else if (state is ProfileLoaded) {
          final profileData = state.profileData;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.studioLight.withOpacity(0.5))),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      launchUrlString('${profileData['linkedin']}');
                    },
                    hoverColor: AppColors.paleSlate,
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedinIn,
                      color: AppColors.studioLight,
                      size: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.studioLight.withOpacity(0.5))),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      launchUrlString('${profileData['instagram']}');
                    },
                    hoverColor: AppColors.paleSlate,
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: AppColors.studioLight,
                      size: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.studioLight.withOpacity(0.5))),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      launchUrlString('${profileData['whatsapp']}');
                    },
                    hoverColor: AppColors.paleSlate,
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.studioLight,
                      size: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.studioLight.withOpacity(0.5))),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      launchUrlString('${profileData['github']}');
                    },
                    hoverColor: AppColors.paleSlate,
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: AppColors.studioLight,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Social widget error'));
        }
      },
    );
  }
}
