// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/utils/colors.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/alert_popup.dart';
import 'package:saur_stockist/widgets/gaps.dart';
import 'package:saur_stockist/widgets/input_field_light.dart';
import 'package:saur_stockist/widgets/primary_button_dark.dart';

import '../../main.dart';
import '../../model/user_model.dart';
import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';
import '../../utils/preference_key.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({super.key});

  @override
  State<EditPhoneNumber> createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _otpCtrl = TextEditingController();

  Timer? _timer;
  static const int otpResendThreshold = 30;
  int _secondsRemaining = otpResendThreshold;
  bool _timerActive = false;
  bool _isValidateButtonActive = true;

  late ApiProvider _api;
  UserModel? user;
  String code = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getStockistById(prefs.getInt(SharedpreferenceKey.userId) ?? -1)
        .then((value) {
      setState(() {
        user = value;
        _phoneNumberCtrl.text = user?.mobileNo ?? '';
      });
    });
  }

  sendOtp() {
    code = (Random().nextInt(9000) + 1000).toString();
    ApiProvider().sendOtp(_phoneNumberCtrl.text, code.toString());
  }

  void startTimer() {
    _secondsRemaining = otpResendThreshold;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _timerActive = true;
        } else {
          _timer?.cancel();
          _timerActive = false;
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          verticalGap(defaultPadding),
          const Text(
            'Enter new phone number',
          ),
          verticalGap(defaultPadding),
          InputFieldLight(
              hint: 'Phone Number',
              controller: _phoneNumberCtrl,
              keyboardType: TextInputType.phone,
              obscure: false,
              icon: Icons.call_outlined),
          Align(
            alignment: Alignment.centerRight,
            child: _timerActive
                ? TextButton(
                    onPressed: null,
                    child: Text('Resend in $_secondsRemaining seconds'),
                  )
                : TextButton(
                    onPressed: () {
                      _isValidateButtonActive = false;
                      startTimer();
                      sendOtp();
                    },
                    child: Text(
                      'Send OTP',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: primaryColor),
                    ),
                  ),
          ),
          verticalGap(defaultPadding * 2),
          const Text(
            'Enter the OTP',
          ),
          verticalGap(defaultPadding),
          OTPTextField(
            length: 4,
            width: MediaQuery.of(context).size.width - (defaultPadding * 3),
            fieldWidth: 40,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: textColorDark),
            otpFieldStyle: OtpFieldStyle(
              enabledBorderColor: primaryColor,
              borderColor: hintColor,
              focusBorderColor: primaryColor,
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              _otpCtrl.text = pin;
            },
          ),
          verticalGap(defaultPadding * 2),
          PrimaryButtonDark(
            onPressed: () async {
              if (_phoneNumberCtrl.text.isEmpty) {
                SnackBarService.instance
                    .showSnackBarError('All fields are mandatory');
                return;
              }

              if (code == '' || _otpCtrl.text != code) {
                SnackBarService.instance.showSnackBarError('Invalid otp');
                return;
              }

              Map<String, dynamic> map = {"mobileNo": _phoneNumberCtrl.text};
              _api.updateUser(map, user?.stockistId ?? -1).then((value) async {
                if (value) {
                  await reloadScreen();
                  showPopup(context, DialogType.success, 'Success',
                      'Your phone number is updated');
                }
              });
            },
            label: 'Validate and Update',
            isDisabled:
                _isValidateButtonActive || _api.status == ApiStatus.loading,
            isLoading: _api.status == ApiStatus.loading,
          )
        ],
      ),
    );
  }
}
