import 'package:examen_psp_pmdm_marcosgarcia/Personalizados/CustomTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Personalizados/CustomButton.dart';

class RegisterView extends StatelessWidget {
  late BuildContext _context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  SnackBar snackbar =
      SnackBar(content: Text("¡Vaya! Las contraseñas no son iguales..."));

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed("/loginview");
  }

  void onClickAceptar() async {
    if (passwordController.text == repasswordController.text)
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        Navigator.of(_context).popAndPushNamed('/homeview');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    else {
      ScaffoldMessenger.of(_context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text("Bienvenido a Registro Examen", style: TextStyle(fontSize: 25)),
        CustomTextField(
          labelText: "Escribe tu usuario",
          tecController: usernameController,
          paddingHorizontal: 500,
          paddingVertical: 14,
        ),
        CustomTextField(
          labelText: "Escribe tu contraseña",
          tecController: passwordController,
          paddingHorizontal: 500,
          paddingVertical: 14,
          isPassword: true,
        ),
        CustomTextField(
          labelText: "Repite tu contraseña",
          tecController: repasswordController,
          paddingHorizontal: 500,
          paddingVertical: 14,
          isPassword: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              labelText: 'Aceptar',
              onPressed: onClickAceptar,
              gradientColors: [Colors.deepPurpleAccent, Colors.purpleAccent],
              borderRadius: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Checkbox.width, vertical: 14),
              child: CustomButton(
                labelText: 'Cancelar',
                onPressed: onClickCancelar,
                gradientColors: [Colors.deepPurpleAccent, Colors.purpleAccent],
                borderRadius: 8.0,
              ),
            )
          ],
        )
      ],
    );

    AppBar appBar = AppBar(
      title: const Text('Registro'),
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
