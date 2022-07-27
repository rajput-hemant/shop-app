import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const PositionedImage(
            left: 30,
            width: 80,
            height: 200,
            imageURL: 'assets/images/light-1.png',
          ),
          const PositionedImage(
            left: 140,
            width: 80,
            height: 150,
            imageURL: 'assets/images/light-2.png',
          ),
          const PositionedImage(
            right: 25,
            width: 80,
            height: 150,
            imageURL: 'assets/images/clock.png',
          ),
          Positioned(
            top: 225,
            left: deviceSize.width * 0.25,
            child: const Text(
              "Shop App",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height + deviceSize.height / 2,
              width: deviceSize.width,
              child: const AuthCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    if (_authMode == AuthMode.login) {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } else {
      // Sign user up
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['email'],
        _authData['password'],
      );
    }
    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() => _authMode = AuthMode.signup);
    } else {
      setState(() => _authMode = AuthMode.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 20.0,
              offset: Offset(0, 10),
              color: Color.fromRGBO(143, 148, 251, .2),
            )
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldBuilder(
                hintText: 'E-Mail',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                  return null;
                },
              ),
              const Divider(),
              TextFieldBuilder(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                  return null;
                },
              ),
              if (_authMode == AuthMode.signup) ...[
                const Divider(),
                TextFieldBuilder(
                  enabled: _authMode == AuthMode.signup,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: _authMode == AuthMode.signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                          return null;
                        }
                      : null,
                ),
              ]
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      if (_isLoading)
        const CircularProgressIndicator()
      else
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromARGB(197, 143, 148, 251),
            ]),
          ),
          child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              fixedSize: Size(deviceSize.width * 0.85, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
          ),
        ),
      const SizedBox(
        height: 25,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _authMode == AuthMode.login
                ? "Don't have an account?"
                : "Already have an account?",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: _switchAuthMode,
            child: Text(
              _authMode == AuthMode.login ? 'Sign Up' : 'Login',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}

class PositionedImage extends StatelessWidget {
  final double? top, bottom, left, right, width, height;
  final String imageURL;

  const PositionedImage({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageURL),
          ),
        ),
      ),
    );
  }
}

class TextFieldBuilder extends StatelessWidget {
  final bool? enabled;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator, onSaved;

  const TextFieldBuilder({
    Key? key,
    this.enabled,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      onSaved: onSaved,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
