import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/model/address_model.dart';
import 'package:saur_stockist/model/user_model.dart';
import 'package:saur_stockist/screens/user_onboarding/business_detail.dart';
import 'package:saur_stockist/screens/user_onboarding/login_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/otp_verification.dart';
import 'package:saur_stockist/screens/user_onboarding/user_detail.dart';
import 'package:saur_stockist/service/api_service.dart';
import 'package:saur_stockist/utils/date_time_formatter.dart';
import 'package:saur_stockist/utils/enum.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/gaps.dart';
import 'package:saur_stockist/widgets/primary_button.dart';
import 'package:string_validator/string_validator.dart';

import '../../service/snakbar_service.dart';
import '../../utils/colors.dart';
import 'address_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routePath = '/register';
  static bool agreementStatus = false;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _otpCodeCtrl = TextEditingController();
  final TextEditingController _businessNameCtrl = TextEditingController();
  final TextEditingController _businessAddressCtrl = TextEditingController();
  final TextEditingController _gstNumberCtrl = TextEditingController();
  final TextEditingController addressLine1Ctrl = TextEditingController();
  final TextEditingController addressLine2Ctrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController zipCodeCtrl = TextEditingController();
  int step = 1;

  late ApiProvider _api;
  String code = '';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalGap(defaultPadding * 1.5),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            verticalGap(defaultPadding),
            Row(
              children: [
                Text(
                  'New\nAccount 🙋🏼‍♂️',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$step',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '/4',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                    Text(
                      'STEPS',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            verticalGap(defaultPadding * 1.5),
            Expanded(child: getWidgetByStep(step)),
            verticalGap(defaultPadding * 1.5),
            Row(
              children: [
                Visibility(
                  visible: step > 1,
                  child: InkWell(
                    onTap: _api.status == ApiStatus.loading
                        ? null
                        : () {
                            setState(() {
                              step--;
                            });
                          },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: step < 4,
                  child: InkWell(
                    onTap: () {
                      if (!validateInput()) {
                        return;
                      }
                      setState(() {
                        step++;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: step == 4,
                  child: SizedBox(
                    width: 250,
                    child: PrimaryButton(
                        onPressed: () async {
                          if (code != '' && _otpCodeCtrl.text == code) {
                            step = 1;
                            UserModel user = UserModel(
                              address: AddressModel(
                                addressLine1: addressLine1Ctrl.text,
                                addressLine2: addressLine2Ctrl.text,
                                city: cityCtrl.text,
                                country: 'India',
                                state: stateCtrl.text,
                                zipCode: zipCodeCtrl.text,
                              ),
                              stockistName: _nameCtrl.text,
                              email: _emailCtrl.text,
                              password:
                                  base64.encode(_passwordCtrl.text.codeUnits),
                              lastLogin: DateTimeFormatter.now(),
                              mobileNo: _phoneCtrl.text,
                              businessAddress: _businessAddressCtrl.text,
                              businessName: _businessNameCtrl.text,
                              gstNumber: _gstNumberCtrl.text,
                              status: UserStatus.CREATED.name,
                            );

                            _api.createUser(user).then((value) {
                              if (value) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginScreen.routePath, (route) => false);
                              }
                            });
                          } else {
                            SnackBarService.instance
                                .showSnackBarError('Invalid OTP');
                          }
                        },
                        label: 'Register',
                        isDisabled: _api.status == ApiStatus.loading,
                        isLoading: _api.status == ApiStatus.loading),
                  ),
                ),
              ],
            ),
            verticalGap(defaultPadding),
          ],
        ),
      ),
    );
  }

  getWidgetByStep(int step) {
    switch (step) {
      case 1:
        return UserDetail(
            emailCtrl: _emailCtrl,
            passwordCtrl: _passwordCtrl,
            phoneCtrl: _phoneCtrl,
            nameCtrl: _nameCtrl);
      case 2:
        return AddressScreen(
          addressLine1Ctrl: addressLine1Ctrl,
          addressLine2Ctrl: addressLine2Ctrl,
          cityCtrl: cityCtrl,
          stateCtrl: stateCtrl,
          zipCodeCtrl: zipCodeCtrl,
        );
      case 3:
        return BusinessDetails(
          businessNameCtrl: _businessNameCtrl,
          businessAddressCtrl: _businessAddressCtrl,
          gstNumberCtrl: _gstNumberCtrl,
        );
      case 4:
        code = (Random().nextInt(9000) + 1000).toString();
        ApiProvider().sendOtp(_phoneCtrl.text, code.toString());
        return OtpVerification(
          phoneCtrl: _phoneCtrl,
          otpCode: code,
          otpCodeCtrl: _otpCodeCtrl,
        );
      default:
    }
  }

  bool validateInput() {
    if (step == 1) {
      if (_nameCtrl.text.isEmpty ||
          _emailCtrl.text.isEmpty ||
          _passwordCtrl.text.isEmpty ||
          _phoneCtrl.text.isEmpty) {
        SnackBarService.instance.showSnackBarError('All fields are mandatory');
        return false;
      }
      if (!isEmail(_emailCtrl.text)) {
        SnackBarService.instance.showSnackBarError('Enter valid email address');
        return false;
      }
      if (_phoneCtrl.text.length != 10 || !isNumeric(_phoneCtrl.text)) {
        SnackBarService.instance.showSnackBarError('Enter valid phone number');
        return false;
      }
      if (_passwordCtrl.text.length < 8) {
        SnackBarService.instance
            .showSnackBarError('Password must be of atleast 8 charaters');
        return false;
      }
      if (!RegisterScreen.agreementStatus) {
        SnackBarService.instance
            .showSnackBarError('Check the agreement checkbox');
        return false;
      }
    }
    if (step == 2) {
      if (addressLine1Ctrl.text.isEmpty ||
          cityCtrl.text.isEmpty ||
          stateCtrl.text.isEmpty ||
          zipCodeCtrl.text.isEmpty) {
        SnackBarService.instance.showSnackBarError('All fields are mandatory');
        return false;
      }
    }
    if (step == 3) {
      if (_businessNameCtrl.text.isEmpty ||
          _businessAddressCtrl.text.isEmpty ||
          _gstNumberCtrl.text.isEmpty) {
        SnackBarService.instance.showSnackBarError('All fields are mandatory');
        return false;
      }
    }

    return true;
  }
}
