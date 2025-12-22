import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/auth_repository.dart';
import 'repositories/user_repository.dart';
import 'viewmodels/auth_view_model.dart';
import 'viewmodels/profile_view_model.dart';
import 'views/auth/login_page.dart';

void main() {
  runApp(const SkillMatchApp());
}

class SkillMatchApp extends StatelessWidget {
  const SkillMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(AuthRepository()),
        ),

        ChangeNotifierProxyProvider<AuthViewModel, ProfileViewModel>(
          create: (context) =>
              ProfileViewModel(UserRepository(), Provider.of<AuthViewModel>(context, listen: false)),
          update: (_, authVM, previous) =>
              ProfileViewModel(UserRepository(), authVM),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SkillMatch",
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const LoginPage(),
      ),
    );
  }
}
