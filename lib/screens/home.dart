import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safal_portfolio/screens/profile/bloc/profile_bloc.dart';
import 'package:safal_portfolio/screens/profile/view/desktop_layout_page.dart';
import 'package:safal_portfolio/screens/profile/view/mobile_layout_page.dart';
import 'package:safal_portfolio/screens/profile/view/tablet_layout_page.dart';
import 'package:safal_portfolio/screens/widgets/rotating_image/rotating_image_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isRotatingImageLoaded = false;
  bool isProfileLoaded = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RotatingImageBloc, RotatingImageState>(
          listener: (context, state) {
            if (state is RotatingImageLoaded) {
              setState(() {
                isRotatingImageLoaded = true;
              });
            } else if (state is RotatingImageError) {
              // Handle error for rotating image
              setState(() {
                isRotatingImageLoaded = false;
              });
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              setState(() {
                isProfileLoaded = true;
              });
            } else if (state is ProfileError) {
              // Handle error for services data
              setState(() {
                isProfileLoaded = false;
              });
            }
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          // Check if both BLoCs are loaded
          if (!isRotatingImageLoaded || !isProfileLoaded) {
            return const Center(
                child: SpinKitFoldingCube(
              color: Colors.deepPurple,
            ));
          }

          // Once both are loaded, render the layout based on screen size
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return ProfileDesktopLayout();
              }
              if (constraints.maxWidth > 600) {
                return ProfileTabletLayout();
              } else {
                return const ProfileMobileLayout();
              }
            },
          );
        },
      ),
    );
  }
}
