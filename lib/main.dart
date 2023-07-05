import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/routes/Routes.dart';
import 'package:mobile_repairing/view/SplashScreen/SplashScreen.dart';
import 'package:mobile_repairing/view/login/login_screen.dart';
import 'package:mobile_repairing/view/signup/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  Stripe.publishableKey = "pk_test_51I5tHmIgEohNnSipw789DLZ5WIfMW2yI86GetMz0iVYPXcjmJkiY7A9A1VO79ZGHmzoonxFTDMWZX89NWfY1rFU8005JMqg9A4";
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: Routes.appRoutes(),
      debugShowCheckedModeBanner: false,
      title: 'IRepair-Fix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryClr)
      ),
      home: const SplashScreen(),
    );
  }
}
