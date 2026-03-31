import 'package:flutter/material.dart';
import '../new_category.dart';
import 'sign_up.dart';

// This class stores the user info globally during the app session.
class UserStore {
  static String savedEmail = "";
  static String savedPassword = ""; 
}

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void tryLogin() async {
    String inputEmail = emailController.text.trim().toLowerCase();
    String inputPass = passwordController.text.trim();

    // 1. Check if an account has been created yet
    if (UserStore.savedEmail.isEmpty || UserStore.savedPassword.isEmpty) {
      showError("No account found. Please Register first!");
      return;
    }

    if (inputEmail.isEmpty || inputPass.isEmpty) {
      showError("Please fill in both fields");
      return;
    }

    setState(() => _isLoading = true);

    // Simulate a quick network check delay
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() => _isLoading = false);

    // 2. Check against the UserStore values set during Registration
    if (inputEmail == UserStore.savedEmail && inputPass == UserStore.savedPassword) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NewsCategoryScreen()),
      );
    } else {
      showError("Incorrect email or password. Please try again.");
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg), 
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header with Gradient
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrange.shade900,
                    Colors.deepOrange.shade400,
                  ],
                ),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100)),
              ),
              child: Center(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/work.png', height: 120, width: 120),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _buildInput(
                    label: "Email",
                    icon: Icons.email_outlined,
                    ctrl: emailController,
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildPassInput(ctrl: passwordController),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xFFFF4500), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(colors: [Color(0xFFFF5722), Color(0xFFFF1100)]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : tryLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: _isLoading 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account? ", style: TextStyle(color: Colors.grey)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          "Register", 
                          style: TextStyle(color: Color(0xFFFF4500), fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildInput({required String label, required IconData icon, required TextEditingController ctrl, TextInputType? type}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildPassInput({required TextEditingController ctrl}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: TextField(
        controller: ctrl,
        obscureText: _isPasswordHidden,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.deepOrange),
          suffixIcon: IconButton(
            icon: Icon(_isPasswordHidden ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
            onPressed: () => setState(() => _isPasswordHidden = !_isPasswordHidden),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }
}