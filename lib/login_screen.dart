import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/firebase_auth_service.dart';
import 'package:weather_test_app/user_model.dart';
import 'package:weather_test_app/weather_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _controllerLogin, _controllerPassword;
  bool isPasswordHidden = true;

  @override
  void initState() {

    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Вход',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF2B2D33),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Введите данные для входа',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF8799A5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: TextField(
                  controller: _controllerLogin,
                  style: const TextStyle(
                    color: Color(0xFF2B2D33),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xFFE4E6EC), width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xFF0700FF), width: 2),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Color(0xFF8799A5),
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: _controllerPassword,
                  style: const TextStyle(
                    color: Color(0xFF2B2D33),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xFFE4E6EC), width: 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xFF0700FF), width: 2),
                    ),
                    hintText: 'Пароль',
                    hintStyle: const TextStyle(
                      color: Color(0xFF8799A5),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      icon: SvgPicture.asset(
                        isPasswordHidden
                            ? 'assets/svg/eye.svg'
                            : 'assets/svg/eye-off.svg',
                        color: const Color(0xFF0700FF),
                      ),
                    ),
                  ),
                  obscureText: isPasswordHidden,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF0700FF),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: TextButton(
                  onPressed: () async {

                    UserModel userModel = await FirebaseAuthService().signIn(
                        email: _controllerLogin.text,
                        password: _controllerPassword.text
                    );
                    if (userModel.error.isEmpty) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => WeatherScreen()));
                    }
                  },
                  child: const Text(
                    'Войти',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: SystemUiOverlayStyle.dark,
    //   child:
    //
    // );
  }
}
