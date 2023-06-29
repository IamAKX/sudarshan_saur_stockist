import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/dealers/dealer_detail.dart';
import 'package:saur_stockist/screens/devices/assigned_detail.dart';
import 'package:saur_stockist/screens/devices/new_assignment.dart';
// import 'package:saur_stockist/screens/home_container/home_container.dart';
import 'package:saur_stockist/screens/password_recovery/recover_password_screen.dart';
import 'package:saur_stockist/screens/profile/change_password.dart';
import 'package:saur_stockist/screens/profile/edit_profile.dart';
import 'package:saur_stockist/screens/user_onboarding/agreement_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/login_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/register_screen.dart';

import '../screens/app_intro/app_intro_screen.dart';
import '../screens/home_container/home_container.dart';

class NavRoute {
  static MaterialPageRoute<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppIntroScreen.routePath:
        return MaterialPageRoute(builder: (_) => const AppIntroScreen());
      case LoginScreen.routePath:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RegisterScreen.routePath:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AgreementScreen.routePath:
        return MaterialPageRoute(builder: (_) => const AgreementScreen());
      case RecoverPasswordScreen.routePath:
        return MaterialPageRoute(builder: (_) => const RecoverPasswordScreen());
      case HomeContainer.routePath:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      case EditProfile.routePath:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case ChangePassword.routePath:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case DealerDetail.routePath:
        return MaterialPageRoute(builder: (_) => const DealerDetail());
      case AssignedDetail.routePath:
        return MaterialPageRoute(builder: (_) => const AssignedDetail());
      case NewAssignment.routePath:
        return MaterialPageRoute(builder: (_) => const NewAssignment());
      default:
        return errorRoute();
    }
  }
}

errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return const Scaffold(
      body: Center(
        child: Text('Undefined route'),
      ),
    );
  });
}
