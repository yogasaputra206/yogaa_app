class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    // Regex for email format validation
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    // Regex for at least one letter and one number
    final bool hasLetterAndNumber = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(value);
    if (!hasLetterAndNumber) {
      return 'Password harus mengandung huruf dan angka';
    }
    return null;
  }
}
