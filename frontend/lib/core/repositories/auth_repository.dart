// Repository Layer (Data Access)
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../database/database_helper.dart';
import '../models/user.dart';
import '../models/patient.dart';
import '../models/doctor.dart';

class AuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Hash password
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Generate OTP
  String _generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Register Patient
  Future<bool> registerPatient({
    required String email,
    required String password,
    required String fullName,
    required int age,
    required String gender,
    String? medicalHistory,
  }) async {
    try {
      // Check if user already exists
      final existingUser = await _dbHelper.getUserByEmail(email);
      if (existingUser != null) {
        throw Exception('User already exists');
      }

      // Create user
      final user = User(
        email: email,
        password: _hashPassword(password),
        userType: UserType.patient,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final userId = await _dbHelper.insertUser(user);

      // Create patient profile
      final patient = Patient(
        userId: userId,
        fullName: fullName,
        age: age,
        gender: gender,
        medicalHistory: medicalHistory,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _dbHelper.insertPatient(patient);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Register Doctor
  Future<bool> registerDoctor({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String dob,
    required String gender,
    required String licenseNumber,
    required String licenseAuthority,
    required String licenseExpiry,
    required String specialization,
    required int experience,
    required String hospital,
    required String workAddress,
    String? licenseFile,
    String? idFile,
    String? profilePhoto,
    String? signatureFile,
    String? stampFile,
  }) async {
    try {
      // Check if user already exists
      final existingUser = await _dbHelper.getUserByEmail(email);
      if (existingUser != null) {
        throw Exception('User already exists');
      }

      // Create user
      final user = User(
        email: email,
        password: _hashPassword(password),
        userType: UserType.doctor,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final userId = await _dbHelper.insertUser(user);

      // Create doctor profile
      final doctor = Doctor(
        userId: userId,
        fullName: fullName,
        phone: phone,
        dob: dob,
        gender: gender,
        licenseNumber: licenseNumber,
        licenseAuthority: licenseAuthority,
        licenseExpiry: licenseExpiry,
        specialization: specialization,
        experience: experience,
        hospital: hospital,
        workAddress: workAddress,
        licenseFile: licenseFile,
        idFile: idFile,
        profilePhoto: profilePhoto,
        signatureFile: signatureFile,
        stampFile: stampFile,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _dbHelper.insertDoctor(doctor);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final user = await _dbHelper.getUserByEmail(email);
      if (user == null) {
        return null;
      }

      if (user.password != _hashPassword(password)) {
        return null;
      }

      // Get user profile based on type
      if (user.userType == UserType.patient) {
        final patient = await _dbHelper.getPatientByUserId(user.id!);
        return {
          'user': user,
          'profile': patient,
        };
      } else {
        final doctor = await _dbHelper.getDoctorByUserId(user.id!);
        return {
          'user': user,
          'profile': doctor,
        };
      }
    } catch (e) {
      return null;
    }
  }

  // Send OTP
  Future<bool> sendOTP(String email) async {
    try {
      final otp = _generateOTP();
      final expiresAt = DateTime.now().add(const Duration(minutes: 10));
      
      await _dbHelper.insertOTP(email, otp, expiresAt);
      
      // In real app, send OTP via email/SMS
      print('OTP for $email: $otp'); // For debugging
      
      return true;
    } catch (e) {
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOTP(String email, String otp) async {
    return await _dbHelper.verifyOTP(email, otp);
  }

  // Reset Password
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final user = await _dbHelper.getUserByEmail(email);
      if (user == null) {
        return false;
      }

      final updatedUser = user.copyWith(
        password: _hashPassword(newPassword),
        updatedAt: DateTime.now(),
      );

      await _dbHelper.updateUser(updatedUser);
      return true;
    } catch (e) {
      return false;
    }
  }
}