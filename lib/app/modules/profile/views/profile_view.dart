import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(), // Corrected parameter name
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Mon Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Obx(() {
                final profile = controller.userProfile.value;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Gradient background
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    // Animated profile picture
                    Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Hero(
                          tag: 'profile_image',
                          child: CircleAvatar(
                            key: ValueKey(profile.profilePicture),
                            radius: 80,
                            backgroundImage: profile.profilePicture != null
                                ? NetworkImage(profile.profilePicture!)
                                : null,
                            child: profile.profilePicture == null 
                                ? Icon(Icons.person, size: 80, color: Colors.white) 
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // User Info
                Center(
                  child: Column(
                    children: [
                      Text(
                        controller.userProfile.value.name, 
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.userProfile.value.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Skills Section
                Text(
                  'Compétences',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Skill Input
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: controller.skillController,
                            decoration: InputDecoration(
                              hintText: 'Ajouter une compétence',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      OpenContainer(
                        closedColor: Colors.transparent,
                        openColor: Colors.transparent,
                        closedBuilder: (context, action) => IconButton(
                          icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                          onPressed: action,
                        ),
                        openBuilder: (context, closeContainer) => Container(),
                        onClosed: (_) => controller.addSkill(),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Skills List
                Obx(() {
                  final skills = controller.userProfile.value.skills;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: skills.isEmpty
                        ? Center(
                            child: Text(
                              'Aucune compétence ajoutée',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: skills.map((skill) => 
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Chip(
                                  label: Text(skill),
                                  deleteIcon: Icon(Icons.close, size: 18),
                                  onDeleted: () => controller.removeSkill(skill),
                                  backgroundColor: Colors.transparent,
                                ),
                              )
                            ).toList(),
                          ),
                  );
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}