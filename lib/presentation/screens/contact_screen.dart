import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/social_button.dart';
import '../widgets/contact/contact_card.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(context),
                vertical: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Get in Touch',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: isMobile ? double.infinity : 700,
                    child: Text(
                      'Get in touch with me using the form or links below to discuss how I can assist you with your mobile app development needs.',
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Contact content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(context),
              ),
              child: isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ),

            const SizedBox(height: 80),

            // Social media section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getHorizontalPadding(context),
                vertical: 40,
              ),
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.lightBackground
                  : AppColors.darkBackground.withOpacity(0.3),
              child: Column(
                children: [
                  Text(
                    'Connect With Me',
                    style: AppTextStyles.h3,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Social media icons
                  const Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SocialButton(platform: SocialPlatform.github),
                      SocialButton(platform: SocialPlatform.linkedin),
                      SocialButton(platform: SocialPlatform.facebook),
                      SocialButton(platform: SocialPlatform.email),
                      SocialButton(platform: SocialPlatform.whatsapp),
                      SocialButton(platform: SocialPlatform.telegram),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  '© 2024 All rights reserved | Created by Muhammad Sohaib Sana ♡',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/robot.png',
          height: 200,
        ),
        const SizedBox(height: 40),
        const ContactCard(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side with illustration
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s create something amazing!',
                style: AppTextStyles.h3,
              ),
              const SizedBox(height: 24),
              Text(
                'Feel free to reach out if you\'d like to discuss a project, a job opportunity, or simply want to connect. I\'m always open to new challenges and collaborations.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/robot.png',
                height: 300,
              ),
            ],
          ),
        ),

        const SizedBox(width: 40),

        // Right side with contact form
        const Expanded(
          flex: 7,
          child: ContactCard(),
        ),
      ],
    );
  }
}
