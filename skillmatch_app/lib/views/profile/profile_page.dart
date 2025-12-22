import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/profile_view_model.dart';
import '../../viewmodels/auth_view_model.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final keyForm = GlobalKey<FormState>();

  String name = "";
  String location = "";
  String skill = "";

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final profile = Provider.of<ProfileViewModel>(context);

    if (auth.user == null) {
      return const LoginPage();
    }

    final user = auth.user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              Text("Email: ${user.email}"),
              const SizedBox(height: 20),

              TextFormField(
                initialValue: user.name,
                decoration: const InputDecoration(labelText: "Nama"),
                onSaved: (v) => name = v!,
              ),
              const SizedBox(height: 10),
// Lokasi sementara
              TextFormField(
                initialValue: user.location,
                decoration: const InputDecoration(labelText: "Lokasi"),
                onSaved: (v) => location = v!,
              ),
              const SizedBox(height: 10),

              TextFormField(
                initialValue: user.mainSkill,
                decoration: const InputDecoration(labelText: "Skill Utama"),
                onSaved: (v) => skill = v!,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  keyForm.currentState!.save();

                  await profile.update(name, location, skill);
                },
                child: const Text("UPDATE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
