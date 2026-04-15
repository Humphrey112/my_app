import 'package:flutter/material.dart';
import 'package:my_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'loginscreen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPassHidden = true;
  bool _isConfirmHidden = true;
  bool _isLoading = false;

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    nameCtrl.dispose();
    passwordCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  void _showMsg(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = emailCtrl.text.trim();
    final username = nameCtrl.text.trim();
    final password = passwordCtrl.text.trim();
    final confirmPassword = confirmPassCtrl.text.trim();

    // Updated Registration Logic
    void validateUser() async {
      // validation
      if (email.isEmpty ||
          username.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All fields are required!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Watermark
          Positioned(
            top: 280,
            left: 20,
            right: 20,
            child: Opacity(
              opacity: 0.04,
              child: Image.asset(
                'assets/work.png',
                height: 400,
                color: Colors.black,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                // Hero Logo
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/work.png',
                      height: 110,
                      width: 110,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      _buildField(
                        "Email Address",
                        Icons.email_outlined,
                        emailCtrl,
                        TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      _buildField(
                        "Full Name",
                        Icons.person_outline,
                        nameCtrl,
                        TextInputType.name,
                      ),
                      const SizedBox(height: 15),
                      _buildPassField(
                        "Password",
                        _isPassHidden,
                        passwordCtrl,
                        () {
                          setState(() => _isPassHidden = !_isPassHidden);
                        },
                      ),
                      const SizedBox(height: 15),
                      _buildPassField(
                        "Confirm Password",
                        _isConfirmHidden,
                        confirmPassCtrl,
                        () {
                          setState(() => _isConfirmHidden = !_isConfirmHidden);
                        },
                      ),
                      const SizedBox(height: 40),

                      // Submit Button with Loading State
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: Consumer<NewsAuthProvider>(
                          builder: (context, auth, child) {
                            return auth.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      validateUser();

                                      final success = await auth.signUp(
                                        context: context,
                                        email: emailCtrl.text.trim(),
                                        password: passwordCtrl.text.trim(),
                                        name: nameCtrl.text.trim(),
                                      );

                                      if (success) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const Loginscreen(),
                                          ),
                                        );
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
                                  );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
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
                      const SizedBox(height: 30),
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

  // UI Helpers
  Widget _buildField(
    String hint,
    IconData icon,
    TextEditingController ctrl,
    TextInputType type,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildPassField(
    String hint,
    bool isHidden,
    TextEditingController ctrl,
    VoidCallback toggle,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: ctrl,
        obscureText: isHidden,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.deepOrange),
          suffixIcon: IconButton(
            icon: Icon(
              isHidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: toggle,
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
}
