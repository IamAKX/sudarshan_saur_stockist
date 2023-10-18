import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/blocked_user/blocked_users_screen.dart';
import 'package:saur_stockist/screens/dealers/dealer_detail.dart';
import 'package:saur_stockist/screens/devices/assigned_detail.dart';
import 'package:saur_stockist/screens/devices/new_assignment.dart';
// import 'package:saur_stockist/screens/home_container/home_container.dart';
import 'package:saur_stockist/screens/profile/change_password.dart';
import 'package:saur_stockist/screens/profile/edit_profile.dart';
import 'package:saur_stockist/screens/user_onboarding/address_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/agreement_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/business_detail.dart';
import 'package:saur_stockist/screens/user_onboarding/change_phone.dart';
import 'package:saur_stockist/screens/user_onboarding/login_screen.dart';
import 'package:saur_stockist/screens/user_onboarding/register_screen.dart';

import '../model/warranty_model.dart';
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

      case HomeContainer.routePath:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      case EditProfile.routePath:
        return MaterialPageRoute(builder: (_) => const EditProfile());

      case AddressScreen.routePath:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case BusinessDetails.routePath:
        return MaterialPageRoute(builder: (_) => const BusinessDetails());
      case ChangePhoneNumber.routePath:
        return MaterialPageRoute(builder: (_) => const ChangePhoneNumber());

      case DealerDetail.routePath:
        return MaterialPageRoute(
            builder: (_) => DealerDetail(
                  data: settings.arguments as Map<String, dynamic>,
                ));
      case AssignedDetail.routePath:
        return MaterialPageRoute(
            builder: (_) => AssignedDetail(
                  warrantyModel: settings.arguments as WarrantyModel,
                ));
      case NewAssignment.routePath:
        return MaterialPageRoute(
            builder: (_) => NewAssignment(
                  warranty: settings.arguments as Map<String, WarrantyModel>,
                ));
      case BlockedUserScreen.routePath:
        return MaterialPageRoute(builder: (_) => const BlockedUserScreen());
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
