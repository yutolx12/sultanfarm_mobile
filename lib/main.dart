import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sultan_farm_mobile/Screens/akad_page.dart';
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
import 'package:sultan_farm_mobile/Screens/pembayaran_page.dart';
import 'package:sultan_farm_mobile/Screens/sign_in_page.dart';
import 'package:sultan_farm_mobile/Screens/sign_up_page.dart';
import 'package:sultan_farm_mobile/Screens/splash_page.dart';
import 'package:sultan_farm_mobile/Screens/ubah_password_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Screens/domba_saya_page.dart';
import 'package:sultan_farm_mobile/Screens/monitoring_page.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import date_symbol_data_local.dart

// import '';
void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
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
      routes: {
        '/': (context) => const SplashPage(),
        // '/': (context) => const NavigationPage(),
        '/onboarding': (context) => const OnBoardingPage(),
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/navigation-page': (context) => const NavigationPage(),
        '/breeding-page': (context) => const BreedingPage(),
        '/dombaTersedia': (context) => const DombaTersediaPage(),
        '/detailDomba': (context) => const DetailDomba(),
        '/detailPaketQurban': (context) => const DetailPaketQurbanPage(),
        '/akad': (context) => const AkadPage(),
        '/pembayaran': (context) => const PembayaranPage(),
        '/dombasaya': (context) => const DombaSaya(),
        '/monitoring': (context) => const Monitoring(),
        // '/akun-page': (context) => const AkunPage(),
        '/edit-akun-page': (context) => const EditAkunPage(),
        '/ubah-password-page': (context) => const UbahPasswordPage(),
        '/keranjang-page': (context) => const KeranjangPage(),
        '/detailbreed': (context) => const DetailBreed(),
        '/invoice': (context) => invoice(),
      },
    );
  }
}
