import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/model/user_model.dart';
import 'package:saur_stockist/screens/app_intro/app_intro_screen.dart';
import 'package:saur_stockist/screens/blocked_user/blocked_users_screen.dart';
import 'package:saur_stockist/screens/home_container/home_container.dart';
import 'package:saur_stockist/screens/user_onboarding/login_screen.dart';
import 'package:saur_stockist/service/api_service.dart';
import 'package:saur_stockist/utils/enum.dart';
import 'package:saur_stockist/utils/preference_key.dart';
import 'package:saur_stockist/utils/router.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/date_time_formatter.dart';

late SharedPreferences prefs;
UserModel? userModel;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (prefs.getInt(SharedpreferenceKey.userId) != null) {
    userModel = await ApiProvider()
        .getStockistById(prefs.getInt(SharedpreferenceKey.userId) ?? 0);
    if (userModel != null) {
      await ApiProvider().updateUser(
          {'lastLogin': DateTimeFormatter.now()}, userModel?.stockistId ?? 0);
    }
  }

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Sudarshan Saur',
        theme: globalTheme(context),
        debugShowCheckedModeBanner: false,
        home: getHomeScreen(),
        navigatorKey: navigatorKey,
        onGenerateRoute: NavRoute.generatedRoute,
      ),
    );
  }

  getHomeScreen() {
    if (prefs.getBool(SharedpreferenceKey.firstTimeAppOpen) ?? true) {
      prefs.setBool(SharedpreferenceKey.firstTimeAppOpen, false);
      return const AppIntroScreen();
    } else if (userModel == null || userModel?.stockistId == null) {
      return const LoginScreen();
    } else if ((userModel?.status ?? UserStatus.SUSPENDED.name) !=
        UserStatus.ACTIVE.name) {
      return const BlockedUserScreen();
    }
    return const HomeContainer();
  }
}
