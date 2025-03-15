import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../bloc/portfolio/portfolio_bloc.dart';
import '../widgets/common/custom_app_bar.dart';
import '../widgets/experience/timeline_widget.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  @override
  void initState() {
    super.initState();
    // Load portfolio data if not already loaded
    final portfolioState = context.read<PortfolioBloc>().state;
    if (portfolioState.experiences.isEmpty) {
      context.read<PortfolioBloc>().add(LoadPortfolioDataEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error != null) {
            return Center(
              child: Text(
                'Error loading experience data: ${state.error}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return SingleChildScrollView(
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
                        'Professional Experience',
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
                        width: ResponsiveHelper.isMobile(context)
                            ? double.infinity
                            : 700,
                        child: Text(
                          'Since starting my journey as a Flutter developer, I\'ve worked with startups and talented teams, gaining hands-on experience in building impactful, user-centric applications. This has allowed me to sharpen my skills in mobile app development and creating seamless user experiences.',
                          style: AppTextStyles.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Experience Timeline
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.getHorizontalPadding(context),
                    vertical: 40,
                  ),
                  child: TimelineWidget(
                    experiences: state.experiences,
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }
}
