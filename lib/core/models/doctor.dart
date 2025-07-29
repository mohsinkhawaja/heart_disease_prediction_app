class Doctor {
  final int? id;
  final int userId;
  final String fullName;
  final String phone;
  final String dob;
  final String gender;
  final String licenseNumber;
  final String licenseAuthority;
  final String licenseExpiry;
  final String specialization;
  final int experience;
  final String hospital;
  final String workAddress;
  final String? licenseFile;
  final String? idFile;
  final String? profilePhoto;
  final String? signatureFile;
  final String? stampFile;
  final bool isApproved;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Doctor({
    this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.licenseNumber,
    required this.licenseAuthority,
    required this.licenseExpiry,
    required this.specialization,
    required this.experience,
    required this.hospital,
    required this.workAddress,
    this.licenseFile,
    this.idFile,
    this.profilePhoto,
    this.signatureFile,
    this.stampFile,
    this.isApproved = false,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'license_number': licenseNumber,
      'license_authority': licenseAuthority,
      'license_expiry': licenseExpiry,
      'specialization': specialization,
      'experience': experience,
      'hospital': hospital,
      'work_address': workAddress,
      'license_file': licenseFile,
      'id_file': idFile,
      'profile_photo': profilePhoto,
      'signature_file': signatureFile,
      'stamp_file': stampFile,
      'is_approved': isApproved ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      userId: map['user_id'],
      fullName: map['full_name'],
      phone: map['phone'],
      dob: map['dob'],
      gender: map['gender'],
      licenseNumber: map['license_number'],
      licenseAuthority: map['license_authority'],
      licenseExpiry: map['license_expiry'],
      specialization: map['specialization'],
      experience: map['experience'],
      hospital: map['hospital'],
      workAddress: map['work_address'],
      licenseFile: map['license_file'],
      idFile: map['id_file'],
      profilePhoto: map['profile_photo'],
      signatureFile: map['signature_file'],
      stampFile: map['stamp_file'],
      isApproved: map['is_approved'] == 1,
      createdAt: map['created_at'] != null 
        ? DateTime.parse(map['created_at']) 
        : null,
      updatedAt: map['updated_at'] != null 
        ? DateTime.parse(map['updated_at']) 
        : null,
    );
  }

  Doctor copyWith({
    int? id,
    int? userId,
    String? fullName,
    String? phone,
    String? dob,
    String? gender,
    String? licenseNumber,
    String? licenseAuthority,
    String? licenseExpiry,
    String? specialization,
    int? experience,
    String? hospital,
    String? workAddress,
    String? licenseFile,
    String? idFile,
    String? profilePhoto,
    String? signatureFile,
    String? stampFile,
    bool? isApproved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Doctor(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseAuthority: licenseAuthority ?? this.licenseAuthority,
      licenseExpiry: licenseExpiry ?? this.licenseExpiry,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      hospital: hospital ?? this.hospital,
      workAddress: workAddress ?? this.workAddress,
      licenseFile: licenseFile ?? this.licenseFile,
      idFile: idFile ?? this.idFile,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      signatureFile: signatureFile ?? this.signatureFile,
      stampFile: stampFile ?? this.stampFile,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}