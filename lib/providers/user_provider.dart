import 'package:evently_c19/core/remote/network/firestore_manager.dart';
import 'package:evently_c19/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  User? user;

  fetchUser() async{
    user = await FirestoreManager.getUser();
    notifyListeners();
  }
}