import 'package:expenses_tracker/database/databasemethod.dart';
import 'package:expenses_tracker/helper/uihelper.dart';
import 'package:expenses_tracker/pages/app_route.dart';
import 'package:expenses_tracker/pages/signin_screen.dart';
import 'package:expenses_tracker/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  String? name, email, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final namefocus = FocusNode();
  final emalfocus = FocusNode();
  final passwordfocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    namefocus.dispose();
    emalfocus.dispose();
    passwordfocus.dispose();
  }

  SignUp(ctx) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Register successfuly"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(ctx, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text("wrong password"),
            backgroundColor: Colors.green,
          ),
        );
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(
              "email already exits",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
        );
      } else {
        print("e$e errro");
      }
    }

    String id = randomAlphaNumeric(10);

    Map<String, dynamic> userinfoMap = {
      "Name": nameController.text,
      "Email": emailController.text,
      "Id": id,
    };
    Databasemethod().adduserDetail(
      userinfoMap,
      id,
    ); // to store the user data in firestoredatabase
  }

  String? _validatename(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter name";
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter email";
    } else if (!value.contains("@")) {
      return "Please Enter the valid email";
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter the password";
    } else if (value.length < 8) {
      return "password must be 8 character";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(title: Text("sign up screen"), centerTitle: true),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Uihelper.CutomTextFiled(
                  controller: nameController,
                  text: "Enter Name",
                  focusnode: namefocus,
                  preffixicon: Icon(Icons.person),
                  textinputtype: TextInputType.text,
                  validater: _validatename,
                ),
                SizedBox(height: 20),
                Uihelper.CutomTextFiled(
                  controller: emailController,
                  text: "Enter Email",
                  preffixicon: Icon(Icons.mail),
                  focusnode: emalfocus,
                  textinputtype: TextInputType.emailAddress,
                  validater: _validateEmail,
                ),
                SizedBox(height: 20),
                Uihelper.CutomTextFiled(
                  controller: passwordController,
                  text: "Enter Password",
                  focusnode: passwordfocus,
                  suffixicon: Icon(Icons.remove_red_eye, color: Colors.black),
                  textinputtype: TextInputType.visiblePassword,
                  validater: _validatePassword,
                ),
                SizedBox(height: 20),
                Uihelper.CustomTextButton(
                  text: "Sign UP",
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      name = nameController.text;
                      email = emailController.text;
                      password = passwordController.text;
                      SignUp(context); // call the function here
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already in account"),
                    Uihelper.TextButtonForm(
                      callback: () {
                        Navigator.pushNamed(context, AppRoutes.signin);
                      },
                      text: "Login",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
