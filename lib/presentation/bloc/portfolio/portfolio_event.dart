// portfolio_event.dart
part of 'portfolio_bloc.dart';

// Events
abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object> get props => [];
}

class LoadPortfolioDataEvent extends PortfolioEvent {}

class LoadMoreProjectsEvent extends PortfolioEvent {}

class FilterProjectsEvent extends PortfolioEvent {
  final String? filter;

  const FilterProjectsEvent({this.filter});

  @override
  List<Object> get props => [filter ?? ''];
}
