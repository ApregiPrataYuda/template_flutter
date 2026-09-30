import 'package:flutter/material.dart';
import 'app.dart';
import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = StorageService();
  final api = ApiService(storage);
  final repository = AuthRepository(api: api, storage: storage);
  final auth = AuthProvider(repository);

  api.onUnauthorized = auth.handleUnauthorized;

  await auth.init();

  runApp(App(auth: auth, api: api));
}