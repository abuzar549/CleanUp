// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:cleanup/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:cleanup/utils/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passhide = true;
  bool a = false;
  final mailController = TextEditingController();
  final passController = TextEditingController();

  void login(String email, String pass) async {
    try {
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': pass});

      if (response.statusCode == 200) {
        setState(() {
          a = true;
        });
      } else {
        setState(() {
          a = false;
          Utils().toastMessage('Incorrect Password');
        });
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 26,
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 75,
              ),
              Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 150,
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Text(
                    'Please Login before you continue',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.1),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: passhide,
                    controller: passController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passhide = !passhide;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey[400],
                            )),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      login(mailController.text.toString(),
                          passController.text.toString());

                      if (a) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    },
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        )),
      ),
    );
  }
}
