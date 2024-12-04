// modules/jobs/controllers/job_controller.dart
import 'package:get/get.dart';

class Job {
  final String id;
  final String title;
  final String company;
  final String description;
  final String location;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.location,
  });
}

class JobController extends GetxController {
  final RxList<Job> jobs = <Job>[].obs;
  final Rx<Job?> selectedJob = Rx<Job?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void fetchJobs() {
    // Simulation de récupération de jobs
    jobs.value = [
      Job(
        id: '1', 
        title: 'Développeur Flutter', 
        company: 'Tech Solutions',
        description: 'Développement d\'applications mobiles multiplateformes',
        location: 'Paris'
      ),
      Job(
        id: '2', 
        title: 'Concepteur UX/UI', 
        company: 'Design Agency',
        description: 'Création d\'interfaces utilisateur intuitives',
        location: 'Lyon'
      ),
        Job(
        id: '3', 
        title: 'Developpeur Fullstack', 
        company: 'Tech Solutions',
        description: 'Création d\'application web/mobile  intuitives',
        location: 'Dakar'
      ),
    ];
  }

  void selectJob(Job job) {
    selectedJob.value = job;
    Get.toNamed('/job-detail');
  }
}