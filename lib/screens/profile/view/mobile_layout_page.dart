import 'package:flutter/material.dart';
import 'package:safal_portfolio/screens/profile/view/tablet_layout_page.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import '../../widgets/contact_section.dart';
import '../../widgets/count_widget.dart';
import '../../widgets/header_text_widget.dart';
import '../../widgets/rotating_image/rotating_image_view.dart';
import '../../widgets/services/services_view.dart';
import '../../widgets/works_section.dart';

class ProfileMobileLayout extends StatefulWidget {
  const ProfileMobileLayout({super.key});

  @override
  State<ProfileMobileLayout> createState() => _ProfileMobileLayoutState();
}

class _ProfileMobileLayoutState extends State<ProfileMobileLayout> {
  final ScrollController _scrollController = ScrollController();

  static final GlobalKey _profileKey = GlobalKey();
  static final GlobalKey _servicesKey = GlobalKey();
  static final GlobalKey _worksKey = GlobalKey();
  static final GlobalKey _contactsKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leading: PopupMenuButton(
          color: AppColors.studio,
          icon: const Icon(
            Icons.menu,
            color: AppColors.paleSlate,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(AppColors.rouge),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the menu
                    _scrollToSection(_profileKey); // Scroll to Profile
                  }, // Scroll to Profile
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(AppColors.rouge),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _scrollToSection(_servicesKey);
                  },
                  child: const Text(
                    'Services',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(AppColors.rouge),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _scrollToSection(_worksKey);
                  },
                  child: const Text(
                    'Works',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(AppColors.rouge),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the menu
                    _scrollToSection(_contactsKey);
                  },
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Styles.gradientDecoration,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController, // Attach ScrollController
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      key: _profileKey, // Assign GlobalKey to Profile Section
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: size.width * 0.040,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatingImageContainer(
                          size: size,
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.09,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                HeaderTextWidget(
                                  size: size,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SocialTab(size: size)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.09,
                    ),
                    const CountSection(),
                    SizedBox(
                      height: size.width * 0.09,
                    ),
                    MyServicesWidget(
                      size: size,
                      key: _servicesKey,
                    ),
                    WorksSection(
                      size: size,
                      key: _worksKey,
                    ),
                    ContactSection(
                      size: size,
                      key: _contactsKey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
