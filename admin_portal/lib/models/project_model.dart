class Project {
  String id;
  String name;
  String description;
  ProjectAdmin projectAdmin;
  List<Worker> workers;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.projectAdmin,
    required this.workers,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      projectAdmin: ProjectAdmin.fromJson(json['projectAdmin']),
      workers: List<Worker>.from(json['workers'].map((x) => Worker.fromJson(x))),
    );
  }
}

class ProjectAdmin {
  List<String> assignedProjects;
  String id;
  String username;
  String email;
  String fullName;
  String password;
  String role;
  String department;
  String createdAt;
  String updatedAt;

  ProjectAdmin({
    required this.assignedProjects,
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.password,
    required this.role,
    required this.department,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectAdmin.fromJson(Map<String, dynamic> json) {
    return ProjectAdmin(
      assignedProjects: List<String>.from(json['assignedProjects']),
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
      role: json['role'],
      department: json['department'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Worker {
  List<String> assignedProjects;
  String id;
  String username;
  String email;
  String fullName;
  String password;
  String role;
  String department;
  String createdAt;
  String updatedAt;
  String? refreshToken;

  Worker({
    required this.assignedProjects,
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.password,
    required this.role,
    required this.department,
    required this.createdAt,
    required this.updatedAt,
    this.refreshToken,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      assignedProjects: List<String>.from(json['assignedProjects']),
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
      role: json['role'],
      department: json['department'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      refreshToken: json.containsKey('refreshToken') ? json['refreshToken'] : null,
    );
  }
}

class ProjectList {
  List<Project> projects;

  ProjectList({
    required this.projects,
  });

  factory ProjectList.fromJson(Map<String, dynamic> json) {
    return ProjectList(
      projects: List<Project>.from(json['projects'].map((x) => Project.fromJson(x))),
    );
  }
}
