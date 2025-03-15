// theme_state.dart
part of 'theme_bloc.dart';

// States
class ThemeState extends Equatable {
  final bool isDarkMode;

  const ThemeState({this.isDarkMode = false});

  ThemeState copyWith({bool? isDarkMode}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object> get props => [isDarkMode];
}
