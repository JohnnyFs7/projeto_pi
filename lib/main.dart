
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/home/client_home.dart';
import 'screens/entrepreneur/entrepreneur_setup_screen.dart';

  void main() {
    WidgetsFlutterBinding.ensureInitialized();
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    runApp(const ServAquiApp());
  }
  
  class ServAquiApp extends StatelessWidget {
    const ServAquiApp({super.key});
    
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title:'ServAqui',
        debugShowCheckedModeBanner: false,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        
        theme:  ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3B4FE4),
              primary: const Color(0xFF3B4FE4),
              secondary: const Color(0xFFF97316),
              surface: Colors.white,
              error: const Color(0xFFEF4444),
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F5F7),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),

        initialRoute: '/splash',
        routes:  {

          '/splash':                  (_) => const SplashScreen(),

          '/auth':                    (_) => const AuthScreen(initialTab: 0),
          '/auth-register':           (_) => const AuthScreen(initialTab: 1),

          '/client-home':             (_) => const ClientHome(),
          '/entrepreneur-profile':    (_) => const PlaceholderScreen(label: 'EntrepreneurProfile'),
          '/booking':                 (_) => const PlaceholderScreen(label: 'BookingFlow'),
          '/my-bookings':             (_) => const PlaceholderScreen(label: 'Mybookings'),
          '/chat':                    (_) => const PlaceholderScreen(label: 'ChatScreen'),
          '/notifications':           (_) => const PlaceholderScreen(label: 'Notifications'),
          '/client-profile':          (_) => const PlaceholderScreen(label: 'ClientProfile'),

          '/entrepreneur-setup':      (_) => const PlaceholderScreen(label: 'EntrepreneurSetup'),
          '/entrepreneur-dashboard':  (_) => const PlaceholderScreen(label: 'EntrepreneurDashboard'),
          '/entrepreneir-calender':   (_) => const PlaceholderScreen(label: 'EntrepreneurCalender'),
        },
      );
    }
  }

  class PlaceholderScreen extends StatelessWidget {
    final String label;

    const PlaceholderScreen({
      super.key,
      required this.label,
  });

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(label),
        ),
        body: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

