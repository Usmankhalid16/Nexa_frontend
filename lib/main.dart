
import 'package:flutter/material.dart';
import 'package:fyp_app/services/theme_ser.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'Database/database.dart';
import 'UI/hp.dart';
import 'UI/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Nexa',
      debugShowCheckedModeBanner: false,
      theme:Themes.light,
      darkTheme: Themes.dark,

      themeMode: ThemeSer().theme,

      home: hp()
    );
  }
}


