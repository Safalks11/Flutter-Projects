import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safal_portfolio/screens/widgets/services/services_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../constants/colors.dart';
import '../text_widget.dart';

class MyServicesWidget extends StatelessWidget {
  final Size size;

  const MyServicesWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ebony,
      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
      child: Column(
        children: [
          GradientText(
            "My Quality Services",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'I provide mobile solutions that transform your ideas into functional, user-friendly, and efficient mobile applications. Here are some of the services I offer:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width > 900
                    ? 18
                    : size.width > 600
                        ? size.width * 0.019
                        : size.width * 0.025,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: size.width * 0.9,
            child: const Divider(
              color: AppColors.paleSlate,
            ),
          ),
          BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
            if (state is ServicesLoading) {
              return const CircularProgressIndicator(); // Show loading
            }
            if (state is ServiceError) {
              return Text(state.errorMessage); // Show error
            }
            if (state is ServicesLoaded) {
              final serviceData = state.serviceData;
              final hoverState = state.hoverState;
              if (serviceData.isEmpty) {
                return const Text('No services data available.');
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: serviceData.length,
                itemBuilder: (context, index) {
                  final serviceKey = 'service${index + 1}';
                  final title = serviceData[serviceKey]?['title'] ?? 'No title';
                  final processedTitle = title.replaceAll('\\n', '\n');

                  final desc =
                      serviceData[serviceKey]?['desc'] ?? 'No description';
                  return MouseRegion(
                    onEnter: (_) =>
                        context.read<ServicesBloc>().add(HoverEntered(index)),
                    onExit: (_) =>
                        context.read<ServicesBloc>().add(HoverExited(index)),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05, vertical: 10),
                      decoration: BoxDecoration(
                        color: hoverState[index]
                            ? AppColors.ebony
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: hoverState[index]
                              ? AppColors.studio.withOpacity(0.5)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        gradient: hoverState[index]
                            ? const LinearGradient(
                                colors: [AppColors.studio, AppColors.ebony],
                              )
                            : null,
                      ),
                      child: size.width > 900
                          ? _buildLargeLayout(
                              index, processedTitle, desc, hoverState)
                          : size.width > 600
                              ? _buildMediumLayout(
                                  index, processedTitle, desc, hoverState)
                              : _buildSmallLayout(
                                  index, processedTitle, desc, hoverState),
                    ),
                  );
                },
              );
            } else {
              return const Text('Data is loading or error occurred');
            }
          }),
        ],
      ),
    );
  }

  Widget _buildLargeLayout(
      int index, String title, String description, List<bool> hoverState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Index section with fixed width to ensure consistency
        TextWidget(
          sSize: size,
          text: "${index + 1}",
          size: 24,
          color: Colors.white,
        ),
        SizedBox(width: size.width * 0.02),

        // Title section, giving it some flexibility with Expanded
        Expanded(
          flex: 2,
          child: TextWidget(
            sSize: size,
            fw: FontWeight.w600,
            text: title,
            size: 17,
            color: Colors.white,
          ),
        ),
        SizedBox(width: size.width * 0.05), // Adjust for spacing

        // Description section with more flexibility for long text
        Expanded(
          flex: 4,
          child: TextWidget(
            sSize: size,
            text: description,
            size: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(width: size.width * 0.02),

        // Icon with fixed size and alignment
        FaIcon(
          hoverState[index]
              ? FontAwesomeIcons.arrowTrendUp
              : FontAwesomeIcons.arrowTrendDown,
          color: hoverState[index] ? Colors.white : AppColors.studio,
        ),
      ],
    );
  }

  Widget _buildMediumLayout(
      int index, String title, String description, List<bool> hoverState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(
          sSize: size,
          text: "${index + 1}",
          size: 20,
          color: Colors.white,
        ),
        SizedBox(height: size.height * 0.02),
        TextWidget(
          alignment: TextAlign.center,
          sSize: size,
          text: title,
          size: size.width * 0.020,
          color: Colors.white,
        ),
        SizedBox(height: size.height * 0.02),
        Wrap(
          children: [
            TextWidget(
              alignment: TextAlign.center,
              sSize: size,
              text: description,
              size: size.width * 0.016,
              color: Colors.white,
            )
          ],
        ),
        SizedBox(height: size.height * 0.02),
        FaIcon(
          hoverState[index]
              ? FontAwesomeIcons.arrowTrendUp
              : FontAwesomeIcons.arrowTrendDown,
          color: hoverState[index] ? Colors.white : AppColors.studio,
        )
      ],
    );
  }

  Widget _buildSmallLayout(
      int index, String title, String description, List<bool> hoverState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(
          sSize: size,
          text: "${index + 1}",
          size: 18,
          color: Colors.white,
        ),
        SizedBox(height: size.height * 0.02),
        TextWidget(
          alignment: TextAlign.center,
          sSize: size,
          text: title,
          size: size.width * 0.028,
          color: Colors.white,
        ),
        SizedBox(height: size.height * 0.02),
        Wrap(
          children: [
            TextWidget(
              alignment: TextAlign.center,
              sSize: size,
              text: description,
              size: size.width * 0.024,
              color: Colors.white,
            )
          ],
        ),

        // SizedBox(height: size.height * 0.02),
        // FaIcon(
        //   hoverState[index]
        //       ? FontAwesomeIcons.arrowTrendUp
        //       : FontAwesomeIcons.arrowTrendDown,
        //   color: hoverState[index] ? Colors.white : AppColors.studio,
        // )
      ],
    );
  }
}
