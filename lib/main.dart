import 'package:ecommerce_app_client/Core/View/onBoarding/onBoardingScreen.dart';
import 'package:ecommerce_app_client/firebase_options.dart';
import 'package:ecommerce_app_client/global/constants/apiConstant.dart';
import 'package:ecommerce_app_client/helper/generalBinding.dart';
import 'package:ecommerce_app_client/global/theme/theme.dart';
import 'package:ecommerce_app_client/global/widgets/navigationMenu.dart';
import 'package:ecommerce_app_client/helper/RouteManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(  url: ApiConstant.supabaseUrl, anonKey: ApiConstant.supabaseKey , );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    // localization.init(
    //   mapLocales: [
    //     const MapLocale('ar', {}),
    //   ],
    //   initLanguageCode: 'ar',
    // )8.5;
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      theme: StoreAppTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: StoreAppTheme.darkTheme,
      // supportedLocales: localization.supportedLocales,
      //   localizationsDelegates: localization.localizationsDelegates,

      supportedLocales: [
        Locale('ar', 'AE'), // العربية
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ar', 'AE'),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      onGenerateRoute: (settings) => RouteManager.generateRoute(settings),
    );
  }
}
