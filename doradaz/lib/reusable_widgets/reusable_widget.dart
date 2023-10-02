import 'package:flutter/material.dart';

Widget logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.yellow,
  );
}

Widget reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: isPasswordType,
    autocorrect: isPasswordType,
    cursorColor: Colors.yellow, // Cambia el color a amarillo
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.yellow, // Cambia el color a amarillo
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.yellow.withOpacity(0.9)), // Cambia el color a amarillo
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide:
            BorderSide(color: Colors.yellow), // Cambia el color a amarillo
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap, bool isLoading) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: isLoading
          ? null // Deshabilita el botón cuando isLoading es true
          : () {
              onTap();
            },
      child: isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text(
              isLogin ? 'LOG IN' : 'SIGN UP',
              style: const TextStyle(
                color: Colors.black87, // Cambia el color a amarillo
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white; // Cambia el color a blanco
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    ),
  );
}
