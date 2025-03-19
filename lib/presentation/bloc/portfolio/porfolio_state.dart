part of 'portfolio_bloc.dart';

// States
class PortfolioState extends Equatable {
  final List<ProjectModel> projects;
  final List<ProjectModel> filteredProjects;
  final List<ExperienceModel> experiences;
  final bool isLoading;
  final String? error;

  const PortfolioState({
    this.projects = const [],
    this.filteredProjects = const [],
    this.experiences = const [],
    this.isLoading = false,
    this.error,
  });

  PortfolioState copyWith({
    List<ProjectModel>? projects,
    List<ProjectModel>? filteredProjects,
    List<ExperienceModel>? experiences,
    bool? isLoading,
    String? error,
  }) {
    return PortfolioState(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      experiences: experiences ?? this.experiences,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object> get props => [
        projects,
        filteredProjects,
        experiences,
        isLoading,
        error ?? '',
      ];
}
