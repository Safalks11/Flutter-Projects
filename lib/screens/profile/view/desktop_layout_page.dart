import 'package:flutter/material.dart';
import 'package:safal_portfolio/screens/widgets/contact_section.dart';

import '../../../constants/styles.dart';
import '../../widgets/count_widget.dart';
import '../../widgets/header_text_widget.dart';
import '../../widgets/menu_section_widget.dart';
import '../../widgets/rotating_image/rotating_image_view.dart';
import '../../widgets/services/services_view.dart';
import '../../widgets/works_section.dart';

class ProfileDesktopLayout extends StatelessWidget {
  ProfileDesktopLayout({super.key});
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
        decoration: Styles.gradientDecoration,
        child: CustomScrollView(
          slivers: [
            // SliverAppBar to show/hide MenuSectionWidget when scrolling
            SliverAppBar(
              key: _profileKey,
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
            // Rest of the body content
            SliverList(
                delegate: SliverChildListDelegate(
              [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.50,
                        margin:
                            EdgeInsets.symmetric(vertical: size.height * 0.10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HeaderTextWidget(size: size),
                                const SizedBox(height: 25),
                                SocialLarge(size: size),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RotatingImageContainer(size: size),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CountSection(),
                      SizedBox(height: size.height * 0.12),
                      MyServicesWidget(
                        size: size,
                        key: _servicesKey,
                      ),
                      WorksSection(
                        key: _worksKey,
                        size: size,
                      ),
                      ContactSection(
                        key: _contactsKey,
                        size: size,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
