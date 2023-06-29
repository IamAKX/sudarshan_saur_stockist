import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/alert_popup.dart';
import 'package:saur_stockist/widgets/gaps.dart';
import 'package:saur_stockist/widgets/primary_button_dark.dart';

import '../../utils/colors.dart';

class NewAssignment extends StatefulWidget {
  const NewAssignment({super.key});
  static const String routePath = '/newAssignment';

  @override
  State<NewAssignment> createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
  List<String> dealerList = [
    'Dealer 1',
    'Dealer 2',
    'Dealer 3',
    'Dealer 4',
    'Dealer 5'
  ];
  String _selectedDealer = 'Dealer 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Assignment',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select dealer'),
          verticalGap(defaultPadding / 2),
          Card(
            color: Colors.white,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  value: _selectedDealer,
                  underline: null,
                  items: dealerList
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDealer = value!;
                    });
                  },
                ),
              ),
            ),
          ),
          verticalGap(defaultPadding),
          const Text('Device Serial Number'),
          verticalGap(defaultPadding / 2),
          Expanded(
            child: Card(
              color: Colors.white,
              child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          '200 WUGL-A-58X200-10',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text('Serial Number : 221548$index'),
                        trailing: IconButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.question,
                              animType: AnimType.bottomSlide,
                              title: 'Are you sure?',
                              desc:
                                  'You are about to remove Serial Number : 221548$index from assignment set.',
                              onDismissCallback: (type) {},
                              autoDismiss: false,
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              btnCancelOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkColor: Colors.red,
                              btnCancelColor: primaryColor,
                            ).show();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        color: dividerColor,
                      ),
                  itemCount: 28),
            ),
          ),
          verticalGap(defaultPadding),
          PrimaryButtonDark(
              onPressed: () {
                showPopup(context, DialogType.success, 'Done',
                    'Serial numbers are assigned to the dealer');
              },
              label: 'Assign',
              isDisabled: false,
              isLoading: false)
        ],
      ),
    );
  }
}
