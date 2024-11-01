import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'contact_list_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService authService = AuthService();
  final String? token = await authService.getToken();

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Agenda',
      theme: ThemeData.dark(),  // Dark mode enabled
      home: isLoggedIn ? ContactListScreen() : LoginScreen(),
    );
  }
}

// AuthService class for handling secure storage operations
class AuthService {
  final _storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'user_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'user_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'user_token');
  }
}
