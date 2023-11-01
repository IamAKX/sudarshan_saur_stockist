import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/model/model_list/dealer_list_model.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/alert_popup.dart';
import 'package:saur_stockist/widgets/gaps.dart';
import 'package:saur_stockist/widgets/primary_button_dark.dart';

import '../../main.dart';
import '../../model/dealer_model.dart';
import '../../model/warranty_model.dart';
import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../utils/preference_key.dart';

class NewAssignment extends StatefulWidget {
  const NewAssignment({super.key, required this.warranty});
  static const String routePath = '/newAssignment';
  final Map<String, WarrantyModel> warranty;

  @override
  State<NewAssignment> createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
  DealerListModel? list;
  late ApiProvider _api;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    setState(() async {
      list = await _api.getAllDealers();
      _selectedDealerId = list?.data?.first.dealerId ?? -1;
    });
  }

  int _selectedDealerId = -1;
  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Assignment',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            )
          : getBody(context),
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
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.white,
                  value: _selectedDealerId,
                  underline: null,
                  items: list?.data
                      ?.map((DealerModel dealerModel) => DropdownMenuItem<int>(
                            value: dealerModel.dealerId,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  dealerModel.businessName ?? '',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  dealerModel.dealerName ?? '',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDealerId = value!;
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
                  itemBuilder: (context, index) {
                    String key = widget.warranty.keys.elementAt(index);
                    return ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        widget.warranty[key]?.itemDescription ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text('Serial Number : $key'),
                      trailing: IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.bottomSlide,
                            title: 'Are you sure?',
                            desc:
                                'You are about to remove Serial Number : $key from assignment set.',
                            onDismissCallback: (type) {},
                            autoDismiss: false,
                            btnOkOnPress: () {
                              setState(() {
                                widget.warranty.remove(key);
                              });

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
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                        color: dividerColor,
                      ),
                  itemCount: widget.warranty.length),
            ),
          ),
          verticalGap(defaultPadding),
          PrimaryButtonDark(
              onPressed: () async {
                if (widget.warranty.isEmpty) {
                  SnackBarService.instance
                      .showSnackBarError('No warranty selected');
                  return;
                }
                if (_selectedDealerId == -1) {
                  SnackBarService.instance
                      .showSnackBarError('No dealer selected');
                  return;
                }

                List reqBody = [];
                for (WarrantyModel model in widget.warranty.values) {
                  var item = {
                    "warrantySerialNo": model.warrantySerialNo,
                    "dealerId": _selectedDealerId,
                    "stockistId": SharedpreferenceKey.getUserId()
                  };
                  reqBody.add(item);
                }

                await _api.allocateToDealer(reqBody).then((value) {
                  if (value) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.bottomSlide,
                      title: 'Done',
                      desc: 'Serial numbers are assigned to the dealer',
                      onDismissCallback: (type) {},
                      autoDismiss: false,
                      btnOkOnPress: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      btnOkColor: primaryColor,
                    ).show();
                  }
                });
              },
              label: 'Assign',
              isDisabled: _api.status == ApiStatus.loading,
              isLoading: _api.status == ApiStatus.loading)
        ],
      ),
    );
  }
}
