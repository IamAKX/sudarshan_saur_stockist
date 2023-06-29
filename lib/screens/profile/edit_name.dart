import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/theme.dart';
import '../../widgets/alert_popup.dart';
import '../../widgets/gaps.dart';
import '../../widgets/input_field_light.dart';
import '../../widgets/primary_button_dark.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _businessNameCtrl = TextEditingController();
  final TextEditingController _businessAddressCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        verticalGap(defaultPadding),
        const Text(
          'Enter your name',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Full Name',
            controller: _nameCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.user),
        verticalGap(defaultPadding),
        const Text(
          'Enter Business name',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Business Name',
            controller: _businessNameCtrl,
            keyboardType: TextInputType.name,
            obscure: false,
            icon: LineAwesomeIcons.briefcase),
        verticalGap(defaultPadding),
        const Text(
          'Enter Business Address',
        ),
        verticalGap(defaultPadding),
        InputFieldLight(
            hint: 'Business Address',
            controller: _businessAddressCtrl,
            keyboardType: TextInputType.streetAddress,
            obscure: false,
            icon: LineAwesomeIcons.address_card),
        verticalGap(defaultPadding * 2),
        PrimaryButtonDark(
          onPressed: () {
            showPopup(
                context, DialogType.success, 'Success', 'Your name is updated');
          },
          label: 'Validate and Update',
          isDisabled: false,
          isLoading: false,
        )
      ],
    );
  }
}
