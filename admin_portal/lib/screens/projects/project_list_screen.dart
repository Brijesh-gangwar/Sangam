import 'package:admin_portal/models/project_model.dart';
import 'package:admin_portal/widgets/project_card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  List<Project> _projectList = [];
  bool isLoading = false;

  // Fetch data from API
  Future<void> getProjects() async {
    final url =
        Uri.parse('https://backend-code-4-nnid.onrender.com/api/getProject');

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decode the JSON data
        final jsonData = json.decode(response.body);

        // Assuming the JSON has a key 'projects' that holds the list of projects
        if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey('projects')) {
          setState(() {
            _projectList = (jsonData['projects'] as List)
                .map((item) => Project.fromJson(item))
                .toList();
            isLoading = false;
          });
        } else {
          throw Exception('Projects key not found in response');
        }
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (error) {
      setState(() {
        _projectList = [];
      });
      print('Error fetching projects: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var b = MediaQuery.sizeOf(context).width;
    return Container(
      width: b * 0.82,
      height: h * 0.84,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _projectList.isEmpty
              ? const Center(child: Text('No projects available'))
              : ListView.builder(
                  itemCount: _projectList.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(project: _projectList[index]);
                  },
                ),
    );
  }
}
