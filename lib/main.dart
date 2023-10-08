import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_windows_app/constants.dart';
import 'package:new_windows_app/myHomePage.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setAlwaysOnTop(true);
  await windowManager.setTitleBarStyle(
    TitleBarStyle.hidden,
    windowButtonVisibility: true,
  );
  await windowManager.setResizable(false);
  await windowManager.setAsFrameless();
  await windowManager.setSize(Size(AppDims.smallWidth, AppDims.smallHeight) );
  await windowManager.setBackgroundColor(Colors.red);
  await windowManager.center();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
