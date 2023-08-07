import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/main.dart';
import 'package:saur_stockist/model/user_model.dart';
import 'package:saur_stockist/screens/profile/change_password.dart';
import 'package:saur_stockist/screens/profile/edit_profile.dart';
import 'package:saur_stockist/screens/user_onboarding/login_screen.dart';
import 'package:saur_stockist/utils/colors.dart';
import 'package:saur_stockist/utils/preference_key.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/gaps.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ApiProvider _api;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getStockistById(prefs.getInt(SharedpreferenceKey.userId) ?? -1)
        .then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultPadding),
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                profileImageWidget(),
                verticalGap(defaultPadding),
                Text(
                  '${user?.stockistName}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '${user?.email}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                ),
              ],
            ),
          ),
        ),
        verticalGap(defaultPadding),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  LineAwesomeIcons.user_edit,
                ),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(EditProfile.routePath)
                      .then((value) => reloadScreen());
                },
              ),
              const Divider(
                height: 0,
                color: dividerColor,
                endIndent: defaultPadding,
                indent: defaultPadding * 3,
              ),
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  LineAwesomeIcons.user_lock,
                ),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, ChangePassword.routePath);
                },
              ),
              const Divider(
                height: 0,
                color: dividerColor,
                endIndent: defaultPadding,
                indent: defaultPadding * 3,
              ),
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  LineAwesomeIcons.phone,
                ),
                title: const Text('Contact Us'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  launchUrl(Uri.parse('tel://18008800'));
                },
              ),
              const Divider(
                height: 0,
                color: dividerColor,
                endIndent: defaultPadding,
                indent: defaultPadding * 3,
              ),
              // ListTile(
              //   tileColor: Colors.white,
              //   leading: const Icon(
              //     LineAwesomeIcons.list_ul,
              //   ),
              //   title: const Text('Terms and Conditions'),
              //   trailing: const Icon(Icons.chevron_right),
              //   onTap: () {
              //     Navigator.of(context).pushNamed(AgreementScreen.routePath);
              //   },
              // ),
              const Divider(
                height: 0,
                color: dividerColor,
                endIndent: defaultPadding,
                indent: defaultPadding * 3,
              ),
              ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  'Log out',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.red,
                      ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routePath, (route) => false);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Stack profileImageWidget() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(settingsPageUserIconSize),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(110),
            child: (user?.image?.isEmpty ?? true)
                ? Image.asset(
                    'assets/images/profile_image_placeholder.png',
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: user?.image ?? '',
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/profile_image_placeholder.png',
                      width: 110,
                      height: 110,
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
