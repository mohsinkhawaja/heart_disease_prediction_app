class Patient {
  final int? id;
  final int userId;
  final String fullName;
  final int age;
  final String gender;
  final String? medicalHistory;
  final String? profilePhoto;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Patient({
    this.id,
    required this.userId,
    required this.fullName,
    required this.age,
    required this.gender,
    this.medicalHistory,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'age': age,
      'gender': gender,
      'medical_history': medicalHistory,
      'profile_photo': profilePhoto,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      userId: map['user_id'],
      fullName: map['full_name'],
      age: map['age'],
      gender: map['gender'],
      medicalHistory: map['medical_history'],
      profilePhoto: map['profile_photo'],
      createdAt: map['created_at'] != null 
        ? DateTime.parse(map['created_at']) 
        : null,
      updatedAt: map['updated_at'] != null 
        ? DateTime.parse(map['updated_at']) 
        : null,
    );
  }

  Patient copyWith({
    int? id,
    int? userId,
    String? fullName,
    int? age,
    String? gender,
    String? medicalHistory,
    String? profilePhoto,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Patient(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}