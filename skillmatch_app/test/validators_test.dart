import 'package:flutter_test/flutter_test.dart';
import 'package:skillmatch_app/utils/validators.dart';

void main() {
  group('Validators.validateEmail', () {
    test('returns error when email is empty', () {
      // Arrange
      const email = '';

      // Act
      final result = Validators.validateEmail(email);

      // Assert
      expect(result, 'Email wajib diisi');
    });

    test('returns error when email format is invalid', () {
      // Arrange
      const email = 'testmail.com';

      // Act
      final result = Validators.validateEmail(email);

      // Assert
      expect(result, 'Format email tidak valid');
    });

    test('returns null when email is valid', () {
      // Arrange
      const email = 'test@mail.com';

      // Act
      final result = Validators.validateEmail(email);

      // Assert
      expect(result, isNull);
    });
  });

  group('Validators.validatePassword', () {
    test('returns error when password is empty', () {
      // Arrange
      const password = '';

      // Act
      final result = Validators.validatePassword(password);

      // Assert
      expect(result, 'Password wajib diisi');
    });

    test('returns error when password is too short (<6)', () {
      // Arrange
      const password = '12345';

      // Act
      final result = Validators.validatePassword(password);

      // Assert
      expect(result, 'Password minimal 6 karakter');
    });

    test('returns null when password is valid', () {
      // Arrange
      const password = '123456';

      // Act
      final result = Validators.validatePassword(password);

      // Assert
      expect(result, isNull);
    });
  });

  group('Validators.validateNotEmpty', () {
    test('returns error when value is empty', () {
      // Arrange
      const name = '   ';

      // Act
      final result = Validators.validateNotEmpty(name, fieldName: 'Nama');

      // Assert
      expect(result, 'Nama wajib diisi');
    });

    test('returns null when value is not empty', () {
      // Arrange
      const location = 'Surabaya';

      // Act
      final result = Validators.validateNotEmpty(location, fieldName: 'Lokasi');

      // Assert
      expect(result, isNull);
    });
  });
}
