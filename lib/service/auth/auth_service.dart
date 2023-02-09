
import 'package:student_app/service/auth/auth_provider.dart';
import 'package:student_app/service/auth/auth_user.dart';
import 'package:student_app/service/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> createUser({
    required String username,
    required String email,
    required String password,
  }) =>
      provider.createUser(
         username: username,
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;
  @override
  Future<void> logOUt() => provider.logOUt();

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();}