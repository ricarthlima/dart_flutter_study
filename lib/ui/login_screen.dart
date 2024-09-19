import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Placeholder(
                    child: SizedBox(
                        height: 200,
                        child: Center(child: Text("Logo Banco D'Ouro"))),
                  ),
                  Text(
                    "SISTEMA DE GESTÃO DE CONTAS",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text("E-mail")),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Senha")),
                    obscureText: true,
                  ),
                  const SizedBox(height: 36),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "home");
                    },
                    child: const Text("Entrar"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
