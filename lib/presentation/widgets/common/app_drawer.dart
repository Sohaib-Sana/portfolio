import 'package:flutter/material.dart';
import 'package:sohaib_portfolio/core/constants/app_colors.dart';
import 'package:sohaib_portfolio/core/utils/social_interaction_helpers.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/sections.dart';
import 'social_button.dart';

class AppDrawer extends StatelessWidget {
  final Function(String)? onNavItemTapped;
  final List<String> navItems;

  const AppDrawer({
    Key? key,
    this.onNavItemTapped,
    this.navItems = const [
      AppSections.Home,
      AppSections.Skills,
      AppSections.Experience,
      AppSections.Contact
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer header with logo
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withAlpha((0.1 * 255).toInt()),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/logo.png',
                  //   height: 50,
                  //   width: 50,
                  // ),
                  // const SizedBox(width: 12),
                  Text(
                    'Sohaib',
                    style: AppTextStyles.logo,
                  ),
                ],
              ),
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView.builder(
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final navItem = navItems[index];

                return ListTile(
                  title: Text(
                    navItem,
                    style: AppTextStyles.bodyMedium,
                  ),
                  onTap: () {
                    // Close the drawer
                    Navigator.pop(context);

                    // Call the callback to scroll to the section
                    if (onNavItemTapped != null) {
                      onNavItemTapped!(navItem);
                    }
                  },
                  leading: _getIconForNavItem(navItem),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
            ),
          ),

          // Social media links
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SocialButton(
                  platform: SocialPlatform.email,
                  size: 24,
                  color: AppColors.emailColor,
                  onTap: () => URLLaunchHelper.onTapEmail(),
                ),
                SocialButton(
                  platform: SocialPlatform.linkedin,
                  size: 20,
                  color: AppColors.linkedColor,
                  onTap: () => URLLaunchHelper.onTapLinkedIn(),
                ),
                SocialButton(
                  platform: SocialPlatform.whatsapp,
                  size: 20,
                  color: AppColors.whatsappColor,
                  onTap: () => URLLaunchHelper.onTapWhatsApp(),
                ),
                SocialButton(
                  platform: SocialPlatform.github,
                  size: 20,
                  onTap: () => URLLaunchHelper.onTapGitHub(),
                ),
              ],
            ),
          ),

          // Copyright text
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '© 2024 All rights reserved | Muhammad Sohaib Sana',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get appropriate icon for each nav item
  Icon _getIconForNavItem(String navItem) {
    switch (navItem) {
      case AppSections.Home:
        return const Icon(Icons.home_outlined);
      case AppSections.Skills:
        return const Icon(Icons.code);
      case AppSections.Experience:
        return const Icon(Icons.work_outline);
      case AppSections.Contact:
        return const Icon(Icons.contact_mail_outlined);
      default:
        return const Icon(Icons.circle);
    }
  }
}
