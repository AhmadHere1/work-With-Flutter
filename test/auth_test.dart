import 'package:flutter_test/flutter_test.dart';
import 'package:fourth_app/services/auth/auth_exceptions.dart';
import 'package:fourth_app/services/auth/auth_provider.dart';
import 'package:fourth_app/services/auth/auth_user.dart';

void main() {
  group('mock Authentication', () {
    final provider = MockAuthProvider();
    test('should not be initialized', () async {
      expect(provider.isInitialized, false);
    });
    test('should not be signed in', () async {
      expect(provider.logOut(),
          throwsA(const TypeMatcher<NonInitializedException>()));
    });
    test('should not be signed in', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('user should be null after initialization', () async {
      expect(provider.currentUser, null);
    });
    test('should be able to initialize', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('user should delegate to login screen after initialization', () async {
      final badEmailUser = provider.createUser(
        email: 'zoo@gmail.com',
        password: '123456',
      );
      expect(badEmailUser, throwsA(const TypeMatcher<InvalidEmailException>()));
    });
  });
}

class NonInitializedException implements Exception {}

class InvalidEmailException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NonInitializedException();
    await Future.delayed(Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NonInitializedException();
    if (email == 'zoo@gmail.com') throw UserNotFoundAuthException();
    if (password == '123456') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NonInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NonInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
    throw UnimplementedError();
  }
}
