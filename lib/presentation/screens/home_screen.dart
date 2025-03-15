import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../data/models/experience_model.dart';
import '../../data/models/project_model.dart';
import '../bloc/portfolio/portfolio_bloc.dart';
import '../widgets/common/app-drawer.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/scroll-to-top.dart';
import '../widgets/common/social_button.dart';
import '../widgets/experience/timeline_widget.dart';
import '../widgets/home/hero_section.dart';
import '../widgets/portfolio/project_card.dart';
import '../widgets/scroll_down_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Section keys for scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Map of section names to keys for easy access
  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();

    // Initialize section keys map
    _sectionKeys = {
      'Home': _heroKey,
      'Skills': _skillsKey,
      'Experience': _experienceKey,
      'Portfolio': _portfolioKey,
      'Contact': _contactKey,
    };

    // Load portfolio data using BLoC
    context.read<PortfolioBloc>().add(LoadPortfolioDataEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to scroll to a specific section
  void _scrollToSection(String sectionName) {
    final key = _sectionKeys[sectionName];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  // Function to open drawer on mobile
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        showDrawerIcon: isMobile,
        onDrawerIconPressed: _openDrawer,
        onNavItemTapped: _scrollToSection,
      ),
      drawer: isMobile ? AppDrawer(onNavItemTapped: _scrollToSection) : null,
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section
                    HeroSection(
                      key: _heroKey,
                      onResumePressed: () {
                        // Handle resume button press
                        _scrollToSection('Experience');
                      },
                    ),

                    // Scroll down button at the end of hero section
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: ScrollDownButton(
                          onPressed: () => _scrollToSection('Skills'),
                        ),
                      ),
                    ),

                    // Skills Section
                    _buildSkillsSection(key: _skillsKey),

                    // Experience Section
                    // _buildExperienceSection(
                    //   key: _experienceKey,
                    //   experiences: state.experiences,
                    // ),

                    // Portfolio Section
                    _buildPortfolioSection(
                      key: _portfolioKey,
                      projects: state.projects,
                    ),

                    // Contact Section
                    _buildContactSection(key: _contactKey),

                    // Footer
                    _buildFooter(),
                  ],
                ),
              ),

              // Scroll to top button
              Positioned(
                bottom: 30,
                right: 30,
                child: ScrollToTopButton(
                  scrollController: _scrollController,
                ),
              ),
            ],
          );
        },
      ),
      // Floating social media sidebar (only on desktop and tablet)
      floatingActionButton: !isMobile ? _buildSocialSidebar() : null,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 16),
          Container(
            width: 100,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection({Key? key}) {
    // To be implemented - Skills Grid
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Skills'),
          const SizedBox(height: 40),
          // Skills grid would go here
          Center(
            child: Text(
              'Skills section - to be implemented',
              style: AppTextStyles.bodyLarge,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildExperienceSection({
    Key? key,
    required List<ExperienceModel> experiences,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightBackground
            : AppColors.darkBackground.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Chapters of My Career'),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Since starting my journey as a Flutter developer, I\'ve worked with startups and talented teams, gaining hands-on experience in building impactful, user-centric applications. This has allowed me to sharpen my skills in mobile app development and creating seamless user experiences.',
              style: AppTextStyles.bodyMedium,
            ),
          ),
          const SizedBox(height: 60),
          TimelineWidget(experiences: experiences),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildPortfolioSection({
    Key? key,
    required List<ProjectModel> projects,
  }) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Diverse Projects Portfolio'),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Explore my portfolio to see a collection of projects that showcase my journey in Flutter development, where innovation meets seamless user experiences.',
              style: AppTextStyles.bodyMedium,
            ),
          ),
          const SizedBox(height: 60),

          // Projects Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              childAspectRatio: 1.0,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index]);
            },
          ),

          const SizedBox(height: 40),

          // Show more button
          Center(
            child: OutlinedButton(
              onPressed: () {
                // Handle show more button press
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text('Show More'),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildContactSection({Key? key}) {
    return Container(
      key: key,
      width: double.infinity,
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getHorizontalPadding(context),
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get in Touch',
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Get in touch with me using the links below to discuss how I can assist you.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Contact content with robot image
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s create something amazing!',
                      style: AppTextStyles.h4,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Feel free to reach out if you\'d like to discuss a project, a job opportunity, or simply want to connect.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Handle contact button press - open email or form
                      },
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
                Expanded(
                  child: Image.asset(
                    'assets/images/robot.png',
                    height: 200,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 40),

          // Social media links
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButton(platform: SocialPlatform.github),
              SizedBox(width: 8),
              SocialButton(platform: SocialPlatform.email),
              SizedBox(width: 8),
              SocialButton(platform: SocialPlatform.whatsapp),
              SizedBox(width: 8),
              SocialButton(platform: SocialPlatform.linkedin),
              SizedBox(width: 8),
              SocialButton(platform: SocialPlatform.facebook),
              SizedBox(width: 8),
              SocialButton(platform: SocialPlatform.telegram),
            ],
          ),

          const SizedBox(height: 40),

          // Divider
          const Divider(height: 1),

          const SizedBox(height: 24),

          // Copyright text
          Text(
            '© 2024 All rights reserved | Created by Muhammad Sohaib Sana ♡',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightBackground
          : AppColors.darkBackground.withOpacity(0.3),
      child: const Center(
        child: Text(''),
      ),
    );
  }

  Widget _buildSocialSidebar() {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : AppColors.cardDark,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // Follow Me text
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Follow Me',
                    style: AppTextStyles.bodySmall,
                  ),
                ),

                // Vertical line
                Container(
                  height: 100,
                  width: 1,
                  color: Theme.of(context).dividerColor,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                ),

                // Social icons
                const SocialButton(
                  platform: SocialPlatform.github,
                  showBackground: false,
                ),
                const SizedBox(height: 16),
                const SocialButton(
                  platform: SocialPlatform.linkedin,
                  showBackground: false,
                ),
                const SizedBox(height: 16),
                const SocialButton(
                  platform: SocialPlatform.facebook,
                  showBackground: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
