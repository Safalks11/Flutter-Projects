import 'package:flutter/material.dart';
import 'package:safal_portfolio/screens/widgets/works_section.dart';

import '../../../constants/styles.dart';
import '../../widgets/contact_section.dart';
import '../../widgets/count_widget.dart';
import '../../widgets/download_cv_widget.dart';
import '../../widgets/header_text_widget.dart';
import '../../widgets/menu_section_widget.dart';
import '../../widgets/rotating_image/rotating_image_view.dart';
import '../../widgets/services/services_view.dart';
import '../../widgets/social_widget.dart';

class ProfileTabletLayout extends StatelessWidget {
  ProfileTabletLayout({super.key});
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
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: Styles.gradientDecoration,
            child: CustomScrollView(slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                centerTitle: true,
                toolbarHeight: 100,
                title: MenuSectionWidget(
                  size: size,
                  onProfileClick: () => _scrollToSection(_profileKey),
                  onServiceClick: () => _scrollToSection(_servicesKey),
                  onWorksClick: () => _scrollToSection(_worksKey),
                  onContactsClick: () => _scrollToSection(_contactsKey),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          key: _profileKey,
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Profile'),
                                    RotatingImageContainer(
                                      size: size,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.width * 0.09,
                                ),
                                Row(
                                  children: [
                                    HeaderTextWidget(
                                      size: size,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SocialTab(size: size)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CountSection(),
                        const SizedBox(
                          height: 50,
                        ),
                        MyServicesWidget(
                          key: _servicesKey,
                          size: size,
                        ),
                        WorksSection(
                          key: _worksKey,
                          size: size,
                        ),
                        ContactSection(key: _contactsKey, size: size),
                      ],
                    ),
                  ),
                ]),
              ),
            ])));
  }
}

class SocialTab extends StatelessWidget {
  const SocialTab({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DownloadCvWidget(),
          SizedBox(
            height: 20,
          ),
          SocialWidget(),
        ],
      ),
    );
  }
}
