import 'package:student_app/service/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String username,
    required String email,
    required String password,
  });

  Future<void> logOUt();
  Future<void> sendEmailVerification();
}