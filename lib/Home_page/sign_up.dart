import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. SHADED BACKGROUND WATERMARK (Placed behind the input fields)
          Positioned(
            top: 280,
            left: 20,
            right: 20,
            child: Opacity(
              opacity: 0.04, // Subtle shaded look
              child: Image.asset(
                'assets/work.png',
                height: 400,
                color: Colors.black, // The "Shaded Black" effect
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),

          // 2. MAIN CONTENT
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Main Top Logo (Deep Orange)
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
                      _buildSignUpField("Email", Icons.email_outlined),
                      const SizedBox(height: 15),

                      _buildSignUpField("Username", Icons.person_outline),
                      const SizedBox(height: 15),

                      _buildPasswordField(
                        hint: "Password",
                        isHidden: _isPasswordHidden,
                        onToggle: () =>
                            setState(() => _isPasswordHidden = !_isPasswordHidden),
                      ),
                      const SizedBox(height: 15),

                      _buildPasswordField(
                        hint: "Confirm Password",
                        isHidden: _isConfirmPasswordHidden,
                        onToggle: () => setState(() =>
                            _isConfirmPasswordHidden = !_isConfirmPasswordHidden),
                      ),

                      const SizedBox(height: 40),

                      // SignUp Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {},
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
                          const Text("Already have an Account? ",
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

  // Password field builder with toggle logic
  Widget _buildPasswordField(
      {required String hint,
      required bool isHidden,
      required VoidCallback onToggle}) {
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
        obscureText: isHidden,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.red),
          suffixIcon: IconButton(
            icon: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey),
            onPressed: onToggle,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }

  // General input field builder
  Widget _buildSignUpField(String hint, IconData icon) {
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
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.red),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }
}