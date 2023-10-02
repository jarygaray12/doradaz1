import 'package:flutter/material.dart';
import 'package:doradaz/reusable_widgets/reusable_widget.dart';
import 'package:doradaz/paginas/home.dart';
import 'package:doradaz/screens/signup_screen.dart';
import 'package:doradaz/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool _isLoading = false;

  void _handleSignIn() {
    // Aquí puedes agregar la lógica de autenticación personalizada
    // en lugar de la llamada a Firebase.
    // Por ejemplo, puedes realizar una verificación en tu propio servidor.

    // Simula una carga por 2 segundos (puedes reemplazarlo con tu lógica real)
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      // Después de la autenticación exitosa, puedes navegar a la página deseada.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white, // Blanco arriba
              Color.fromARGB(255, 255, 38,
                  0), // Azul abajo (puedes cambiarlo a tu color preferido)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0, // Cambiado para que el blanco quede arriba
              20,
              20, // Cambiado para que el color abajo
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/img/logo.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_2_outlined,
                  false,
                  _emailTextController,
                ),
                SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignIn,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white, // Texto en blanco
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black26;
                      }
                      return Colors.blue; // Color azul
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
