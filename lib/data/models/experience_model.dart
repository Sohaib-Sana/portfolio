class ExperienceModel {
  final String position;
  final String company;
  final String duration;
  final String? employmentType;
  final String? certificate;
  final String? coverLetter;

  ExperienceModel({
    required this.position,
    required this.company,
    required this.duration,
    this.employmentType,
    this.certificate,
    this.coverLetter,
  });

  static List<ExperienceModel> getDummyExperiences() {
    return [
      ExperienceModel(
        position: 'Flutter Mentor',
        company: 'Cellula Technologies',
        duration: 'Feb 2025 - Present',
        employmentType: 'Part-Time',
      ),
      ExperienceModel(
        position: 'Flutter Developer',
        company: 'Slash Hub',
        duration: 'July 2024 - Oct 2024',
        employmentType: 'Full-Time',
        certificate: 'Certificate',
      ),
      ExperienceModel(
        position: 'Flutter Developer',
        company: 'SuperLabs',
        duration: 'Nov 2023 - Feb 2024',
        employmentType: 'Full-Time',
        certificate: 'Certificate',
        coverLetter: 'Cover Letter',
      ),
    ];
  }
}
