import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_view_model.dart';
import '../home/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                onSaved: (v) => email = v!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                onSaved: (v) => password = v!,
              ),
              const SizedBox(height: 20),

              if (auth.errorMessage != null)
                Text(auth.errorMessage!, style: const TextStyle(color: Colors.red)),

              ElevatedButton(
                onPressed: () async {
                  formKey.currentState!.save();
                  await auth.login(email, password);

                  if (auth.token != null && mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  }
                },
                child: const Text("LOGIN"),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                child: const Text("Belum punya akun? Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
