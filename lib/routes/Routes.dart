import 'package:get/get_navigation/get_navigation.dart';
import 'package:mobile_repairing/routes/RoutesNames.dart';
import 'package:mobile_repairing/view/MobileCategoriesAndroid/MobileCategoriesAndroid.dart';
import 'package:mobile_repairing/view/MobileCategoriesScreen/MobileCategoriesScreen.dart';
import 'package:mobile_repairing/view/NetworkUnlockingScreen/NetworkUnlockingScreen.dart';
import 'package:mobile_repairing/view/RepairGridScreen/RepairGridScreen.dart';
import 'package:mobile_repairing/view/Repairs/RepairsScreen.dart';
import 'package:mobile_repairing/view/SelectServiceScreen/SelectServiceScreen.dart';
import 'package:mobile_repairing/view/SplashScreen/SplashScreen.dart';
import 'package:mobile_repairing/view/SummaryScreen/SummaryScreen.dart';
import 'package:mobile_repairing/view/VendorScreens/OrderStatusScreen.dart';
import 'package:mobile_repairing/view/login/forgot_password.dart';

import '../view/FromToScreen/FromToScreen.dart';
import '../view/UnlockingScreen/UnlockingScreen.dart';
import '../view/login/login_screen.dart';
import '../view/signup/signup_screen.dart';
import '../view/ThankYouScreen/ThankyouScreen.dart';
import '../view/ContactUsScreen/ContactUsScreen.dart';
import '../view/TrackOrderScreen/TrackOrderScreen.dart';
import '../view/OrderDetailsScreen/OrderDetailsScreen.dart';
import '../view/VendorScreens/CurrentOrdersScreen.dart';

class Routes {
  static appRoutes() => [
        GetPage(
          name: RoutesNames.SplashScreen,
          transition: Transition.cupertino,
          page: () => SplashScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.SignupScreen,
          page: () => SignupScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.LoginScreen,
          page: () => LoginScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.ForgotPasswordScreen,
          page: () => ForgotPasword(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.SelectServiceScreen,
          page: () => SelectServiceScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.UnlockingScreen,
          page: () => UnlockingScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.MobileCategoriesScreen,
          page: () => MobileCategoriesScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.MobileCategoriesAndroidScreen,
          page: () => MobileCategoriesAndroidScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.RepairScreen,
          page: () => RepairScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.NetworkUnlockingScreen,
          page: () => NetworkUnlockingScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.FromToScreen,
          page: () => FromToScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.SummaryScreen,
          page: () => SummaryScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.RepairGridScreen,
          page: () => RepairGridScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.ThankyouScreen,
          page: () => ThankyouScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.TrackOrderScreen,
          page: () => TrackOrderScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.OrderDetailsScreen,
          page: () => OrderDetailsScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.ContactUsScreen,
          page: () => ContactUsScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.CurrentOrdersScreen,
          page: () => CurrentOrdersScreen(),
        ),
        GetPage(
          transition: Transition.cupertino,
          name: RoutesNames.OrderStatusScreen,
          page: () => OrderStatusScreen(),
        ),
      ];
}
