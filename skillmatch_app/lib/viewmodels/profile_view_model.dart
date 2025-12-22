import 'package:flutter/material.dart';

import '../repositories/user_repository.dart';
import 'auth_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository _repo;
  final AuthViewModel _auth;

  ProfileViewModel(this._repo, this._auth);

  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchProfile() async {
    if (_auth.token == null) return;

    isLoading = true;
    notifyListeners();

    try {
      final user = await _repo.getMe(_auth.token!);
      _auth.user = user;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> update(String name, String loc, String skill) async {
    if (_auth.token == null) return;
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final updated = await _repo.updateProfile(_auth.token!, name, loc, skill);
      _auth.user = updated;
    } catch (e) {
      errorMessage = e.toString();
    }finally {

    isLoading = false;
    notifyListeners();
    }
  }
}
