class Validators {
  /// Return null.
  static String? validateEmail(String? email) {
    final value = (email ?? '').trim();
    if (value.isEmpty) return 'Email wajib diisi';

    // email
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!regex.hasMatch(value)) return 'Format email tidak valid';

    return null;
  }

  /// Return null.
  static String? validatePassword(String? password) {
    final value = (password ?? '');
    if (value.isEmpty) return 'Password wajib diisi';
    if (value.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return '$fieldName wajib diisi';
    return null;
  }
}
