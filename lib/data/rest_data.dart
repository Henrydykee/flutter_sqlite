import 'package:flutter/cupertino.dart';
import 'package:flutter_sqlite/models/user.dart';
import 'package:flutter_sqlite/utils/network_util.dart';

class RestData{
  NetworkUtil _netUtil = NetworkUtil();
  static final BASE_URL = "";
  static final LOGIn_URL = BASE_URL + "/";

  Future<User>login(String username, String password){
    return  Future.value(User(username , password));
  }
}