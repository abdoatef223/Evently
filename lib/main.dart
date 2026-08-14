import 'package:evently_c19/core/remote/local/prefs_manager.dart';
import 'package:evently_c19/core/resources/app_theme.dart';
import 'package:evently_c19/core/resources/colors_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:evently_c19/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c19/ui/event_details/screen/event_details.dart';
import 'package:evently_c19/ui/edit_evet/screen/edit_event.dart';
import 'package:evently_c19/model/event.dart';
import 'package:evently_c19/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c19/ui/home/screen/home_screen.dart';
import 'package:evently_c19/ui/login/screen/login_screen.dart';
import 'package:evently_c19/ui/signup/screen/signup_screen.dart';
import 'package:evently_c19/ui/start/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefsManager.init();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider()..init(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      themeMode: themeProvider.selectedTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesManager.startRouteName: (_) => StartScreen(),
        RoutesManager.loginRouteName: (_) => LoginScreen(),
        RoutesManager.homeRouteName: (_) => ChangeNotifierProvider(
            create: (context) => UserProvider()..fetchUser(),
            child: HomeScreen()),
        RoutesManager.signupRouteName: (_) => SignupScreen(),
        RoutesManager.forgetpassRouteName: (_) => ForgetPassScreen(),
        RoutesManager.addEventRouteName: (_) => AddEventScreen(),
        RoutesManager.eventDetailsRouteName: (context) => EventDetailsScreen(
          event: ModalRoute.of(context)!.settings.arguments as Event,
        ),
        RoutesManager.editEventRouteName: (context) => EditEvent(
          event: ModalRoute.of(context)!.settings.arguments as Event,
        ),
      },
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? RoutesManager.homeRouteName
          : RoutesManager.loginRouteName,
    );
  }
}