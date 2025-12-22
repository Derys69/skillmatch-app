import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:skillmatch_app/views/home/home_page.dart';
import 'package:skillmatch_app/viewmodels/auth_view_model.dart';
import 'package:skillmatch_app/viewmodels/profile_view_model.dart';
import 'package:skillmatch_app/repositories/auth_repository.dart';
import 'package:skillmatch_app/repositories/user_repository.dart';
import 'package:skillmatch_app/models/user.dart';

void main() {
  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    // ===== ARRANGE =====
    final authVm = AuthViewModel(AuthRepository());
    authVm.user = User(
      id: 1,
      name: 'Test User',
      email: 'test@mail.com',
      location: 'Jakarta',
      mainSkill: 'Flutter',
    );
    authVm.token = 'dummy-token';

    final profileVm = ProfileViewModel(UserRepository(), authVm);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthViewModel>.value(value: authVm),
          ChangeNotifierProvider<ProfileViewModel>.value(value: profileVm),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // ===== ACT =====
    await tester.pumpAndSettle();

    // ===== ASSERT =====
    expect(find.textContaining('Welcome back'), findsOneWidget);
    expect(find.textContaining('Test User'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
