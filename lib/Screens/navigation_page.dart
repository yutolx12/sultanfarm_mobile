// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/navigation_page_bloc.dart';
import 'package:sultan_farm_mobile/Screens/dashboard_page.dart';
import 'package:sultan_farm_mobile/Screens/akun_page.dart';
import 'package:sultan_farm_mobile/Screens/breeding_page.dart';
import 'package:sultan_farm_mobile/Screens/domba_saya_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  //* Dibawah ini tempat untuk memanggil setiap page
  final NavigationBloc bloc = NavigationBloc();
  final NavigationBloc1 bloc1 = NavigationBloc1();
  int _selectedIndex = 0;
//
//! Dibawah ini kodingan custom navbarnya!!
//* Untuk memanggil setiap page kalian tinggal panggil aja navigationya saja

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Navigation>(
        stream: bloc.currentNavigationIndex,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _selectedIndex = snapshot.data!.index;
          }

          return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: [
                Dashboard(
                  bloc: bloc,
                ),
                const BreedingPage(),
                const DombaSaya(),
                const AkunPage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedIconTheme: const IconThemeData(size: 32),
              unselectedIconTheme: const IconThemeData(size: 32),
              selectedItemColor: bluetogreenColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: bluetogreenColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.home,
                      color: whiteColor,
                    ),
                  ),
                  icon: Icon(
                    Icons.home,
                    color: dark50Color,
                  ),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: bluetogreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/icon_breeding.png',
                      width: 32,
                      height: 32,
                      color: whiteColor,
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icon_breeding.png',
                    width: 32,
                    height: 32,
                    color: dark50Color,
                  ),
                  label: 'Breeding',
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: bluetogreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/icon_domba_saya.png',
                      width: 32,
                      height: 32,
                      color: whiteColor,
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icon_domba_saya.png',
                    width: 32,
                    height: 32,
                    color: dark50Color,
                  ),
                  label: 'Domba Saya',
                ),
                BottomNavigationBarItem(
                  activeIcon: Container(
                    decoration: BoxDecoration(
                      color: bluetogreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.person,
                      color: whiteColor,
                    ),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: dark50Color,
                  ),
                  label: 'Akun',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) =>
                  bloc.changeNavigationIndex(Navigation.values[index]),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
