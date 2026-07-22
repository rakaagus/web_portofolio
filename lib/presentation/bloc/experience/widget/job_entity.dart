// 1. MODEL DATA EXPERIENCES
class JobRole {
  final String title;
  final String type;
  final String period;
  final List<String> responsibilities;
  final List<String> skills;

  JobRole({
    required this.title,
    required this.type,
    required this.period,
    required this.responsibilities,
    required this.skills,
  });
}

class CompanyExperience {
  final String companyName;
  final String location;
  final String totalPeriod;
  final dynamic logo;
  final List<JobRole> jobs;

  CompanyExperience({
    required this.companyName,
    required this.location,
    required this.totalPeriod,
    required this.logo,
    required this.jobs,
  });
}