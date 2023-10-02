import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_windows_app/constants.dart';
import 'package:new_windows_app/myHomePage.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setAlwaysOnTop(true);
  windowManager.setTitleBarStyle(TitleBarStyle.hidden);
  windowManager.setResizable(false);
  windowManager.setAsFrameless();
  windowManager.setSize(Size(AppDims.smallWidth, AppDims.smallHeight));
  windowManager.setBackgroundColor(Colors.transparent);
  windowManager.center();
  // await windowManager.setBounds(
  //   Rect.fromCenter(
  //       center: Offset(1000, 200),
  //       width: AppDims.width,
  //       height: AppDims.height),
  // );
  // windowManager.setAlignment(Alignment.bottomRight);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
