import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_test_app/domain/services/firebase_auth_service.dart';
import 'package:weather_test_app/presentation/components/input_field_widget.dart';
import 'package:weather_test_app/user_model.dart';
import 'package:weather_test_app/presentation/screens/weather_screen.dart';

final getIt = GetIt.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _controllerLogin, _controllerPassword;
  bool isPasswordHidden = true;
  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    _controllerLogin = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  Future<void> _navigateToWeatherScreen()async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WeatherScreen(),
      ),
    );
  }

  Future<void> _onLogin()async {
    setState(() {
      error = '';
      isLoading = true;
    });
    AuthService authService = FirebaseAuthService();
    UserModel userModel = await authService.signIn(
      email: _controllerLogin.text,
      password: _controllerPassword.text,
    );
    if (userModel.error.isEmpty) {
      await _navigateToWeatherScreen();
    } else {
      setState(() {
        error = userModel.error;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
                    shrinkWrap: true,
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
                        child: InputFieldWidget(
                          controller: _controllerLogin,
                          isPasswordHidden: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InputFieldWidget(
                          controller: _controllerPassword,
                          isPasswordHidden: isPasswordHidden,
                          iconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },
                            icon: SvgPicture.asset(
                              isPasswordHidden
                                  ? 'assets/svg/eye.svg'
                                  : 'assets/svg/eye-off.svg',
                            ),
                          ),
                        ),
                      ),
                      isLoading ?
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Color(0xFF0700FF),
                        ),
                      ) :
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0700FF),
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: TextButton(
                          onPressed: _onLogin,
                          child: const Text(
                            'Войти',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      if (!isLoading)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              await _navigateToWeatherScreen();
                            },
                            child: const Text(
                              'Пропустить',
                              style: TextStyle(
                                color: Color(0xFF0700FF),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF0700FF),
                              ),
                            ),
                          ),
                        ),
                      if (error.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(
                            error,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
