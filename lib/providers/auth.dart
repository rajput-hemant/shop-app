import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token, _userID;
  DateTime? _expiryDate;
  Timer? _authTimer;

  static const _apikey = "AIzaSyBb6uj1OzNcrP83BBYIPjSjcIf23etn3DE";

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate!.isAfter(DateTime.now())) return _token;
    return null;
  }

  String? get userID => _userID;

  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    try {
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
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userID = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(responseData['expiresIn'])),
      );
      _autoLogOut();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String? email, String? password) {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String? email, String? password) {
    return _authenticate(email, password, "signInWithPassword");
  }

  void logOut() {
    _token = null;
    _userID = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void _autoLogOut() {
    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logOut);
  }
}
