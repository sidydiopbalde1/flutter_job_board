// modules/search/controllers/search_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../jobs/controllers/job_controller.dart';

class SearchController extends GetxController {
  final JobController jobController = Get.find();
  
  final searchController = TextEditingController();
  final RxList<Job> filteredJobs = <Job>[].obs;
  
  // Filtering options
  final RxString selectedLocation = ''.obs;
  final RxString selectedJobType = ''.obs;
  
  // Available filter options
  final locations = ['Paris', 'Lyon', 'Marseille', 'Toulouse', 'Toute la France'];
  final jobTypes = ['CDI', 'CDD', 'Freelance', 'Stage', 'Alternance'];

  void performSearch(String query) {
    filteredJobs.value = jobController.jobs.where((job) {
      final matchesQuery = query.isEmpty || 
        job.title.toLowerCase().contains(query.toLowerCase()) ||
        job.company.toLowerCase().contains(query.toLowerCase()) ||
        job.location.toLowerCase().contains(query.toLowerCase());
      
      final matchesLocation = selectedLocation.value.isEmpty || 
        job.location == selectedLocation.value;
      
      // Add more filter logic as needed
      
      return matchesQuery && matchesLocation;
    }).toList();
  }

  void clearFilters() {
    searchController.clear();
    selectedLocation.value = '';
    selectedJobType.value = '';
    filteredJobs.value = [];
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}