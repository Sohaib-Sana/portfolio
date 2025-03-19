class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final String? projectUrl;
  final String? githubUrl;
  final List<String> technologies;
  final List<String> features;
  final bool isGradientBackground;
  final List<String>? gradientColors;

  ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.projectUrl,
    this.githubUrl,
    required this.technologies,
    required this.features,
    this.isGradientBackground = false,
    this.gradientColors,
  });

  static List<ProjectModel> getDummyProjects() {
    return [
      ProjectModel(
        title: 'Rick and Morty App',
        description:
            'A fan app for the Rick and Morty TV show with character information, episodes, and more features.',
        imageUrl: 'assets/images/rick_morty_app.png',
        technologies: ['Flutter', 'BLoC', 'RestAPI'],
        features: ['Character info', 'Episode guide', 'Location tracker'],
        isGradientBackground: true,
        gradientColors: ['0xFF00796B', '0xFF0288D1'],
      ),
      ProjectModel(
        title: 'Slash Seller App',
        description:
            'Empower local brands with App—manage product listings, track orders, and analyze sales to streamline operations and drive growth.',
        imageUrl: 'assets/images/slash_seller_app.png',
        technologies: ['Flutter', 'Firebase', 'Provider'],
        features: ['Inventory Management', 'Order Tracking', 'Analytics'],
        isGradientBackground: true,
        gradientColors: ['0xFF00796B', '0xFF0288D1'],
      ),
      ProjectModel(
        title: 'Slash Hub App',
        description:
            'Discover a curated shopping experience, connecting users to top local brands in Egypt. Enjoy seamless browsing, secure payments, and effortless shopping at your fingertips.',
        imageUrl: 'assets/images/slash_hub_app.png',
        technologies: ['Flutter', 'GetX', 'RESTful API'],
        features: ['E-commerce', 'Payment Integration', 'Brand Management'],
        isGradientBackground: true,
        gradientColors: ['0xFF00796B', '0xFF0288D1'],
      ),
      ProjectModel(
        title: 'Chat App',
        description:
            'A modern messaging application with real-time chat capabilities, file sharing, and user authentication.',
        imageUrl: 'assets/images/chat_app.png',
        technologies: ['Flutter', 'Firebase', 'WebSockets'],
        features: ['Real-time messaging', 'File sharing', 'User profiles'],
        isGradientBackground: true,
        gradientColors: ['0xFF00796B', '0xFF0288D1'],
      ),
    ];
  }
}
