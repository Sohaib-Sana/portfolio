import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/sections.dart';
import '../../core/utils/responsive_helper.dart';
import '../bloc/portfolio/portfolio_bloc.dart';
import '../widgets/common/app_drawer.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/scroll-to-top.dart';
import '../widgets/common/scroll_down_button.dart';
import '../widgets/experience/experience_section.dart';
import '../widgets/home/hero_section.dart';
import '../widgets/skills/skill_section.dart';

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

  // Map of section names to keys for easy access
  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();

    // Initialize section keys map
    _sectionKeys = {
      AppSections.Home: _heroKey,
      AppSections.Skills: _skillsKey,
      AppSections.Experience: _experienceKey
    };
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
      body: Stack(
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
                buildSkillsSection(context, key: _skillsKey),

                // Experience Section
                BlocBuilder<PortfolioBloc, PortfolioState>(
                  builder: (context, state) {
                    return buildExperienceSection(
                      context,
                      key: _experienceKey,
                      experiences: state.experiences,
                    );
                  },
                ),

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
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      height: 60,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightBackground
          : AppColors.darkBackground.withValues(alpha: 0.3),
      child: const Center(
        child: Text(''),
      ),
    );
  }
}
