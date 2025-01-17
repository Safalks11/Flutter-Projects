import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants/colors.dart';
import '../profile/bloc/profile_bloc.dart';

class WorksSection extends StatelessWidget {
  final Size size;
  const WorksSection({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
      child: Column(
        children: [
          GradientText(
            "My Quality Works",
            colors: const [
              AppColors.studio,
              AppColors.paleSlate,
            ],
            style: TextStyle(
              fontSize: size.width > 900
                  ? size.width * 0.022
                  : size.width > 600
                      ? size.width * 0.035
                      : size.width * 0.040,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: size.width * 0.9,
            child: const Divider(
              color: AppColors.paleSlate,
            ),
          ),
          size.width > 900
              ? SizedBox(height: size.width * 0.05)
              : SizedBox(height: size.width * 0.03),
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const SizedBox();
            }
            if (state is ProfileError) {
              return Text(state.errorMessage);
            }
            if (state is ProfileLoaded) {
              final projectData = state.projectData;
              if (projectData.isEmpty) {
                return const Text('No project data available.');
              }
              return size.width > 900
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // Prevents scrolling if wrapped in a scrollable parent
                        itemCount: projectData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              4, // Increased the count for smaller containers
                          childAspectRatio:
                              1.5, // Adjusts the aspect ratio for smaller containers
                          crossAxisSpacing:
                              15, // Reduced spacing for tighter layout
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final projectKey = 'project${index + 1}';

                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit
                                    .cover, // Ensures image scales properly inside the container
                                image: NetworkImage(
                                  '${projectData[projectKey]['img']}',
                                ),
                              ),
                              border: Border.all(
                                color: AppColors.studioLight,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                  12), // Adjusted for smaller containers
                            ),
                          );
                        },
                      ),
                    )
                  : size.width > 600
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Prevents scrolling if wrapped in a scrollable parent
                            itemCount: projectData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Increased the count for smaller containers
                              childAspectRatio:
                                  1.5, // Adjusts the aspect ratio for smaller containers
                              crossAxisSpacing:
                                  15, // Reduced spacing for tighter layout
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final projectKey = 'project${index + 1}';

                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit
                                        .cover, // Ensures image scales properly inside the container
                                    image: NetworkImage(
                                      '${projectData[projectKey]['img']}',
                                    ),
                                  ),
                                  border: Border.all(
                                    color: AppColors.studioLight,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      12), // Adjusted for smaller containers
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(), // Prevents scrolling if wrapped in a scrollable parent
                            itemCount: projectData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  1, // Increased the count for smaller containers
                              childAspectRatio:
                                  1.5, // Adjusts the aspect ratio for smaller containers
                              crossAxisSpacing:
                                  15, // Reduced spacing for tighter layout
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final projectKey = 'project${index + 1}';

                              return Container(
                                width: size.width * 0.7,
                                height: size.width * 0.7,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit
                                        .cover, // Ensures image scales properly inside the container
                                    image: NetworkImage(
                                      '${projectData[projectKey]['img']}',
                                    ),
                                  ),
                                  border: Border.all(
                                    color: AppColors.studioLight,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      12), // Adjusted for smaller containers
                                ),
                              );
                            },
                          ),
                        );
            } else {
              return const Text("No Data");
            }
          })
        ],
      ),
    );
  }
}
