import 'package:admin_portal/basic_layout.dart';

import 'package:flutter/material.dart';
import 'package:admin_portal/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BasicLayout();
            },
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(project.name),
          subtitle: Text('ID: ${project.id}'),
        ),
      ),
    );
  }
}
