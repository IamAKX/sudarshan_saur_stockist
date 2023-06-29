import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/devices/assigned_detail.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/gaps.dart';

import '../../utils/colors.dart';

class AssignedDevices extends StatefulWidget {
  const AssignedDevices({super.key});

  @override
  State<AssignedDevices> createState() => _AssignedDevicesState();
}

class _AssignedDevicesState extends State<AssignedDevices> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              tileColor: Colors.white,
              title: Row(
                children: [
                  Text(
                    '200 WUGL-A-58X200-10',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  horizontalGap(defaultPadding / 2),
                  Text('| 221548$index')
                ],
              ),
              subtitle: Text('Dealer : ABC$index Enterprise PV LTD'),
              trailing: const Icon(
                Icons.chevron_right,
                color: hintColor,
              ),
              onTap: () =>
                  Navigator.pushNamed(context, AssignedDetail.routePath),
            ),
        separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: dividerColor,
            ),
        itemCount: 20);
  }
}
