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
        position: 'Software Engineer',
        company: 'PlanetBeyond - Highersummit',
        duration: 'May 2024 - Present',
        employmentType: 'Full-Time',
        certificate: 'Certificate',
      ),
      ExperienceModel(
        position: 'Software Engineer',
        company: 'PlanetBeyond - Highersummit',
        duration: 'Dec 2023 - May 2024',
        employmentType: 'Intern',
        certificate: 'Certificate',
        coverLetter: 'Cover Letter',
      ),
      ExperienceModel(
        position: 'Flutter Developr',
        company: 'Open Network',
        duration: 'Jun 2023 - Dec 2023',
        employmentType: 'Freelancer',
      ),
    ];
  }
}
