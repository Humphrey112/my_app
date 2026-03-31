import 'package:flutter/material.dart';
import 'loginscreen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPassHidden = true;
  bool _isConfirmHidden = true;
  bool _isLoading = false; // Added for a better user experience

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    userCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  // Updated Registration Logic
  void registerUser() async {
    String email = emailCtrl.text.trim().toLowerCase(); // Convert to lowercase
    String username = userCtrl.text.trim();
    String pass = passCtrl.text.trim();
    String confirmPass = confirmPassCtrl.text.trim();

    // 1. Check if fields are empty
    if (email.isEmpty || pass.isEmpty || username.isEmpty) {
      _showMsg('Please fill all fields', Colors.red);
      return;
    }

    // 2. Check password match
    if (pass != confirmPass) {
      _showMsg('Passwords do not match!', Colors.red);
      return;
    }

    // 3. Simple email format check
    if (!email.contains('@')) {
      _showMsg('Please enter a valid email', Colors.red);
      return;
    }

    setState(() => _isLoading = true);

    // Simulate a small delay for account creation
    await Future.delayed(const Duration(seconds: 2));

    // SAVE DATA TO THE GLOBAL STORE (Visible to Login Screen)
    UserStore.savedEmail = email;
    UserStore.savedPassword = pass;

    if (!mounted) return;
    
    _showMsg('Account Created Successfully!', Colors.green);

    // Go back to login screen
    Navigator.pop(context);
  }

  void _showMsg(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color, duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset('assets/work.png', height: 400, color: Colors.black,),
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
                    child: Image.asset('assets/work.png', height: 110, width: 110, color: Colors.orange,),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      _buildField("Email Address", Icons.email_outlined, emailCtrl, TextInputType.emailAddress),
                      const SizedBox(height: 15),
                      _buildField("Full Name", Icons.person_outline, userCtrl, TextInputType.name),
                      const SizedBox(height: 15),
                      _buildPassField("Password", _isPassHidden, passCtrl, () {
                        setState(() => _isPassHidden = !_isPassHidden);
                      }),
                      const SizedBox(height: 15),
                      _buildPassField("Confirm Password", _isConfirmHidden, confirmPassCtrl, () {
                        setState(() => _isConfirmHidden = !_isConfirmHidden);
                      }),
                      const SizedBox(height: 40),
                      
                      // Submit Button with Loading State
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF4500),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            elevation: 5,
                          ),
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                              style: TextStyle(color: Color(0xFFFF4500), fontWeight: FontWeight.bold),
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
  Widget _buildField(String hint, IconData icon, TextEditingController ctrl, TextInputType type) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.deepOrange),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildPassField(String hint, bool isHidden, TextEditingController ctrl, VoidCallback toggle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: TextField(
        controller: ctrl,
        obscureText: isHidden,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.deepOrange),
          suffixIcon: IconButton(
            icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
            onPressed: toggle,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }
}