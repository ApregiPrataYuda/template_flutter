class Validators {
  Validators._();

  static String? required(String? value, {String field = 'Kolom ini'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field wajib diisi';
    }
    return null;
  }

  static String? email(String? value) {
    final empty = required(value, field: 'Email');
    if (empty != null) return empty;

    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value!.trim())) return 'Format email tidak valid';
    return null;
  }

  static String? password(String? value) {
    final empty = required(value, field: 'Password');
    if (empty != null) return empty;

    if (value!.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    final empty = required(value, field: 'Konfirmasi password');
    if (empty != null) return empty;

    if (value != original) return 'Konfirmasi password tidak sama';
    return null;
  }
}