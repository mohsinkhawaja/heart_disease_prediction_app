import 'package:flutter/material.dart';
import 'package:frontend/features/admin_dashboard/presentation/bindings/admin_dashboard_binding.dart';
import 'package:frontend/features/admin_dashboard/presentation/view/admin_dashboard_view.dart';
import 'package:frontend/features/auth/presentation/bindings/doctor_login_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/doctor_register_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/forgot_password_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/otp_verification_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/patient_login_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/patient_register_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/reset_password_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/splash_view_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/user_type_selection_binding.dart';
import 'package:frontend/features/auth/presentation/view/doctor_login_view.dart';
import 'package:frontend/features/auth/presentation/view/doctor_register_view.dart';
import 'package:frontend/features/auth/presentation/view/forgot_password_view.dart';
import 'package:frontend/features/auth/presentation/view/otp_verification_view.dart';
import 'package:frontend/features/auth/presentation/view/patient_login_view.dart';
import 'package:frontend/features/auth/presentation/view/patient_register_view.dart'
    show PatientRegisterView;
import 'package:frontend/features/auth/presentation/view/reset_password_view.dart';
import 'package:frontend/features/auth/presentation/view/splash/splash_view.dart';
import 'package:frontend/features/auth/presentation/view/user_type_selection_view.dart';
import 'package:frontend/features/patient_dashboard/presentation/bindings/patient_dashboard_binding.dart';
import 'package:frontend/features/patient_dashboard/presentation/bindings/patient_home_binding.dart';
import 'package:frontend/features/patient_dashboard/presentation/view/patient_dashboard_view.dart';
import 'package:frontend/features/patient_dashboard/presentation/view/patient_home_view.dart';
import 'package:frontend/features/patient_profile/presentation/bindings/patient_profile_binding.dart';
import 'package:frontend/features/patient_profile/presentation/view/patient_profile_view.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    // Auth Routes
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashViewBinding(),
    ),
    GetPage(
      name: AppRoutes.userTypeSelection,
      page: () => const UserTypeSelectionView(),
      binding: UserTypeSelectionBinding(),
    ),
    GetPage(
      name: AppRoutes.patientLogin,
      page: () => const PatientLoginView(),
      binding: PatientLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.patientRegister,
      page: () => const PatientRegisterView(),
      binding: PatientRegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorLogin,
      page: () => const DoctorLoginView(),
      binding: DoctorLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorRegister,
      page: () => const DoctorRegisterView(),
      binding: DoctorRegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),

    // Patient Routes
    GetPage(
      name: AppRoutes.patientHome,
      page: () => const PatientHomeView(),
      binding: PatientHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.patientDashboard,
      page: () => const PatientDashboardView(),
      binding: PatientDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.patientProfile,
      page: () => const PatientProfileView(),
      binding: PatientProfileBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.uploadEcg,
    //   page: () => const UploadEcgView(),
    //   binding: UploadEcgBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.heartPrediction,
    //   page: () => const HeartPredictionView(),
    //   binding: HeartPredictionBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.diagnosisReports,
    //   page: () => const DiagnosisReportsView(),
    //   binding: DiagnosisReportsBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.consultationHistory,
    //   page: () => const ConsultationHistoryView(),
    //   binding: ConsultationHistoryBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.submitComplaint,
    //   page: () => const SubmitComplaintView(),
    //   binding: SubmitComplaintBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.provideFeedback,
    //   page: () => const ProvideFeedbackView(),
    //   binding: ProvideFeedbackBinding(),
    // ),

    // Admin Routes
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.adminPatientManagement,
    //   page: () => const AdminPatientManagementView(),
    //   binding: AdminPatientManagementBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.adminDoctorManagement,
    //   page: () => const AdminDoctorManagementView(),
    //   binding: AdminDoctorManagementBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.adminDoctorApprovals,
    //   page: () => const AdminDoctorApprovalsView(),
    //   binding: AdminDoctorApprovalsBinding(),
    // ),

    // Placeholder routes for future implementation
    GetPage(
      name: AppRoutes.adminReportsManagement,
      page:
          () => const Scaffold(
            body: Center(child: Text('Reports Management - Coming Soon')),
          ),
    ),
    GetPage(
      name: AppRoutes.adminComplaints,
      page:
          () => const Scaffold(
            body: Center(child: Text('Complaints Management - Coming Soon')),
          ),
    ),
    GetPage(
      name: AppRoutes.adminSettings,
      page:
          () => const Scaffold(
            body: Center(child: Text('Admin Settings - Coming Soon')),
          ),
    ),
  ];
}

class BaseAuthBinding {}


// // Placeholder bindings for future features
// class UploadEcgBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement UploadEcgViewModel
//   }
// }

// class HeartPredictionBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement HeartPredictionViewModel
//   }
// }

// class DiagnosisReportsBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement DiagnosisReportsViewModel
//   }
// }

// class ConsultationHistoryBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement ConsultationHistoryViewModel
//   }
// }

// class SubmitComplaintBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement SubmitComplaintViewModel
//   }
// }

// class ProvideFeedbackBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement ProvideFeedbackViewModel
//   }
// }

// class AdminPatientManagementBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement AdminPatientManagementViewModel
//   }
// }

// class AdminDoctorManagementBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement AdminDoctorManagementViewModel
//   }
// }

// class AdminDoctorApprovalsBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: Implement AdminDoctorApprovalsViewModel
//   }
// }