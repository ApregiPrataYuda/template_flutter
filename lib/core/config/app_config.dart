class AppConfig {
  AppConfig._();

  /// true  = pakai data palsu (backend belum ada)
  /// false = panggil API sungguhan
  static const bool useMock = true;

  /// Alamat backend.
  /// Emulator Android: 10.0.2.2 = "localhost" milik komputer kamu.
  /// HP asli: pakai IP komputer di jaringan yang sama, misal http://192.168.1.10:8000/api
  static const String baseUrl = 'http://10.0.2.2:8000/api';
}