import 'dart:developer';

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/model/model_list/warranty_request_list.dart';
import 'package:saur_stockist/model/user_model.dart';
import 'package:saur_stockist/model/warranty_model.dart';
import 'package:saur_stockist/screens/devices/new_assignment.dart';
import 'package:saur_stockist/utils/colors.dart';
import 'package:saur_stockist/utils/helper_method.dart';
import 'package:saur_stockist/utils/theme.dart';

import '../../main.dart';
import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';
import '../../utils/preference_key.dart';

class UnassignedDevice extends StatefulWidget {
  const UnassignedDevice({super.key});

  @override
  State<UnassignedDevice> createState() => _UnassignedDeviceState();
}

class _UnassignedDeviceState extends State<UnassignedDevice> {
  Map<String, WarrantyModel> selectedIndex = {};
  UserModel? user;
  WarrantyRequestList? list;
  late ApiProvider _api;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadUser(),
    );
  }

  reloadUser() async {
    await _api
        .getStockistById(prefs.getInt(SharedpreferenceKey.userId) ?? -1)
        .then((value) async {
      user = value;
      if (user != null) {
        // SnackBarService.instance.showSnackBarInfo(
        //     'This is taking longer than usual, please wait...');
        list = await _api.getWarrantyListFromCrm(user!);
      }
    });

    setState(() {});
  }

  addToList(WarrantyModel? warranty) {
    setState(() {
      selectedIndex[warranty!.warrantySerialNo ?? ''] = warranty!;
    });
  }

  removeFromList(WarrantyModel? warranty) {
    setState(() {
      selectedIndex.remove(warranty!.warrantySerialNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithSearchSwitch(
        actionsIconTheme: const IconThemeData(color: primaryColor),
        keepAppBarColors: false,
        backgroundColor: Colors.white,
        animation: (child) => AppBarAnimationSlideLeft(
            milliseconds: 600, withFade: false, percents: 1.0, child: child),
        onChanged: (value) {},
        appBarBuilder: (context) => AppBar(
          title: Text(
            'Unallocated Device',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: const [
            // AppBarSearchButton(
            //   buttonHasTwoStates: false,
            // )
          ],
        ),
      ),
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Text(
                      'Executing long running process.\nPlease do not leave the screen',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          : getBody(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: selectedIndex.isEmpty
          ? null
          : list?.data?.isEmpty ?? true
              ? Container()
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      NewAssignment.routePath,
                      arguments: selectedIndex,
                    ).then((value) => reloadUser());
                  },
                  backgroundColor: primaryColor,
                  child: const Icon(LineAwesomeIcons.user_plus),
                ),
    );
  }

  Column getBody(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedIndex.length} device selected',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Checkbox(
                value: selectedIndex.keys.length ==
                    list?.data?.map((e) => e.warrantySerialNo).toSet().length,
                onChanged: (value) {
                  log('selectedIndex.keys.length = ${selectedIndex.keys.length}');
                  log('list?.data?.map((e) => e.warrantySerialNo).toSet().length = ${list?.data?.map((e) => e.warrantySerialNo).toSet().length}');
                  setState(() {
                    selectedIndex = {};
                    if (value ?? false) {
                      list?.data?.forEach((element) {
                        addToList(element);
                      });
                    } else {
                      // selectedIndex = {};
                    }
                  });
                },
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => CheckboxListTile(
                    tileColor: Colors.white,
                    title: Text(
                      getWarantyLabel(list?.data?.elementAt(index)),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                        'Serial Number : ${list?.data?.elementAt(index).warrantySerialNo ?? ''}'),
                    onChanged: (bool? value) {
                      if (value ?? false) {
                        addToList(list?.data?.elementAt(index));
                      } else {
                        removeFromList(list?.data?.elementAt(index));
                      }
                    },
                    value: selectedIndex.containsKey(
                        list?.data?.elementAt(index).warrantySerialNo ?? ''),
                  ),
              separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: dividerColor,
                  ),
              itemCount: list?.data?.length ?? 0),
        ),
      ],
    );
  }
}
