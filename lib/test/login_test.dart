/* import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:supabase/supabase.dart';

import '../core/services/auth_service.dart';

class MockAuthService extends Mock implements AuthService {}

void main() async {
  await dotenv.load(fileName: '.env');
  group('AuthController', () {
    test('signUp signs up with email, password and gender', () async {
      // Arrange
      final mockAuthService = MockAuthService();
      final controller = AuthController(authService: mockAuthService);
      // controller.authService = mockAuthService;
      when(mockAuthService.signUpWithEmailAndPassword(
              "test@example.com", "password"))
          .thenAnswer((_) async => AuthResponse());

      // Act
      await controller.signUp(
          email: 'test@example.com', password: 'password', gender: 'FEMME');

      // Assert
      verify(mockAuthService.signUpWithEmailAndPassword(
              'test@example.com', 'password'))
          .called(1);
    });
  });
}
 */

// auth_controller_test.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:flame_game/core/services/auth_service.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  group('AuthController', () {
    test('Informations valides', () async {
      // Utilisation du service réel
      final authService = AuthService();

      final controller = AuthController(authService: authService);

      // Appel de la méthode à tester
      final res = await controller.signUp(
          email: 'user50@email.com', password: 'password', gender: 'MALE');

      // Vérification des arguments passés
      expect(res, true);
    });
    test('Informations invalides', () async {
      // Utilisation du service réel
      final authService = AuthService();

      final controller = AuthController(authService: authService);

      // Appel de la méthode à tester
      final res = await controller.signUp(
          email: 'user50@email.com', password: 'password', gender: 'MALE');

      // Vérification des arguments passés
      expect(res, false);
    });
  });
}
