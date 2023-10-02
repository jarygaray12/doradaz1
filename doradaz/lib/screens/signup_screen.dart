import 'package:flutter/material.dart';
import 'package:doradaz/paginas/home.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool _isLoading = false;

  void _handleSignUp() {
    // Realiza la lógica de registro aquí

    // Simula una carga por 2 segundos (puedes reemplazarlo con tu lógica real)
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      // Después de la carga, navega a la página deseada
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              yellowColor,
              redColor,
              whiteColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_2_outlined,
                    false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_2_outlined,
                    false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(yellowColor),
                        )
                      : Text(
                          "Sign Up",
                          style: TextStyle(color: whiteColor),
                        ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return redColor;
                      }
                      return yellowColor;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
