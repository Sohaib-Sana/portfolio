import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sohaib_portfolio/core/constants/app_colors.dart';
import 'package:sohaib_portfolio/core/constants/app_text_styles.dart';
import 'package:sohaib_portfolio/core/utils/responsive_helper.dart';
import 'package:sohaib_portfolio/core/utils/url_launcher_helper.dart';
import 'package:sohaib_portfolio/presentation/widgets/common/social_button.dart';

Widget buildContactSection(BuildContext context, {Key? key}) {
  return Container(
    key: key,
    width: double.infinity,
    // height: ResponsiveHelper.getContentMaxWidth(context) / 2,
    padding: EdgeInsets.symmetric(
      horizontal: ResponsiveHelper.getHorizontalPadding(context),
      vertical: 40,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : AppColors.cardDark,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.05 * 255).toInt()),
          blurRadius: 20,
          spreadRadius: 5,
        ),
      ],
    ),
    margin: EdgeInsets.symmetric(
      horizontal: ResponsiveHelper.getHorizontalPadding(context),
      // vertical: 40,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Contact content with robot image
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let\'s create something amazing!',
                    style: AppTextStyles.h4,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Feel free to reach out if you\'d like to discuss a project, a job opportunity, or simply want to connect.',
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: URLLaunchHelper.onSayHelloTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text('Say Hello'),
                  ),
                ],
              ),
            ),
            if (!ResponsiveHelper.isMobile(context))
              Lottie.asset(
                'assets/animations/robot.json',
              ),
          ],
        ),

        // const SizedBox(height: 40),

        // Social media links
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              platform: SocialPlatform.github,
              onTap: () => URLLaunchHelper.onTapGitHub(),
            ),
            const SizedBox(width: 8),
            SocialButton(
              platform: SocialPlatform.email,
              color: AppColors.emailColor,
              onTap: () => URLLaunchHelper.onTapEmail(),
            ),
            const SizedBox(width: 8),
            SocialButton(
              platform: SocialPlatform.whatsapp,
              color: AppColors.whatsappColor,
              onTap: () => URLLaunchHelper.onTapWhatsApp(),
            ),
            const SizedBox(width: 8),
            SocialButton(
              platform: SocialPlatform.linkedin,
              color: AppColors.linkedColor,
              onTap: () => URLLaunchHelper.onTapLinkedIn(),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 36),

        // Divider
        const Divider(height: 1),
      ],
    ),
  );
}
