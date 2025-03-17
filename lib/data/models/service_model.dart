import 'package:flutter/material.dart';

import '../../core/assets_path.dart';

class ServiceModel {
  final String title;
  final String description;
  final String iconPath;
  final List<String> technologies;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  ServiceModel({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.technologies,
    this.iconBackgroundColor,
    this.iconColor,
  });

  static List<ServiceModel> getDevelopmentServices() {
    return [
      ServiceModel(
        title: 'Android App Development',
        description: '',
        iconPath: AssetPaths.androidIconPath,
        technologies: [],
        iconBackgroundColor: Colors.transparent,
        iconColor: const Color(0xFF3DDC84), // Android green color
      ),
      ServiceModel(
        title: 'iOS App Development',
        description: '',
        iconPath: AssetPaths.iosIconPath,
        technologies: [],
        iconBackgroundColor: Colors.transparent,
        // iconColor: Colors.grey,
      ),
      ServiceModel(
        title: 'Web Development',
        description: '',
        iconPath: AssetPaths.webIconPath,
        technologies: [],
        iconBackgroundColor: Colors.transparent,
        // iconColor: const Color(0xFF5AC8FA), // Light blue color
      ),
    ];
  }

  static List<ServiceModel> getDetailedServices() {
    return [
      ServiceModel(
        title: 'Flutter Development for\nAndroid | iOS | Web',
        description:
            'Passionate about building responsive, scalable cross-platform apps with',
        iconPath: AssetPaths.flutterServiceIconPath,
        technologies: [
          'Flutter',
          'Dart',
          'Responsive UI',
          'Clean Architecture',
          'MVVM Pattern',
          'API Integration',
        ],
        iconBackgroundColor: const Color(0xFFFAA0A0), // Light coral pink
        iconColor: Colors.black,
      ),
      ServiceModel(
        title: 'State Management',
        description:
            'Expert in managing app state with Bloc, Cubit, and Provider for efficient',
        iconPath: AssetPaths.stateManagementIconPath,
        technologies: [
          'Bloc',
          'Cubit',
          'Provider',
        ],
        iconBackgroundColor: const Color(0xFF98D8D8), // Light teal
        iconColor: Colors.black,
      ),
      ServiceModel(
        title: 'Firebase Integration',
        description:
            'Expert in integrating Firebase services, including authentication, Firestore, and',
        iconPath: AssetPaths.firebaseServiceIconPath,
        technologies: [
          'Firebase Auth',
          'Firestore',
          'Firebase Realtime Database',
          'Firebase Storage',
          'Firebase Deeplinking',
          'Firease Messaging'
        ],
        // iconBackgroundColor: const Color(0xFFF5B971), // Light orange/amber
        // iconColor: Colors.black,
      ),
      ServiceModel(
        title: 'Local Data Storage & Offline Solutions',
        description:
            'Expert in using offline caching in Flutter apps for ensuring smooth offline',
        iconPath: AssetPaths.storageIconPath,
        technologies: [
          'Hive',
          'Sqflite',
          'Secure Storage',
          'Shared Preferences',
        ],
        // iconBackgroundColor: const Color(0xFF95C8F0), // Light blue
        // iconColor: Colors.black,
      ),
    ];
  }
}
