import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userID;

  static const _apikey = "AIzaSyBb6uj1OzNcrP83BBYIPjSjcIf23etn3DE";

  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_apikey");
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    log(response.body);
  }

  Future<void> signUp(String? email, String? password) {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String? email, String? password) {
    return _authenticate(email, password, "signInWithPassword");
  }
}
