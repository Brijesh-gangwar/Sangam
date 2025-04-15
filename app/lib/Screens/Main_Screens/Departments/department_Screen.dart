import 'package:app/Api%20_Services/api.dart';
import 'package:app/Models/model_dept.dart';
import 'package:flutter/material.dart';

class DepartmentsScreen extends StatefulWidget {
  const DepartmentsScreen({super.key});

  @override
  _DepartmentsScreenState createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  List<Departments> departments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDepartments(); // Fetch data when the screen loads
  }

  // Method to fetch data and update the state
  Future<void> fetchDepartments() async {
    try {
      final apiService = ApiServices();
      final List<Departments> fetchedDepartments =
          await apiService.getAllDepartments();
      setState(() {
        departments = fetchedDepartments;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : departments.isEmpty
              ? const Center(child: Text('No departments found'))
              : ListView.builder(
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text("id ${departments[index].id}"),
                          Text("dept name ${departments[index].id}"),
                          Text("description ${departments[index].description}"),
                        ],
                      ),
                    );
                  }),
    );
  }
}
