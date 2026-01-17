import 'package:expenses_tracker/helper/uihelper.dart';
import 'package:expenses_tracker/pages/app_route.dart';
import 'package:expenses_tracker/pages/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? email, password;

  login(ctx) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.pushNamed(context, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("user not found for that email"),
            backgroundColor: Colors.black,
          ),
        );
      }
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

  final emalfocus = FocusNode();

  final passwordfocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emalfocus.dispose();
    passwordfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Flutter123"),
                accountEmail: Text("flutter123@gmail.com"),
                currentAccountPictureSize: Size(20, 20),
                currentAccountPicture: CircleAvatar(
                  child: Text("h"),
                  backgroundColor: Colors.orange,
                ),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     padding: EdgeInsets.zero,
              //     itemBuilder: (context, int i) {
              //       return ListTile(
              //         leading: IconButton(
              //           onPressed: () {},
              //           icon: mypages[i]["icons"],
              //         ),
              //         title: Text(mypages[i]["name"]),
              //       );
              //     },
              //     itemCount: mypages.length,
              //   ),
              // ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout from your account"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    " you logout from your account sucessfuly",
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushNamed(context, AppRoutes.home);
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("this is sign in screen "),
          centerTitle: true,
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Uihelper.CutomTextFiled(
                  controller: emailController,
                  text: "email",
                  preffixicon: Icon(Icons.mail),
                  focusnode: emalfocus,
                  textinputtype: TextInputType.text,
                  validater: _validateEmail,
                ),
                SizedBox(height: 15),
                Uihelper.CutomTextFiled(
                  controller: passwordController,
                  text: "Password",
                  suffixicon: Icon(Icons.remove_red_eye),
                  focusnode: passwordfocus,
                  textinputtype: TextInputType.visiblePassword,
                  validater: _validatePassword,
                ),
                SizedBox(height: 20),
                // Uihelper.CustomImage(img: ""),
                Uihelper.CustomTextButton(
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      email = emailController.text;
                      password = passwordController.text;
                      login(context);
                    }
                  },
                  text: "login",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don,t have a account"),
                    Uihelper.TextButtonForm(
                      callback: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.home,
                        ); // navigate to next screen through route name
                      },
                      text: "Sign Up",
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
