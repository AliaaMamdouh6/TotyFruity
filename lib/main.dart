import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'cart.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  

  runApp(
     EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/lang', // <-- change the path of the translation files 
      fallbackLocale: Locale('en', 'US'),
      child:TotyFruity()
    ),
  );
}

class TotyFruity extends StatelessWidget {
  const TotyFruity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Totyfruity',
      theme: ThemeData(primarySwatch: Colors.orange),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/welcome', // Start at Welcome Page
      routes: {
        '/welcome': (context) => const Welcome(),
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/cart': (context) => const Cart(cartItems: [],)
      },
    );
  }
}
