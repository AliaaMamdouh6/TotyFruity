import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'login.dart';
import 'signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Language toggle in the top-right corner
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.language, color: Colors.white),
                    onPressed: () {
                      final isEnglish = context.locale.languageCode == 'en';
                      context.setLocale(isEnglish ? const Locale('ar', 'EG') : const Locale('en', 'US'));
                    },
                    tooltip: 'change_language'.tr(),
                  ),
                ],
              ),
            ),

            // Center logo + title
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", width: 2500, height: 300),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'app_title'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Suwannaphum',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Buttons at bottom (moved upward and larger)
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                      color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (_) => const Login()));
                    },
                    child: Text('login'.tr(), style: const TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 24),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.deepOrangeAccent, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (_) => const SignUp()));
                    },
                    child: Text('signup'.tr(), style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
