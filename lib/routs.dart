// routes.dart

import 'package:flutter/material.dart';
import 'package:novatech/welcome.dart';
import 'screens/on_boarding_screens/birthday_screen.dart';
import 'screens/on_boarding_screens/location_screen.dart';
import 'screens/on_boarding_screens/name_screen.dart';
import 'screens/on_boarding_screens/gender_screen.dart';
import 'screens/on_boarding_screens/intent_screen.dart';
import 'screens/on_boarding_screens/interested_screen.dart';

class AppRoutes {
  static const String birthday = '/birthday';
  static const String location = '/location';
  static const String name = '/name';
  static const String gender = '/gender';
  static const String interestedIn = '/interestedIn';
  static const String intent = '/intent';
  static const String welcome = '/welcome';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case birthday:
        return MaterialPageRoute(builder: (_) => BirthdayScreen());
      case location:
        return MaterialPageRoute(builder: (_) => LocationScreen());
      case name:
        return MaterialPageRoute(builder: (_) => NameScreen());
      case gender:
        return MaterialPageRoute(builder: (_) => GenderScreen());
      case interestedIn:
        return MaterialPageRoute(builder: (_) => InterestedInScreen());
      case intent:
        return MaterialPageRoute(builder: (_) => IntentScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for \${settings.name}')),
          ),
        );
    }
  }
}
