abstract class AppRoutes {
  // Core routes
  static const initial = '/';
  static const splash = '/splash';
  static const userType = '/select-user';
  
  // Auth routes
  static const patientLogin = '/patient-login';
  static const patientRegister = '/patient-register';
  static const doctorLogin = '/doctor-login';
  static const doctorRegister = '/doctor-register';
  static const forgotPassword = '/forgot-password';
  static const otpVerification = '/otp-verification';
  static const resetPassword = '/reset-password';
  
  // Dashboard routes
  static const patientDashboard = '/patient-dashboard';
  static const doctorDashboard = '/doctor-dashboard';
  
  // Patient routes
  static const patientProfile = '/patient-profile';
  static const ecgScan = '/ecg-scan';
  static const healthReports = '/health-reports';
  
  // Doctor routes
  static const doctorProfile = '/doctor-profile';
  static const patientList = '/patient-list';
  static const patientDetails = '/patient-details';
  
  // Common routes
  static const settings = '/settings';
  static const about = '/about';
  static const help = '/help';
}