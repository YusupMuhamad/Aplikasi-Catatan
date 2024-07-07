import 'package:flutter_note/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = Rx<UserModel>(UserModel(id: '', email: ''));

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel(id: '', email: '');
  }
}