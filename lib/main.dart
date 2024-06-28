import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_tracker/views/homepage.dart';
import 'package:money_tracker/providers/data_provider.dart';
import 'package:money_tracker/providers/theme_provider.dart';
import 'package:money_tracker/service/context_extention.dart';
import 'package:money_tracker/service/local_data.dart';
import 'package:money_tracker/service/navigation_service.dart';
import 'package:provider/provider.dart';

void main() async {
  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Preserving the splash screen until initialization completes
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Setting system UI mode and preferred orientation
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initializing local data storage
  await LocalData.init();

  // Removing the splash screen once initialization is done
  // FlutterNativeSplash.remove();

  // Running the application with multi providers
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        title: 'Money Tracker',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: context.primaryColor),
            useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
