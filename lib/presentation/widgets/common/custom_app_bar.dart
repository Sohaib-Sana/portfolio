import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../bloc/theme/theme_bloc.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showDrawerIcon;
  final VoidCallback? onDrawerIconPressed;
  final Function(String)? onNavItemTapped;

  const CustomAppBar({
    Key? key,
    this.showDrawerIcon = true,
    this.onDrawerIconPressed,
    this.onNavItemTapped,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIndex = 0;
  final List<String> _navItems = [
    'Home',
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Call the callback to scroll to the section
    if (widget.onNavItemTapped != null) {
      widget.onNavItemTapped!(_navItems[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveHelper.getDeviceType(context);

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
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
              // Image.asset(
              //   AssetPaths.logoPath,
              //   height: 50,
              //   width: 50,
              // ),
              const SizedBox(width: 8),
              Text(
                'Muhammad Sohaib Sana',
                style: AppTextStyles.logo,
              ),
            ],
          ),

          // Navigation menu for tablet and desktop
          if (deviceType != DeviceType.mobile)
            Row(
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(index),
              ),
            ),

          // Theme toggle and drawer icon
          Row(
            children: [
              // Theme toggle
              _buildThemeToggle(),

              // Drawer icon for mobile
              if (deviceType == DeviceType.mobile && widget.showDrawerIcon)
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: widget.onDrawerIconPressed,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = _selectedIndex == index;
    final navItem = _navItems[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => _onNavItemTapped(index),
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

  Widget _buildThemeToggle() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
        );
      },
    );
  }
}
