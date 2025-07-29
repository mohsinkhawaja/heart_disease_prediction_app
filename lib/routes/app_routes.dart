abstract class AppRoutes {
  // Auth Routes
  static const String splash = '/splash';
  static const String userTypeSelection = '/user-type-selection';
  static const String patientLogin = '/patient-login';
  static const String patientRegister = '/patient-register';
  static const String doctorLogin = '/doctor-login';
  static const String doctorRegister = '/doctor-register';
  static const String adminLogin = '/admin-login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String otpVerification = '/otp-verification';

  // Patient Routes
  static const patientHome = '/patient-home';
  static const String patientDashboard = '/patient-dashboard';
  static const String patientProfile = '/patient-profile';
  static const String uploadEcg = '/upload-ecg';
  static const String heartPrediction = '/heart-prediction';
  static const String diagnosisReports = '/diagnosis-reports';
  static const String consultationHistory = '/consultation-history';
  static const String submitComplaint = '/submit-complaint';
  static const String provideFeedback = '/provide-feedback';
  static const String healthData = '/health-data';

  // Admin Routes
  static const String adminDashboard = '/admin-dashboard';
  static const String adminPatientManagement = '/admin-patient-management';
  static const String adminDoctorManagement = '/admin-doctor-management';
  static const String adminDoctorApprovals = '/admin-doctor-approvals';
  static const String adminReportsManagement = '/admin-reports-management';
  static const String adminComplaints = '/admin-complaints';
  static const String adminFeedbackManagement = '/admin-feedback-management';
  static const String adminSettings = '/admin-settings';
  static const String adminUserManagement = '/admin-user-management';
  static const String adminSystemReports = '/admin-system-reports';
  static const String adminPendingActions = '/admin-pending-actions';
  static const String adminActivityLog = '/admin-activity-log';

  // Doctor Routes (for future implementation)
  static const String doctorDashboard = '/doctor-dashboard';
  static const String doctorProfile = '/doctor-profile';
  static const String doctorPatients = '/doctor-patients';
  static const String doctorReports = '/doctor-reports';

  // Common Routes
  static const String settings = '/settings';
  static const String privacySettings = '/privacy-settings';
  static const String notificationSettings = '/notification-settings';
  static const String changePassword = '/change-password';
  static const String appointmentDetails = '/appointment-details';
  static const String bookAppointment = '/book-appointment';
}
