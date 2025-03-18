import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import './service_card.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/service_model.dart';

Widget buildSkillsSection(BuildContext context, {Key? key}) {
  final isMobile = ResponsiveHelper.isMobile(context);
  final isTablet = ResponsiveHelper.isTablet(context);

  // Get development service cards (Android, iOS, Web)
  final developmentServices = ServiceModel.getDevelopmentServices();

  // Get detailed service cards (Flutter, State Management, Firebase, Storage)
  final detailedServices = ServiceModel.getDetailedServices();

  return Container(
    key: key,
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: ResponsiveHelper.getHorizontalPadding(context),
      vertical: ResponsiveHelper.getScreenPadding(context).vertical,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF0A0A0A),
    ),
    child: Column(
      children: [
        // What can I do? header
        Text(
          'What can I do?',
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 60),

        // Development Service Icons (Android, iOS, Web in a row)
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : (isTablet ? 30 : 60),
          ),
          child: isMobile
              ? Column(
                  children: developmentServices.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: _buildDevServiceItem(service),
                    );
                  }).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: developmentServices.map((service) {
                    return _buildDevServiceItem(service);
                  }).toList(),
                ),
        ),

        const SizedBox(height: 40),

        // Services Overview Text
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : 100,
            vertical: 20,
          ),
          child: Text(
            'I offer tailored Flutter development services, specializing in building intuitive, high-performance mobile apps and websites with clean architecture, ensuring seamless user experiences and efficient solutions for your business needs.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 60),

        // Detailed Services Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
            // childAspectRatio: isMobile ? 0.8 : (isTablet ? 0.7 : 0.6),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            mainAxisExtent: isMobile ? 500 : (isTablet ? 550 : 600),
          ),
          itemCount: detailedServices.length,
          itemBuilder: (context, index) {
            return ServiceCard(
              title: detailedServices[index].title,
              description: detailedServices[index].description,
              iconPath: detailedServices[index].iconPath,
              technologies: detailedServices[index].technologies,
              iconBackgroundColor: detailedServices[index].iconBackgroundColor,
              iconColor: detailedServices[index].iconColor,
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildDevServiceItem(ServiceModel service) {
  return Column(
    children: [
      // Circular icon container
      Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primaryLight,
            width: 2,
          ),
        ),
        child: Image.asset(
          service.iconPath,
          color: service.iconColor,
        ),
      ),

      const SizedBox(height: 16),

      // Service name
      Text(
        service.title,
        style: AppTextStyles.h5,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
