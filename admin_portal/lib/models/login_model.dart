class LoginModel {
    int statusCode;
    Data data;
    String message;
    bool success;

    LoginModel({
        required this.statusCode,
        required this.data,
        required this.message,
        required this.success,
    });

    LoginModel copyWith({
        int? statusCode,
        Data? data,
        String? message,
        bool? success,
    }) => 
        LoginModel(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
            message: message ?? this.message,
            success: success ?? this.success,
        );
}

class Data {
    User user;
    String accessToken;
    String refreshToken;

    Data({
        required this.user,
        required this.accessToken,
        required this.refreshToken,
    });

    Data copyWith({
        User? user,
        String? accessToken,
        String? refreshToken,
    }) => 
        Data(
            user: user ?? this.user,
            accessToken: accessToken ?? this.accessToken,
            refreshToken: refreshToken ?? this.refreshToken,
        );
}

class User {
    String id;
    String username;
    String email;
    String fullName;
    String role;
    String department;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.fullName,
        required this.role,
        required this.department,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    User copyWith({
        String? id,
        String? username,
        String? email,
        String? fullName,
        String? role,
        String? department,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? v,
    }) => 
        User(
            id: id ?? this.id,
            username: username ?? this.username,
            email: email ?? this.email,
            fullName: fullName ?? this.fullName,
            role: role ?? this.role,
            department: department ?? this.department,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            v: v ?? this.v,
        );
}
