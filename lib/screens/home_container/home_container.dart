import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/dealers/dealers_screen.dart';
import 'package:saur_stockist/screens/devices/devices_screen.dart';

import '../devices/unassigned_devices.dart';
import '../profile/profile_screen.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});
  static const String routePath = '/homeContainer';

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _selectedIndex = 0;

  switchTabs(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => switchTabs(index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(
              Icons.playlist_add_check_circle_outlined,
            ),
            title: const Text('Allocated'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.playlist_add_circle_outlined),
            title: const Text('Unllocated'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    switch (_selectedIndex) {
      case 0:
        return const DealersScreen();
      case 1:
        return const UnassignedDevice(); //const DevicesScreen();
      case 2:
        return const ProfileScreen();
      default:
        return Container(); //WarrentyScreen(switchTabs: switchTabs);
    }
  }
}
