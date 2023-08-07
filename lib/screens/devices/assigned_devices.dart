import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/screens/devices/assigned_detail.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/gaps.dart';

import '../../model/model_list/warranty_request_list.dart';
import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../utils/preference_key.dart';

class AssignedDevices extends StatefulWidget {
  const AssignedDevices({super.key});

  @override
  State<AssignedDevices> createState() => _AssignedDevicesState();
}

class _AssignedDevicesState extends State<AssignedDevices> {
  WarrantyRequestList? list;
  late ApiProvider _api;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getWarrantyRequestListByStockist(SharedpreferenceKey.getUserId())
        .then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);

    return _api.status == ApiStatus.loading
        ? const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  tileColor: Colors.white,
                  title: Row(
                    children: [
                      Text(
                        '${list?.data?.elementAt(index).itemDescription}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      horizontalGap(defaultPadding / 2),
                      Expanded(
                        child: Text(
                          '| ${list?.data?.elementAt(index).warrantySerialNo}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  subtitle: Text(
                      'Dealer : ${list?.data?.elementAt(index).dealers?.businessName}'),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: hintColor,
                  ),
                  onTap: () => Navigator.pushNamed(
                      context, AssignedDetail.routePath,
                      arguments: list?.data?.elementAt(index)),
                ),
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: dividerColor,
                ),
            itemCount: list?.data?.length ?? 0);
  }
}
