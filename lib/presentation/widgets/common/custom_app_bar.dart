import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../../core/constants/sections.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawerIcon;
  final VoidCallback? onDrawerIconPressed;
  final Function(String)? onNavItemTapped;
  final String selectedSection;

  const CustomAppBar({
    Key? key,
    this.showDrawerIcon = true,
    this.onDrawerIconPressed,
    this.onNavItemTapped,
    required this.selectedSection,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveHelper.getDeviceType(context);
    final List<String> navItems = [
      AppSections.Home,
      AppSections.Skills,
      AppSections.Experience,
    ];

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Text(
                'Muhammad Sohaib Sana',
                style: AppTextStyles.logo,
              ),
            ],
          ),

          // Navigation items for tablet & desktop
          if (deviceType != DeviceType.mobile)
            Row(
              children: List.generate(
                navItems.length,
                (index) => _buildNavItem(
                  context,
                  navItem: navItems[index],
                  isSelected: navItems[index] == selectedSection,
                  onTap: () {
                    onNavItemTapped?.call(navItems[index]);
                  },
                ),
              ),
            ),

          // Theme toggle + Drawer (on mobile)
          Row(
            children: [
              _buildThemeToggle(context),
              if (deviceType == DeviceType.mobile && showDrawerIcon)
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: onDrawerIconPressed,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String navItem,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            navItem,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
        );
      },
    );
  }
}
