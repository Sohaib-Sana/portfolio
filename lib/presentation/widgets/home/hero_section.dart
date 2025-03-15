import 'package:flutter/material.dart';

import '../../../core/assets_path.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../common/animated_text.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onResumePressed;

  const HeroSection({
    Key? key,
    this.onResumePressed,
  }) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: isDesktop ? 100 : 60,
      ),
      child: isDesktop
          ? _buildDesktopLayout()
          : _buildMobileTabletLayout(isTablet),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side content
        Expanded(
          flex: 3,
          child: _buildContent(),
        ),

        // Right side image
        Expanded(
          flex: 2,
          child: _buildProfileImage(),
        ),
      ],
    );
  }

  Widget _buildMobileTabletLayout(bool isTablet) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile image
        _buildProfileImage(isMobile: !isTablet),

        SizedBox(height: isTablet ? 40 : 24),

        // Content
        _buildContent(isMobile: !isTablet),
      ],
    );
  }

  Widget _buildContent({bool isMobile = false}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, Welcome to My Portfolio 👋',
              style: isMobile ? AppTextStyles.h5 : AppTextStyles.h4,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 16),
            Text(
              "I'm Muhammad Sohaib Sana,",
              style: isMobile ? AppTextStyles.h3 : AppTextStyles.h1,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 8),
            AnimatedText(
              texts: const [
                'A Flutter Developer',
                'A Mobile App Developer',
                'A UI/UX Enthusiast',
              ],
              style: isMobile
                  ? AppTextStyles.h4.copyWith(
                      color: AppColors.primary,
                    )
                  : AppTextStyles.h2.copyWith(
                      color: AppColors.primary,
                    ),
              animationType: AnimationType.typewriter,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 24),
            Text(
              'Mobile Application Developer crafting high-quality apps and '
              'delivering seamless user experiences. Join me below, and let\'s '
              'bring your ideas to life!',
              style:
                  isMobile ? AppTextStyles.bodyMedium : AppTextStyles.bodyLarge,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 32),
            _buildResumeButton(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeButton(bool isMobile) {
    return Center(
      child: ElevatedButton(
        onPressed: widget.onResumePressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(200, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'VIEW RESUME',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage({bool isMobile = false}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: isMobile ? 200 : 350,
        height: isMobile ? 200 : 350,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 10,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            AssetPaths.profilePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
