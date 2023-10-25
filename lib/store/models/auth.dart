import 'dart:convert';

class UserRequest {
  late String email;
  late String pwd;
  late String name;
  late String? phone;

  UserRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    pwd = json['pwd'];
    name = json['name'];
    phone = json['phone'];
  }
}

class User {
  late String id;
  late String name;
  late String email;
  String? phone;
  late String accessToken;
  late String refreshToken;


  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  String toJson() => jsonEncode({
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "accessToken": accessToken,
      "refreshToken": refreshToken,
  });
}