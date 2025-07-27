enum UserType { patient, doctor }

class User {
  final int? id;
  final String email;
  final String password;
  final UserType userType;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.userType,
    this.isVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'user_type': userType.name,
      'is_verified': isVerified ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      userType: UserType.values.firstWhere(
        (e) => e.name == map['user_type']
      ),
      isVerified: map['is_verified'] == 1,
      createdAt: map['created_at'] != null 
        ? DateTime.parse(map['created_at']) 
        : null,
      updatedAt: map['updated_at'] != null 
        ? DateTime.parse(map['updated_at']) 
        : null,
    );
  }

  User copyWith({
    int? id,
    String? email,
    String? password,
    UserType? userType,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}