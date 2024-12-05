import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';

class JobListView extends GetView<JobController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Offres d\'emploi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Profile Picture
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => Get.toNamed('/profile'), 
              child: Obx(() {
                final profilePicture = controller.profilePicture.value;
                return CircleAvatar(
                  radius: 18,
                  backgroundImage: profilePicture != null
                      ? NetworkImage(profilePicture)
                      : null,
                  child: profilePicture == null 
                      ? Icon(Icons.person, size: 18, color: Colors.grey)
                      : null,
                );
              }),
            ),
          ),
          
          // Search Icon
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () => Get.toNamed('/search'),
          ),
          
          // Filter Icon
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // TODO: Implémenter la logique de filtrage
            },
          ),
          
          // Logout Popup Menu
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutConfirmationDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Déconnexion', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search TextField (existing code remains the same)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher des emplois...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Job List (existing code remains the same)
          Expanded(
            child: Obx(() => controller.jobs.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: controller.jobs.length,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final job = controller.jobs[index];
                      return _buildJobCard(job, context);
                    },
                  )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implémenter la logique d'ajout de job
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }

  // Logout Confirmation Dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnexion'),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Déconnexion'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                
                // Call logout method from controller
                controller.logout();
              },
            ),
          ],
        );
      },
    );
  }
Widget _buildJobCard(dynamic job, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectJob(job),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    job.company.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${job.company} • ${job.location}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        _buildJobTag('Temps plein'),
                        SizedBox(width: 8),
                        _buildJobTag('Senior'),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.deepPurple,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.workspace_premium_outlined,
            size: 100,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16),
          Text(
            'Aucune offre d\'emploi disponible',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Revenez plus tard ou élargissez votre recherche',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  // Existing methods (_buildJobCard, _buildJobTag, _buildEmptyState) remain the same
  // ... (copy from previous implementation)
}






