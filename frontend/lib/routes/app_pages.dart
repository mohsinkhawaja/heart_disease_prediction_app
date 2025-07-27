import 'package:frontend/features/auth/presentation/bindings/doctor_login_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/doctor_register_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/forgot_password_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/otp_verification_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/patient_login_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/patient_register_binding.dart';
import 'package:frontend/features/auth/presentation/bindings/reset_password_binding.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/view/splash/splash_view.dart';
import '../features/auth/presentation/view/user_type_selection_view.dart';
import '../features/auth/presentation/view/patient_login_view.dart';
import '../features/auth/presentation/view/patient_register_view.dart';
import '../features/auth/presentation/view/doctor_login_view.dart';
import '../features/auth/presentation/view/doctor_register_view.dart';
import '../features/auth/presentation/view/forgot_password_view.dart';
import '../features/auth/presentation/view/otp_verification_view.dart';
import '../features/auth/presentation/view/reset_password_view.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(
      name: AppRoutes.userType,
      page: () => const UserTypeSelectionView(),
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
      page: () => DoctorRegisterView(),
      binding: DoctorRegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
