import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/experience_model.dart';
import '../../../data/models/project_model.dart';

part 'porfolio_state.dart';
part 'portfolio_event.dart';

// BLoC
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc() : super(const PortfolioState()) {
    on<LoadPortfolioDataEvent>(_onLoadPortfolioData);
    on<FilterProjectsEvent>(_onFilterProjects);
  }

  void _onLoadPortfolioData(
      LoadPortfolioDataEvent event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      // In a real app, this would be a repository call
      final projects = ProjectModel.getDummyProjects();
      final experiences = ExperienceModel.getDummyExperiences();

      emit(state.copyWith(
        projects: projects,
        filteredProjects: projects,
        experiences: experiences,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void _onFilterProjects(
      FilterProjectsEvent event, Emitter<PortfolioState> emit) {
    final filter = event.filter;

    if (filter == null || filter.isEmpty) {
      emit(state.copyWith(filteredProjects: state.projects));
      return;
    }

    final filteredProjects = state.projects.where((project) {
      return project.title.toLowerCase().contains(filter.toLowerCase()) ||
          project.technologies
              .any((tech) => tech.toLowerCase().contains(filter.toLowerCase()));
    }).toList();

    emit(state.copyWith(filteredProjects: filteredProjects));
  }
}
