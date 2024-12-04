// modules/search/views/search_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as custom_search_controller;
import '../../jobs/controllers/job_controller.dart';

class SearchView extends GetView<custom_search_controller.SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rechercher des offres'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          )
        ],
      ),
      body: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher des emplois...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: controller.clearFilters,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: controller.performSearch,
            ),
          ),

          // Active Filters Row
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (controller.selectedLocation.value.isNotEmpty)
                  _buildFilterChip(
                    label: controller.selectedLocation.value, 
                    onDeleted: () => controller.selectedLocation.value = ''
                  ),
                if (controller.selectedJobType.value.isNotEmpty)
                  _buildFilterChip(
                    label: controller.selectedJobType.value, 
                    onDeleted: () => controller.selectedJobType.value = ''
                  ),
              ],
            ),
          )),

          // Search Results
          Expanded(
            child: Obx(() {
              final jobs = controller.filteredJobs;
              
              if (jobs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 100, color: Colors.grey),
                      Text(
                        'Aucun résultat ne correspond à votre recherche',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.separated(
                itemCount: jobs.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return ListTile(
                    title: Text(
                      job.title, 
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job.company),
                        Text(job.location, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () => Get.find<JobController>().selectJob(job),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Filter Chip Widget
  Widget _buildFilterChip({
    required String label, 
    required VoidCallback onDeleted
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label),
        deleteIcon: Icon(Icons.close),
        onDeleted: onDeleted,
      ),
    );
  }

  // Bottom Sheet for Advanced Filtering
  void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtres avancés', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            
            // Location Filter
            Text('Localisation'),
            Obx(() => Wrap(
              spacing: 8,
              children: controller.locations.map((location) => 
                ChoiceChip(
                  label: Text(location),
                  selected: controller.selectedLocation.value == location,
                  onSelected: (bool selected) {
                    controller.selectedLocation.value = 
                      selected ? location : '';
                    controller.performSearch(
                      controller.searchController.text
                    );
                  },
                )
              ).toList(),
            )),

            SizedBox(height: 16),
            
            // Job Type Filter
            Text('Type de contrat'),
            Obx(() => Wrap(
              spacing: 8,
              children: controller.jobTypes.map((type) => 
                ChoiceChip(
                  label: Text(type),
                  selected: controller.selectedJobType.value == type,
                  onSelected: (bool selected) {
                    controller.selectedJobType.value = 
                      selected ? type : '';
                    controller.performSearch(
                      controller.searchController.text
                    );
                  },
                )
              ).toList(),
            )),

            SizedBox(height: 16),
            
            // Apply Filters Button
            Center(
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Appliquer'),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
    );
  }
}