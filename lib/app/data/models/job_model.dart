import 'package:get/get.dart';

enum JobCategory {
  development,
  design,
  marketing,
  sales,
  management,
  finance,
  support,
  other
}

enum JobType {
  fullTime,
  partTime,
  freelance,
  contract,
  internship
}

class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String location;
  final JobCategory category;
  final JobType type;
  final double salary;
  final String description;
  final List<String> requirements;
  final DateTime postingDate;
  final String companyLogoUrl;
  final RxInt applicationCount = 0.obs;

  JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.category,
    required this.type,
    required this.salary,
    required this.description,
    required this.requirements,
    required this.postingDate,
    required this.companyLogoUrl,
  });

  // Méthodes de conversion JSON
  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json['id'],
        title: json['title'],
        companyName: json['companyName'],
        location: json['location'],
        category: JobCategory.values.firstWhere(
          (e) => e.toString() == json['category'],
          orElse: () => JobCategory.other,
        ),
        type: JobType.values.firstWhere(
          (e) => e.toString() == json['type'],
          orElse: () => JobType.fullTime,
        ),
        salary: (json['salary'] as num).toDouble(),
        description: json['description'],
        requirements: List<String>.from(json['requirements']),
        postingDate: DateTime.parse(json['postingDate']),
        companyLogoUrl: json['companyLogoUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'companyName': companyName,
        'location': location,
        'category': category.toString(),
        'type': type.toString(),
        'salary': salary,
        'description': description,
        'requirements': requirements,
        'postingDate': postingDate.toIso8601String(),
        'companyLogoUrl': companyLogoUrl,
      };
}