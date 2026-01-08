import 'package:almaren_desktop/page/frame/frame_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Window.initialize();
  // //await Window.makeTitlebarTransparent();
  // //await Window.enableFullSizeContentView();
  // await Window.setEffect(
  //   effect: WindowEffect.acrylic,
  //   dark: false,
  // );
  // await Window.hideWindowControls();
  // await Window.enableFullSizeContentView();

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    center: true,
    skipTaskbar: false,
    size: Size(1020, 760),
    titleBarStyle: TitleBarStyle.hidden,
    backgroundColor: Colors.transparent,
    //windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Almaren',
      theme: ThemeData(
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.light(primary: Colors.black54),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFEDEDED),
          hintStyle: TextStyle(color: Color(0xFFADB5BD)),
          labelStyle: TextStyle(fontSize: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          isDense: true,
        ),
        dividerTheme: DividerThemeData(
          color: Color(0xFFEFEFEF),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FramePage(),
    );
  }
}
