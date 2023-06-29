import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/devices/assigned_devices.dart';
import 'package:saur_stockist/screens/devices/unassigned_devices.dart';

import '../../utils/colors.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Devices',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: hintColor,
          indicatorColor: primaryColor,
          tabs: const [
            Tab(text: 'Assigned'),
            Tab(text: 'Unassigned'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AssignedDevices(),
          UnassignedDevice(),
        ],
      ),
    );
  }
}
