// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:loginproject/screenHome.dart';
import 'package:loginproject/screenLogin.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkIsLogged(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 247),
      body: SafeArea(
          child: Center(
              child: SizedBox(
                  width: 300,
                  child: Image.asset('assets/images/bookmyshow.png')))),
    );
  }

  Future<void> checkIsLogged(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final isLoggedin = sharedPreferences.getBool('isLoggedin');

    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedin!) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const ScreenHome();
      }));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const ScreenLogin();
      }));
    }
  }
}
