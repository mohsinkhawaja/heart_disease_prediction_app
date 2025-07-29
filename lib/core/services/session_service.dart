import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/patient.dart';
import '../models/doctor.dart';
import 'dart:convert';

class SessionService {
  static const String _userKey = 'current_user';
  static const String _patientKey = 'patient_profile';
  static const String _doctorKey = 'doctor_profile';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save user session
  static Future<void> saveSession({
    required User user,
    Patient? patient,
    Doctor? doctor,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_userKey, jsonEncode(user.toMap()));
    await prefs.setBool(_isLoggedInKey, true);
    
    if (patient != null) {
      await prefs.setString(_patientKey, jsonEncode(patient.toMap()));
    }
    
    if (doctor != null) {
      await prefs.setString(_doctorKey, jsonEncode(doctor.toMap()));
    }
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson != null) {
      return User.fromMap(jsonDecode(userJson));
    }
    return null;
  }

  // Get patient profile
  static Future<Patient?> getPatientProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final patientJson = prefs.getString(_patientKey);
    
    if (patientJson != null) {
      return Patient.fromMap(jsonDecode(patientJson));
    }
    return null;
  }

  // Get doctor profile
  static Future<Doctor?> getDoctorProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final doctorJson = prefs.getString(_doctorKey);
    
    if (doctorJson != null) {
      return Doctor.fromMap(jsonDecode(doctorJson));
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Clear session (logout)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_patientKey);
    await prefs.remove(_doctorKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Update patient profile
  static Future<void> updatePatientProfile(Patient patient) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_patientKey, jsonEncode(patient.toMap()));
  }

  // Update doctor profile
  static Future<void> updateDoctorProfile(Doctor doctor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_doctorKey, jsonEncode(doctor.toMap()));
  }
}