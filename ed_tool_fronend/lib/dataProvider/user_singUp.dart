import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'authModels.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserDataProvider {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final baseUrl =('http://localhost:3000/auth');
  
Future<http.Response> signUp(String email, String password, String name) async {
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    'email': email, 
    'name': name, 
    'password': password
    });
  final url = Uri.parse("$baseUrl/userSignUp");

  final response = await http.post(url, headers: headers, body: body);
  final responseBody = jsonDecode(response.body);
  persitstToken(responseBody['access_token'],responseBody['enckey']);
  return response;

}

Future<http.Response> signIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/userSignIn');
     final header = {'Content-Type': 'application/json; charset=UTF-8'};
     final body = jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      });
     final response = await http.post(url, headers: header, body: body);
     final responseBody = jsonDecode(response.body);
     persitstToken(responseBody['access_token'],responseBody['enckey']);

     return response;
  }


Future<void> persitstToken(String token, String enckey) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'enckey', value: enckey);

  }


}