import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_psp_pmdm_marcosgarcia/Personalizados/CustomButton.dart';
import 'package:examen_psp_pmdm_marcosgarcia/Personalizados/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed("/registerview");
  }

  void onClickAceptarLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text, password: tecPassword.text);
      Navigator.of(_context).popAndPushNamed("/homeview");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text("Bienvenido a Login Examen", style: TextStyle(fontSize: 25)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
          child: Flexible(
            child: SizedBox(
                width: 500,
                child: CustomTextField(
                  tecController: tecUsername,
                  labelText: "Escriba su usuario",
                )),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
          child: Flexible(
            child: SizedBox(
                width: 500,
                child: CustomTextField(
                  tecController: tecPassword,
                  labelText: "Escriba su contraseña",
                  isPassword: true,
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              labelText: 'Aceptar',
              onPressed: onClickAceptarLogin,
              gradientColors: [Colors.deepPurpleAccent, Colors.purpleAccent],
              borderRadius: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Checkbox.width, vertical: 14),
              child: CustomButton(
                labelText: 'Registrar',
                onPressed: onClickRegistrar,
                gradientColors: [Colors.deepPurpleAccent, Colors.purpleAccent],
                borderRadius: 8.0,
              ),
            ),
          ],
        )
      ],
    );

    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.indigo,
      appBar: appBar,
    );
    return scaf;
  }
}
