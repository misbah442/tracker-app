import 'package:expenses_tracker/pages/app_route.dart';
import 'package:expenses_tracker/pages/signin_screen.dart';
import 'package:expenses_tracker/pages/signup_screen.dart';
import 'package:expenses_tracker/provider/theme_provider.dart';
import 'package:expenses_tracker/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<ThemeProvider>().getValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signin,
      routes: {
        AppRoutes.signin: (context) => SigninScreen(),
        AppRoutes.signup: (context) => SignupScreen(),
        AppRoutes.home: (context) => HomeScreen(),
      },
      title: "Expenses Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: Color(0xFF00B2E7),
          secondary: Color(0xFFE064F7),
          tertiary: Color(0xFFFF8D6C),
          outline: Colors.grey.shade400,
        ),
        useMaterial3: true,
      ),
      // home: SignupScreen(),
    );
  }
}
