import '../data/models/job_model.dart';

class JobRepository {
  // Simule une base de données ou une API
  Future<List<JobModel>> getAllJobs() async {
    // Simulation de données
    await Future.delayed(Duration(seconds: 1)); // Délai simulé de chargement

    return [
      JobModel(
        id: '1',
        title: 'Développeur Flutter',
        companyName: 'Tech Innovations',
        location: 'Paris, France',
        type: JobType.fullTime,
        salary: 55000,
        description: 'Nous recherchons un développeur Flutter passionné...',
        requirements: [
          'Maîtrise de Flutter',
          '3+ ans d\'expérience',
          'Connaissance de Dart'
        ],
        postingDate: DateTime.now(),
        companyLogoUrl: 'https://example.com/logo.png',
        category: JobCategory.development
      ),
      JobModel(
        id: '2',
        title: 'Product Manager',
        companyName: 'Startup Genius',
        location: 'Lyon, France',
        type: JobType.partTime,
        salary: 45000,
        description: 'Rejoignez notre équipe dynamique...',
        requirements: [
          'Expérience en gestion de produit',
          'Sens de la communication',
          'Créativité'
        ],
        postingDate: DateTime.now().subtract(Duration(days: 3)),
        companyLogoUrl: 'https://example.com/logo2.png',
        category: JobCategory.marketing
      ),
    ];
  }

  Future<void> createJob(JobModel job) async {
    // Simulation de création d'une offre
    await Future.delayed(Duration(seconds: 1));
    print('Job created: ${job.title}');
  }

  Future<void> deleteJob(String jobId) async {
    // Simulation de suppression d'une offre
    await Future.delayed(Duration(seconds: 1));
    print('Job deleted: $jobId');
  }
}