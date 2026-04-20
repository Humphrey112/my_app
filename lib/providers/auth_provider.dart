import 'package:firebase_auth/firebase_auth.dart' show User, FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/floating_snackbar.dart';

class NewsAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final getStorageInstance = GetStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _userName;
  String? get userName => _userName;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // SIGN UP
Future<bool> signUp({
  required BuildContext context,
  required String email,
  required String password,
  required String name,
}) async {
  setLoading(true);
  try {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await cred.user!.updateDisplayName(name);

    _userName = name;
    getStorageInstance.write('user_name', name);

    
    await _saveToken();

    showSnack(context, "Account created!!!");
    return true;
  } catch (e) {
    showSnack(context, e.toString());
    return false;
  } finally {
    setLoading(false);
  }
}

// SIGN IN
Future<bool> signIn({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  setLoading(true);
  try {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (cred.user?.displayName != null) {
      _userName = cred.user!.displayName!;
      getStorageInstance.write('user_name', _userName);
    }
    
    
    await _saveToken();

    return true;
  } catch (e) {
    showSnack(context, e.toString());
    return false;
  } finally {
    setLoading(false);
  }
}

Future<void> _saveToken() async {
  // Get the current user from Firebase
  final user = _auth.currentUser;
  if (user != null) {
    // Force refresh the token and retrieve it
    final token = await user.getIdToken();
    // Save it to your storage instance
    getStorageInstance.write('token', token);
  }
}
  // LOGOUT
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    getStorageInstance.erase();
    _userName = null;
    notifyListeners();
    showSnack(context, "Logged out");
  }
}
