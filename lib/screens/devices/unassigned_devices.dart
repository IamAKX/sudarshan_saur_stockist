import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:saur_stockist/screens/devices/new_assignment.dart';
import 'package:saur_stockist/utils/colors.dart';

class UnassignedDevice extends StatefulWidget {
  const UnassignedDevice({super.key});

  @override
  State<UnassignedDevice> createState() => _UnassignedDeviceState();
}

class _UnassignedDeviceState extends State<UnassignedDevice> {
  Set<int> selectedIndex = {};

  addToList(int index) {
    setState(() {
      selectedIndex.add(index);
    });
  }

  removeFromList(int index) {
    setState(() {
      selectedIndex.remove(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: selectedIndex.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, NewAssignment.routePath);
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
                value: selectedIndex.length == 20,
                onChanged: (value) {
                  setState(() {
                    if (value ?? false) {
                      for (var i = 0; i < 20; i++) {
                        selectedIndex.add(i);
                      }
                    } else {
                      selectedIndex.clear();
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
                      '200 WUGL-A-58X200-10',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text('Serial Number : 221548$index'),
                    onChanged: (bool? value) {
                      if (value ?? false) {
                        addToList(index);
                      } else {
                        removeFromList(index);
                      }
                    },
                    value: selectedIndex.contains(index),
                  ),
              separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: dividerColor,
                  ),
              itemCount: 20),
        ),
      ],
    );
  }
}
