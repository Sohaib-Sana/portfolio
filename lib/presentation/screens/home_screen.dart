import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sohaib_portfolio/core/utils/url_launcher_helper.dart';
import 'package:sohaib_portfolio/presentation/widgets/contact/contact_section.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/sections.dart';
import '../../core/utils/responsive_helper.dart';
import '../bloc/portfolio/portfolio_bloc.dart';
import '../widgets/common/app_drawer.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/common/scroll_to_top.dart';
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

  String _currentSection = AppSections.Home;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();

    _sectionKeys = {
      AppSections.Home: _heroKey,
      AppSections.Skills: _skillsKey,
      AppSections.Experience: _experienceKey,
      AppSections.Contact: _contactKey,
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll to section
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

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onSectionVisible(String section) {
    if (_currentSection != section) {
      setState(() {
        _currentSection = section;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        selectedSection: _currentSection,
        showDrawerIcon: isMobile,
        onDrawerIconPressed: _openDrawer,
        onNavItemTapped: _scrollToSection,
      ),
      drawer: isMobile ? AppDrawer(onNavItemTapped: _scrollToSection) : null,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: VisibilityDetector(
                  key: const Key(AppSections.Home),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.5) {
                      _onSectionVisible(AppSections.Home);
                    }
                  },
                  child: HeroSection(
                    key: _heroKey,
                    onResumePressed: URLLaunchHelper.downloadResumeFromAssets,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: ScrollDownButton(
                    onPressed: () => _scrollToSection(AppSections.Skills),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: VisibilityDetector(
                  key: const Key(AppSections.Skills),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.2) {
                      _onSectionVisible(AppSections.Skills);
                    }
                  },
                  child: buildSkillsSection(context, key: _skillsKey),
                ),
              ),
              SliverToBoxAdapter(
                child: VisibilityDetector(
                  key: const Key(AppSections.Experience),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3) {
                      _onSectionVisible(AppSections.Experience);
                    }
                  },
                  child: BlocBuilder<PortfolioBloc, PortfolioState>(
                    builder: (context, state) {
                      return buildExperienceSection(
                        context,
                        key: _experienceKey,
                        experiences: state.experiences,
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: VisibilityDetector(
                  key: const Key(AppSections.Contact),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3) {
                      _onSectionVisible(AppSections.Contact);
                    }
                  },
                  child: buildContactSection(context, key: _contactKey),
                ),
              ),
              SliverToBoxAdapter(child: _buildFooter()),
            ],
          ),
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
      height: 62,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightBackground
          : AppColors.darkBackground.withAlpha((0.3 * 255).toInt()),
      child: const Center(
        child: Text(
          '© 2025 All rights reserved | Created by Muhammad Sohaib Sana ♡',
        ),
      ),
    );
  }
}
