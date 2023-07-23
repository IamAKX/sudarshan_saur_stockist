import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/screens/password_recovery/recover_password_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/register_screen.dart';
import 'package:saur_stockist/utils/colors.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/gaps.dart';
import 'package:saur_stockist/widgets/input_field_dark.dart';
import 'package:saur_stockist/widgets/input_password_field_dark.dart';
import 'package:saur_stockist/widgets/primary_button.dart';

import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';
import '../home_container/home_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routePath = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  late ApiProvider _api;
  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blueGradientDark,
            blueGradientLight,
          ],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical: defaultPadding,
              ),
              children: [
                verticalGap(defaultPadding * 1.5),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                verticalGap(defaultPadding),
                Text(
                  'Welcome\nBack 👋🏻',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                verticalGap(defaultPadding * 1.5),
                InputFieldDark(
                  hint: 'Email',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  obscure: false,
                  icon: LineAwesomeIcons.at,
                ),
                verticalGap(defaultPadding),
                InputPasswordFieldDark(
                  hint: 'Password',
                  controller: _passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  icon: LineAwesomeIcons.user_lock,
                ),
                verticalGap(defaultPadding * 2),
                PrimaryButton(
                  onPressed: () {
                    if (_emailCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
                      SnackBarService.instance.showSnackBarError(
                          'Email or Password cannot be empty');
                      return;
                    }
                    _api
                        .login(
                      _emailCtrl.text,
                      base64.encode(_passwordCtrl.text.codeUnits),
                    )
                        .then((value) {
                      if (value) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeContainer.routePath,
                          (route) => false,
                        );
                      }
                    });
                  },
                  label: 'Login',
                  isDisabled: _api.status == ApiStatus.loading,
                  isLoading: _api.status == ApiStatus.loading,
                ),
                verticalGap(defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routePath);
                      },
                      child: Text(
                        'Register',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      color: Colors.white,
                      width: 2,
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                            context, RecoverPasswordScreen.routePath);
                      },
                      child: Text(
                        'Password',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/logo.png',
                    width: 150,
                  ),
                  Text(
                    'Stockist',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
