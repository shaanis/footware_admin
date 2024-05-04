import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/controller/home_controller.dart';
import 'package:footware_admin/firebase_options.dart';
import 'package:footware_admin/pages/add_product.dart';
import 'package:footware_admin/pages/homepage.dart';
import 'package:footware_admin/pages/orderList.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //rgstr mycontroller
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Footware Admin',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const HomePage(), 
        '/HomePage': (context) => const HomePage(),
        '/AddProduct': (context) =>const AddProduct(),
        '/OrderList': (context) =>  const OrderList()
        // Add more routes as needed
      },
      // home: const HomePage(),
    );
  }
}
