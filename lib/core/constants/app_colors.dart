import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF00796B); // Teal (Professional, modern)
  static const Color primaryDark = Color(0xFF004D40); // Darker Teal
  static const Color primaryLight = Color(0xFF48A999); // Lighter Teal

  // Background colors
  static const Color lightBackground =
      Color(0xFFF5F5F5); // Light Grey for neutral feel
  static const Color darkBackground =
      Color(0xFF121212); // Dark mode background for contrast

  // Text colors
  static const Color lightTextPrimary =
      Color(0xFF333333); // Dark text for better readability
  static const Color lightTextSecondary =
      Color(0xFF757575); // Slightly lighter for secondary text
  static const Color darkTextPrimary =
      Color(0xFFFFFFFF); // White text for dark mode
  static const Color darkTextSecondary =
      Color(0xFFB0B0B0); // Light grey text for secondary info

  // Card colors
  static const Color cardLight = Colors.white; // White cards for clean UI
  static const Color cardDark =
      Color(0xFF1F1F1F); // Dark grey for card in dark mode

  // Project card gradient colors
  static const List<Color> projectGradient = [
    Color(0xFF00796B), // Teal primary
    Color(0xFF0288D1), // Blue (Professional)
  ];

  // Button colors
  static const Color buttonColor =
      Color(0xFF00796B); // Teal button for consistency

  // Border colors
  static const Color borderColor = Color(0xFFDDDDDD); // Light grey border
  static const Color darkBorderColor =
      Color(0xFF444444); // Dark grey border in dark mode

  // Social Platforms colors.
  static const Color linkedColor = Color(0xff0077b5);
  static const Color whatsappColor = Color(0xff00FF00);
  static const Color emailColor = Color.fromARGB(220, 189, 40, 40);
}
