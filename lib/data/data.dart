
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Constants {
  static const List<Map> drawerData = [
    {'name': "Unlocking", 'screen': "UnlockingScreen", "icon": FontAwesomeIcons.unlock,},
    {'name': "Repairs", 'screen': "RepairScreen", "icon": FontAwesomeIcons.screwdriverWrench,},
    {'name': "Network Unlockings", 'screen': "NetworkUnlockingScreen","icon":FontAwesomeIcons.globe,},
    {'name': "Contact Us", 'screen': "ContactUsScreen", "icon":FontAwesomeIcons.phone,},
    {'name': "Track your order", 'screen': "TrackOrderScreen", "icon":FontAwesomeIcons.locationDot},
    {'name': "Developers", "icon":FontAwesomeIcons.dev},
  ];
}

String modeldropdownvalue = 'Iphone 7 plus';
var models = [
  "Iphone 7 plus",
  "Iphone 8 plus",
  "Iphone X",
  "Iphone Xs max",
  "Iphone 11",
  "Iphone 12"
];
String Androidmodeldropdownvalue = 'Galaxy Note 10';
var modelsAndroid = [
  "Galaxy Note 10",
  "Galaxy M20",
  "Galaxy M54",
  "Galaxy S23 ultra",
  "Galaxy A23",
  "Galaxy Note 9"
];

var brands = [
  "Apple",
  "Samsung",
  "Motorola",
  "LG",
  "Huawei",
  "Google",
  "Nokia",
  "TCL"
];
var griditems = [
  "Screen",
  "Back Repair",
  "Charging Port",
  "Battery Repair",
  "Front Camera",
  "Back Camera",
  "Mic",
  "Ear Pc",
  "Loud Speaker",
];

List<Map<String, String>> gridItems = [
  {"number": "01",
  "icon": 'assets/images/repair-services.png',
   "function": "Screen"},
  {
    "number": "02",
    "function": "Back Repair",
    "icon":"assets/images/back-camera.png"
  },
  {
    "number": "03",
    "icon":"assets/images/smartphone.png",
    "function": "Charging Port",
  },
  {
    "number": "04",
    "icon":"assets/images/battery.png",
    "function": "Battery",
  },
  {
    "number": "05",
    "icon":"assets/images/front-camera.png",
    "function": "Front Camera",
  },
  {
    "number": "06",
    "icon":"assets/images/back-camera.png",
    "function": "Back Camera",
  },
  {
    "number": "07",
    "icon":"assets/images/mic.png",
    "function": "Mic",
  },
  {
    "number": "08",
    "icon":"assets/images/mobile-phone.png",
    "function": "EarPc",
  },
  {
    "number": "09",
    "icon":"assets/images/volume.png",
    "function": "LoudSpeaker",
  },
  {
    "number": "10",
   "icon":"assets/images/phonendoscope.png",
    "function": "Diagnostics",
  }
];
var images = [
  "assets/images/png-apple-logo-9711.png",
  "assets/images/samsung-logo-png-1294.png",
  "assets/images/pngwing.com.png",
  "assets/images/lg-logo-14410.png",
  "assets/images/huawei-logo-png-6980.png",
  "assets/images/google-logo-9808.png",
  "assets/images/nokia-logo-png-1474.png",
  "assets/images/tcl-logo-1.png",
];

var repairs_logo = [
  "assets/images/repairs/alcatel.png",
  "assets/images/repairs/Apple.png",
  "assets/images/repairs/coolpd.png",
  "assets/images/repairs/cricket.png",
  "assets/images/repairs/LG.png",
  "assets/images/repairs/MOTO.png",
  "assets/images/repairs/nokia.png",
  "assets/images/repairs/oneplus.png",
  "assets/images/repairs/revvl.png",
  "assets/images/repairs/Android.png",
  "assets/images/repairs/tcl.png"
];

var network_unlocking_logo = [
  "assets/images/netwrok_unlocking/att.png",
  "assets/images/netwrok_unlocking/boost.png",
  "assets/images/netwrok_unlocking/consumer.png",
  "assets/images/netwrok_unlocking/cricket.png",
  "assets/images/netwrok_unlocking/metro.png",
  "assets/images/netwrok_unlocking/mint.png",
  "assets/images/netwrok_unlocking/StraightTalk.png",
  "assets/images/netwrok_unlocking/tmobile.png",
];

String Servicesmodeldropdownvalue = 'METRO';
var services = [
  "CRICKET",
  "METRO",
  "TMOBILE",
  "BOOST",
  "ATT",
  "MINT",
  "CONSUMER CELL",
  "OTHERS"
];
var currentOrders = [
  "Alex - Iphone",
  "Samantha - Iphone",
  "Tom - Samsung",
  "Junaid - LG",
  "Ali - Tecno"
];
