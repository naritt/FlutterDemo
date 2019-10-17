
import 'package:flutter_app/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  static final String IS_LOGIN = "is_login";
  static final String USERNAME = "username";

  Future<bool> isLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(IS_LOGIN) ?? false;
  }

  Future<bool> login({UserModel userModel}) async{
    if(userModel.username == "admin@gmail.com" && userModel.password == "password"){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(USERNAME, userModel.username);
      prefs.setBool(IS_LOGIN, true);

      return true;
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(IS_LOGIN);

    return await Future<void>.delayed(Duration(seconds: 1));
  }
}