import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mancing_app/page/menu_page.dart';
import 'package:mancing_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    var authProvider =
        Provider.of<AuthProviderFirebase>(context, listen: false);
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Email dan password tidak boleh kosong."),
            backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await authProvider.submit(email, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviderFirebase>(
      builder: (context, authProvider, child) {
        if (authProvider.user != null) {
          Future.microtask(() => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              ));
        }

        return Scaffold(
          backgroundColor: Colors.blue[50],
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/contour.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 380,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Silakan masuk!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F882D),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon:
                                  Icon(Icons.email, color: Color(0xFF0F882D)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon:
                                  Icon(Icons.lock, color: Color(0xFF0F882D)),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() =>
                                      _isPasswordVisible = !_isPasswordVisible);
                                },
                              ),
                            ),
                            obscureText: !_isPasswordVisible,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0F882D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text("Login",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                print("Lupa password ditekan");
                              },
                              child: Text("Lupa Password?",
                                  style: TextStyle(color: Colors.blueAccent)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
