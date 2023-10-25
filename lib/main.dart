import 'package:EfiritRetail/store/controllers/organization.dart';
import 'package:EfiritRetail/store/services/api.dart';
import 'package:EfiritRetail/theme.dart';
import 'package:EfiritRetail/routes.dart';
import 'package:EfiritRetail/store/controllers/auth.dart';
import 'package:EfiritRetail/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  final AuthCtrl authCtrl = Get.put(AuthCtrl());
  FlutterSecureStorage storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  @override
  void initState() {
    super.initState();

    // var brightness = SchedulerBinding.instance.window.platformBrightness;
    // storage.read(key: 'isDarkMode').then((value) {
    //   if (value != null) {
    //     isDarkMode = value == 'true';
    //   } else {
    //     isDarkMode = brightness == Brightness.dark;
    //   }
    //   Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    // });
    Get.changeThemeMode(ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EfiritRetail',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
      theme: Styles.lightMode(context),
      darkTheme: Styles.darkMode(context),
      initialRoute: RouterHelper.initial,
      getPages: RouterHelper.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru'), Locale('en')],
    );
  }
}
