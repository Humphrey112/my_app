import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  // SIGN UP
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveToken();
      return credential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  // SIGN IN
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveToken();
      return credential.user;
    } catch (e) {
      throw e.toString();
    }
  }

  // SAVE TOKEN
  Future<void> _saveToken() async {
    final token = await _auth.currentUser?.getIdToken();
    box.write('token', token);
  }

  // GET USER EMAIL
  String? getUserEmail() {
    return _auth.currentUser?.email;
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    box.remove('token');
  }
}
