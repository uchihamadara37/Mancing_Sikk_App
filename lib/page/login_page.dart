import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mancing_app/page/menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Warna latar belakang
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/contour.png",
          ),
          fit: BoxFit.cover, // Fitting gambar sesuai container
        )),
        child: Center(
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(20), // Membatasi efek blur hanya di dalam
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur efek kaca
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 355,
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    )),
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
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Border default
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(0xFF0F882D).withValues(alpha: 0.2),
                                width: 2), // Warna border normal
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(0xFF0F882D),
                                width: 2), // Warna border saat fokus
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 2), // Warna border saat error
                          ),
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xFF0F882D)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(0xFF0F882D).withValues(alpha: 0.2),
                                width: 2), // Warna border normal
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Color(0xFF0F882D),
                                width: 2), // Warna border saat fokus
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: 2), // Warna border saat error
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF0F882D),
                          ),
                          suffixIcon: Icon(Icons
                              .visibility_off), // Ikon untuk toggle password
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Aksi login di sini
                            print("Login ditekan");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPage()),
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0F882D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      // SizedBox(height: 10),
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
  }
}
