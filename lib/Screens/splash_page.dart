// ignore: duplicate_ignore
// ignore_for_file: unused_import, duplicate_import, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Screens/akad_page.dart';
import 'package:sultan_farm_mobile/Screens/akun_page.dart';
import 'package:sultan_farm_mobile/Screens/blank_page.dart';
import 'package:sultan_farm_mobile/Screens/breeding_page.dart';
import 'package:sultan_farm_mobile/Screens/detail_domba.dart';
import 'package:sultan_farm_mobile/Screens/detail_paket_qurban_page.dart';
import 'package:sultan_farm_mobile/Screens/domba_tersedia_page.dart';
import 'package:sultan_farm_mobile/Screens/edit_akun_page.dart';
import 'package:sultan_farm_mobile/Screens/invoice_page.dart';
import 'package:sultan_farm_mobile/Screens/keranjang_page.dart';
import 'package:sultan_farm_mobile/Screens/detail_breeding.dart';
import 'package:sultan_farm_mobile/Screens/navigation_page.dart';
import 'package:sultan_farm_mobile/Screens/onboarding_page.dart';
import 'package:sultan_farm_mobile/Screens/sign_in_page.dart';
import 'package:sultan_farm_mobile/Screens/sign_up_page.dart';
import 'package:sultan_farm_mobile/Screens/splash_page.dart';
import 'package:sultan_farm_mobile/Screens/surat_kerja_sama_page.dart';
import 'package:sultan_farm_mobile/Screens/ubah_password_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Screens/domba_saya_page.dart';
import 'package:sultan_farm_mobile/Screens/monitoring_page.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sultan_farm_mobile/Screens/navigation_page.dart';
import 'package:sultan_farm_mobile/Screens/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var keyLogin;
  var token;
  @override
  void initState() {
    //
    super.initState();
    Timer(const Duration(seconds: 2), () => checktoken()
        );
  }

  Future<void> checktoken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    keyLogin = prefs.getString('keyLogin');
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: primaryColor,
            appBarTheme: AppBarTheme(
                backgroundColor: lightBackgroundColor,
                centerTitle: false,
                elevation: 1,
                titleTextStyle: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
                iconTheme: IconThemeData(color: blackColor))),
        // home: const NavigationPage(),
        // routes: {
        //   '/': (context) => const SplashPage(),
        //   // '/': (context) => const NavigationPage(),
        //   '/onboarding': (context) => const OnBoardingPage(),
        //   '/sign-in': (context) => const SignInPage(),
        //   '/Sign-Up': (context) => const SignUpPage(),
        //   '/navigation-page': (context) => const NavigationPage(),
        //   '/breeding-page': (context) => const BreedingPage(),
        //   '/dombaTersedia': (context) => const DombaTersediaPage(),
        //   '/detailDomba': (context) => const DetailDomba(),
        //   '/detailPaketQurban': (context) => const DetailPaketQurbanPage(),
        //   '/akad': (context) => const AkadPage(),
        //   '/TermsAndConditions': (context) => const TermsAndConditions(),
        //   '/dombasaya': (context) => const DombaSaya(),
        //   '/monitoring': (context) => const Monitoring(),
        //   '/akun-page': (context) => const AkunPage(),
        //   '/edit-akun-page': (context) => const EditAkunPage(),
        //   '/ubah-password-page': (context) => const UbahPasswordPage(),
        //   '/keranjang-page': (context) => const KeranjangPage(),
        //   '/detailbreed': (context) => const DetailBreed(),
        //   '/invoice': (context) => const invoice(),
        // },
        home: token == null ? const BlankPage() : const NavigationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
        child: Container(
          height: 209,
          width: 209,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logosultanfarm.png'))),
        ),
      ),
    );
  }
}
