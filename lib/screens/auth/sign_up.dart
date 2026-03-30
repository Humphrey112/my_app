import 'package:flutter/material.dart';
import 'package:my_app/services/auth_service.dart';

import 'loginscreen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  // 1. ALL CONTROLLERS INITIALIZED
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _auth = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 280,
            left: 20,
            right: 20,
            child: Opacity(
              opacity: 0.04,
              child: Image.asset(
                'assets/work.png', // Verified in pubspec.yaml
                height: 400,
                color: Colors.black,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Image.asset(
                    'assets/work.png',
                    height: 120,
                    width: 120,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      // 2. PASSING CONTROLLERS CORRECTLY
                      _buildSignUpField(
                        "Email",
                        Icons.email_outlined,
                        _emailController,
                      ),
                      const SizedBox(height: 15),
                      _buildSignUpField(
                        "Username",
                        Icons.person_outline,
                        _usernameController,
                      ),
                      const SizedBox(height: 15),
                      _buildPasswordField(
                        hint: "Password",
                        controller: _passwordController,
                        isHidden: _isPasswordHidden,
                        onToggle: () => setState(
                          () => _isPasswordHidden = !_isPasswordHidden,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildPasswordField(
                        hint: "Confirm Password",
                        controller: _confirmPasswordController,
                        isHidden: _isConfirmPasswordHidden,
                        onToggle: () => setState(
                          () => _isConfirmPasswordHidden =
                              !_isConfirmPasswordHidden,
                        ),
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            _auth.signUp(
                              _emailController.text,
                              _passwordController.text,
                            );
                            // 3. VALIDATION LOGIC
                            if (_emailController.text.isEmpty ||
                                _usernameController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('All fields are required!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Account Created Successfully!',
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              Navigator.pop(context, const Loginscreen());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF4500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an Account? ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color(0xFFFF4500),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. HELPER WIDGETS UPDATED TO REQUIRE CONTROLLERS
  Widget _buildPasswordField({
    required String hint,
    required bool isHidden,
    required VoidCallback onToggle,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller, // Linked controller to avoid 'undefined' error
        obscureText: isHidden,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.red),
          suffixIcon: IconButton(
            icon: Icon(
              isHidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpField(
    String hint,
    IconData icon,
    TextEditingController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller, // Linked controller to avoid 'undefined' error
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.red),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
