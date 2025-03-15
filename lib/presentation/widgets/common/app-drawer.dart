import 'package:flutter/material.dart';

import '../../../core/constants/app_text_styles.dart';
import 'social_button.dart';

class AppDrawer extends StatelessWidget {
  final Function(String)? onNavItemTapped;
  final List<String> navItems;

  const AppDrawer({
    Key? key,
    this.onNavItemTapped,
    this.navItems = const [
      'Home',
      'Skills',
      'Experience',
      'Portfolio',
      'Contact'
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
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Menna',
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SocialButton(
                  platform: SocialPlatform.github,
                  size: 20,
                ),
                SocialButton(
                  platform: SocialPlatform.linkedin,
                  size: 20,
                ),
                SocialButton(
                  platform: SocialPlatform.facebook,
                  size: 20,
                ),
                SocialButton(
                  platform: SocialPlatform.email,
                  size: 20,
                ),
              ],
            ),
          ),

          // Copyright text
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '© 2024 All rights reserved | Menna Allah Mohamed',
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
      case 'Home':
        return const Icon(Icons.home);
      case 'Skills':
        return const Icon(Icons.code);
      case 'Experience':
        return const Icon(Icons.work);
      case 'Portfolio':
        return const Icon(Icons.apps);
      case 'Contact':
        return const Icon(Icons.email);
      default:
        return const Icon(Icons.circle);
    }
  }
}
