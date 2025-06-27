import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final storage = FlutterSecureStorage();

// Save token
Future<void> saveToken(String token) async {
  try{
    await storage.write(key: 'auth_token', value: token);
    print('Token saved successfully');
  } catch (e) {
    print('Error saving token: $e');
  }
} 

// Read token
Future<String?> readToken() async {
  try {
    return await storage.read(key: 'auth_token');
  } catch (e) {
    print('Error reading token: $e');
    return null;
  }
}

// Delete a value
Future<void> deleteToken() async {
  try {
    await storage.delete(key: 'auth_token');
    print('Token deleted successfully');
  } catch (e) {
    print('Error deleting token: $e');
  }
}
