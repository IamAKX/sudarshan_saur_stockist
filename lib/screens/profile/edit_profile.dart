import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/profile/edit_name.dart';
import 'package:saur_stockist/screens/profile/edit_phone_number.dart';
import 'package:saur_stockist/utils/colors.dart';

import 'edit_address.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const String routePath = '/editProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          unselectedLabelColor: hintColor,
          indicatorColor: primaryColor,
          tabs: const [
            Tab(text: 'Phone'),
            Tab(text: 'Personal Detail'),
            Tab(text: 'Address'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          EditPhoneNumber(),
          EditName(),
          EditAddress(),
        ],
      ),
    );
  }
}
