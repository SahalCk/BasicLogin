import 'package:flutter/material.dart';
import 'package:loginproject/screenHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuixDXg1nclcBxhYiLbPkn6JnXt032qOk7LhtW8SI-3aLKFCGccIEeYQUMeTThwvbryxg4qW9CkCk&usqp=CAU&ec=48665698'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Login to ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "BookMyShow!",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 350,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _usernamecontroller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("User Name")),
                        validator: (_) {
                          if (_usernamecontroller.text.isEmpty) {
                            return 'User name field is Empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordcontroller,
                        obscureText: obscure,
                        decoration: InputDecoration(
                            suffixIcon: obscure == true
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure = false;
                                      });
                                    },
                                    icon: Icon(Icons.lock_open_outlined))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure = true;
                                      });
                                    },
                                    icon: Icon(Icons.lock_outline)),
                            border: OutlineInputBorder(),
                            label: Text("Password")),
                        validator: (value) {
                          if (_passwordcontroller.text.isEmpty) {
                            return 'Password field is Empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              validatelogin();
                            }
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: 17),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              fixedSize: Size(90, 40)))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validatelogin() {
    if (_usernamecontroller.text == _passwordcontroller.text) {
      setkey();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const ScreenHome();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username and Password does not match!"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ));
    }
  }

  Future<void> setkey() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLoggedin', true);
  }
}
