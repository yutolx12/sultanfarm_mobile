// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/navigation_page_bloc.dart';
import 'package:sultan_farm_mobile/Models/riwayat_diajukan_models.dart';
import 'package:sultan_farm_mobile/Models/riwayat_diproses_models.dart';
import 'package:sultan_farm_mobile/Models/riwayat_ditolak_models.dart';
import 'package:sultan_farm_mobile/Models/riwayat_selesai_models.dart';
import 'package:sultan_farm_mobile/Screens/edit_akun_page.dart';
import 'package:sultan_farm_mobile/Screens/keranjang_page.dart';
import 'package:sultan_farm_mobile/Screens/sign_in_page.dart';
import 'package:sultan_farm_mobile/Screens/ubah_password_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:sultan_farm_mobile/Widgets/card_akun_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  List<RiwayatPengajuanModels>? responseData;
  List<RiwayatDiprosesModels>? responseDatadiproses;
  List<RiwayatSelesaiModels>? responseDataselesai;
  List<RiwayatDitolakModels>? responseDataditolak;
  int diajukanTabCount = 0;
  int didiprosesTabCount = 0;
  int selesaiTabCount = 0;
  int ditolakTabCount = 0;
  var id = '';
  var token = '';
  var name = '';
  var nomor = '';
  var alamat = '';
  var email = '';
  var jenis_kelamin = '';

  late SharedPreferences s_prefs;

  _showSavedValue() async {
    s_prefs = await SharedPreferences.getInstance();
    setState(() {
      token = s_prefs.getString("token").toString();
      id = s_prefs.getString("id").toString();
      name = s_prefs.getString("nama").toString();
      nomor = s_prefs.getString("nomor").toString();
      alamat = s_prefs.getString("alamat").toString();
      email = s_prefs.getString("email").toString();
      jenis_kelamin = s_prefs.getString("jenis_kelamin").toString();
      // fetchDataRiwayatDiajukan();
      // fetchDataRiwayatDiproses();
      // fetchDataRiwayatSelesai();
      // fetchDataRiwayatDitolak();
    });
  }

  @override
  void initState() {
    super.initState();
    _showSavedValue().then((_) {
      fetchDataRiwayatDiajukan();
      fetchDataRiwayatDiproses();
      fetchDataRiwayatSelesai();
      fetchDataRiwayatDitolak();
    });
  }

  Future<void> refreshData() async {
    // Tambahkan penundaan 2 detik untuk efek Shimmer
    await Future.delayed(const Duration(seconds: 2));
    await fetchDataRiwayatDiajukan();
    await fetchDataRiwayatDiproses();
    await fetchDataRiwayatSelesai();
    await fetchDataRiwayatDitolak();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchDataRiwayatDiajukan() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConnect.riwayatDiajukan),
        body: {
          'id_customer': id,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<RiwayatPengajuanModels> penjualans =
            data.map((item) => RiwayatPengajuanModels.fromJson(item)).toList();

        setState(() {
          responseData = penjualans;
          diajukanTabCount = penjualans.length;
        });
      } else {}
    } catch (e) {}
  }

  Future<void> fetchDataRiwayatDiproses() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConnect.riwayatDiproses),
        body: {
          'id_customer': id,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<RiwayatDiprosesModels> diproses =
            data.map((item) => RiwayatDiprosesModels.fromJson(item)).toList();

        setState(() {
          responseDatadiproses = diproses;
          didiprosesTabCount = diproses.length;
        });
      } else {}
    } catch (e) {}
  }

  Future<void> fetchDataRiwayatSelesai() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConnect.riwayatSelesai),
        body: {
          'id_customer': id,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<RiwayatSelesaiModels> selesai =
            data.map((item) => RiwayatSelesaiModels.fromJson(item)).toList();

        setState(() {
          responseDataselesai = selesai;
          selesaiTabCount = selesai.length;
        });
      } else {}
    } catch (e) {}
  }

  Future<void> fetchDataRiwayatDitolak() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConnect.riwayatDitolak),
        body: {
          'id_customer': id,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<RiwayatDitolakModels> ditolak =
            data.map((item) => RiwayatDitolakModels.fromJson(item)).toList();

        setState(() {
          responseDataditolak = ditolak;
          ditolakTabCount = ditolak.length;
        });
      } else {}
    } catch (e) {}
  }

  Future<void> sendLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('id');
    prefs.remove('nama');
    prefs.remove('nomor');
    prefs.remove('alamat');
    prefs.remove('email');
    prefs.remove('jenis_kelamin');
  }

  showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(20),
          title: Text(
            'Apakah anda yakin ingin Keluar ?',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(fontSize: 15, fontWeight: regular),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            SizedBox(
              height: 40,
              width: 100,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    side: BorderSide(color: bluetogreenColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the border radius to 10
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Batal',
                    style: bluetogreenTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 14),
                  )),
            ),
            CustomFilledButton(
              bgcolor: bluetogreenColor,
              width: 100,
              height: 40,
              title: 'Keluar',
              textColor: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
                letterSpacing: 0.5,
                color: whiteColor,
              ),
              onPressed: () async {
                setState(() {
                  sendLogout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                      (route) => false);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text(
            "Akun",
            style: greyTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
              letterSpacing: 0.1,
            ),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => KeranjangPage()));
          //       },
          //       icon: Icon(Icons.shopping_cart_rounded))
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: Size.zero,
                  child: Container(
                    color: whiteColor,
                    child: TabBar(
                      indicatorColor: bluetogreenColor,
                      unselectedLabelColor: greyColor,
                      labelColor: bluetogreenColor,
                      tabs: [
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$diajukanTabCount',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Diajukan')
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$didiprosesTabCount',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Diproses'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$selesaiTabCount',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Selesai')
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$ditolakTabCount',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('Ditolak')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 325,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150,
                            color: bluetogreenColor,
                          ),
                          Container(
                            width: double.infinity,
                            height: 150,
                            color: whiteColor,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: bluetogreenColor,
                                    radius: 50,
                                    child: Icon(
                                      Icons.person_rounded,
                                      color: whiteColor,
                                      size: 90,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          name,
                                          style: blackTextStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: bold,
                                            letterSpacing: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.add_location_rounded,
                                            color: bluetogreenColor,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 160,
                                            child: Text(
                                              alamat,
                                              style: blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold,
                                                letterSpacing: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: bluetogreenColor,
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 160,
                                            child: Text(
                                              email,
                                              style: blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold,
                                                letterSpacing: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.phone,
                                              color: bluetogreenColor),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 160,
                                            child: Text(
                                              nomor,
                                              style: blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold,
                                                letterSpacing: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Material(
                                      color: bluetogreenColor,
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        hoverColor: primary99Color,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditAkunPage(),
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Text(
                                              'Ubah Akun',
                                              style: whitekTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: semiBold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: Material(
                                      color: Colors.lightBlue.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        hoverColor: primary99Color,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UbahPasswordPage(),
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Text(
                                              'Ubah Password',
                                              style:
                                                  bluetogreenTextStyle.copyWith(
                                                      fontSize: 14,
                                                      fontWeight: semiBold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    hoverColor: primary99Color,
                                    onTap: () async {
                                      showConfirmationDialog();
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: bluetogreenColor,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Keluar',
                                        style: bluetogreenTextStyle.copyWith(
                                            fontSize: 16, fontWeight: semiBold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 8),
                sliver: SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      // first tab bar view widget
                      RefreshIndicator(
                        onRefresh: refreshData,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal,
                          ),
                          child: responseData != null &&
                                  responseData!.isNotEmpty
                              ? Column(
                                  children: responseData!.reversed.map((item) {
                                    int jumlahDomba;
                                    if (item.idPaket == 16) {
                                      jumlahDomba = 12;
                                    } else if (item.idPaket == 18) {
                                      jumlahDomba = 8;
                                    } else if (item.idPaket == 19) {
                                      jumlahDomba = 6;
                                    } else {
                                      jumlahDomba =
                                          0; // Set a default value or handle accordingly
                                    }
                                    return CardDombaSaya(
                                      gambar: item.gambar,
                                      jumlahDomba: jumlahDomba,
                                      namaPaket: item.namaPaket,
                                      plasma: item.namaPlasma,
                                      noKamar: item.noKamar,
                                      status: item.status,
                                      total: item.total,
                                      customDecoration: ShapeDecoration(
                                        color: succes95Color,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      customTextStyle: blackTextStyle.copyWith(
                                        color: succes40Color,
                                        fontWeight: semiBold,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Container(
                                  color: primary99Color,
                                  height: MediaQuery.of(context).size.height -
                                      AppBar()
                                          .preferredSize
                                          .height - // Height of the app bar
                                      kToolbarHeight - // Height of the tab bar
                                      250.0 - // Height of the profile container
                                      50.0, // Height of the tab indicator
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tidak ada Transaksi yang Diajukan',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: regular,
                                      fontSize: 14,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // second tab bar viiew widget
                      RefreshIndicator(
                        onRefresh: refreshData,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal,
                          ),
                          child: responseDatadiproses != null &&
                                  responseDatadiproses!.isNotEmpty
                              ? Column(
                                  children: responseDatadiproses!.reversed
                                      .map((item) {
                                    int jumlahDomba;
                                    if (item.idPaket == 16) {
                                      jumlahDomba = 12;
                                    } else if (item.idPaket == 18) {
                                      jumlahDomba = 8;
                                    } else if (item.idPaket == 19) {
                                      jumlahDomba = 6;
                                    } else {
                                      jumlahDomba =
                                          0; // Set a default value or handle accordingly
                                    }
                                    return CardDombaSaya(
                                      gambar: item.gambar,
                                      jumlahDomba: jumlahDomba,
                                      namaPaket: item.namaPaket,
                                      plasma: item.namaPlasma,
                                      noKamar: item.noKamar,
                                      status: item.status,
                                      total: item.total,
                                      customDecoration: ShapeDecoration(
                                        color: warning95Color,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      customTextStyle: blackTextStyle.copyWith(
                                        color: warning40Color,
                                        fontWeight: semiBold,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Container(
                                  color: primary99Color,
                                  height: MediaQuery.of(context).size.height -
                                      AppBar()
                                          .preferredSize
                                          .height - // Height of the app bar
                                      kToolbarHeight - // Height of the tab bar
                                      250.0 - // Height of the profile container
                                      50.0, // Height of the tab indicator
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tidak ada Transaksi yang Diproses',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: regular,
                                      fontSize: 14,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // third tab bar viiew widget
                      RefreshIndicator(
                        onRefresh: refreshData,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal,
                          ),
                          child: responseDataselesai != null &&
                                  responseDataselesai!.isNotEmpty
                              ? Column(
                                  children:
                                      responseDataselesai!.reversed.map((item) {
                                    int jumlahDomba;
                                    if (item.idPaket == 16) {
                                      jumlahDomba = 12;
                                    } else if (item.idPaket == 18) {
                                      jumlahDomba = 8;
                                    } else if (item.idPaket == 19) {
                                      jumlahDomba = 6;
                                    } else {
                                      jumlahDomba =
                                          0; // Set a default value or handle accordingly
                                    }
                                    return CardDombaSaya(
                                      gambar: item.gambar,
                                      jumlahDomba: jumlahDomba,
                                      namaPaket: item.namaPaket,
                                      plasma: item.namaPlasma,
                                      noKamar: item.noKamar,
                                      status: item.status,
                                      total: item.total,
                                      customDecoration: ShapeDecoration(
                                        color: primary95Color,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      customTextStyle: blackTextStyle.copyWith(
                                        color: primary40Color,
                                        fontWeight: semiBold,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Container(
                                  color: primary99Color,
                                  height: MediaQuery.of(context).size.height -
                                      AppBar()
                                          .preferredSize
                                          .height - // Height of the app bar
                                      kToolbarHeight - // Height of the tab bar
                                      250.0 - // Height of the profile container
                                      50.0, // Height of the tab indicator
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tidak ada Transaksi yang Selesai',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: regular,
                                      fontSize: 14,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      RefreshIndicator(
                        onRefresh: refreshData,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.normal,
                          ),
                          child: responseDataditolak != null &&
                                  responseDataditolak!.isNotEmpty
                              ? Column(
                                  children:
                                      responseDataditolak!.reversed.map((item) {
                                    int jumlahDomba;
                                    if (item.idPaket == 16) {
                                      jumlahDomba = 12;
                                    } else if (item.idPaket == 18) {
                                      jumlahDomba = 8;
                                    } else if (item.idPaket == 19) {
                                      jumlahDomba = 6;
                                    } else {
                                      jumlahDomba =
                                          0; // Set a default value or handle accordingly
                                    }
                                    return CardDombaSaya(
                                      gambar: item.gambar,
                                      jumlahDomba: jumlahDomba,
                                      namaPaket: item.namaPaket,
                                      plasma: item.namaPlasma,
                                      noKamar: item.noKamar,
                                      status: item.status,
                                      total: item.total,
                                      customDecoration: ShapeDecoration(
                                        color: danger99Color,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      customTextStyle: blackTextStyle.copyWith(
                                        color: danger40Color,
                                        fontWeight: semiBold,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Container(
                                  color: primary99Color,
                                  height: MediaQuery.of(context).size.height -
                                      AppBar()
                                          .preferredSize
                                          .height - // Height of the app bar
                                      kToolbarHeight - // Height of the tab bar
                                      250.0 - // Height of the profile container
                                      50.0, // Height of the tab indicator
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tidak ada Transaksi yang Ditolak',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: regular,
                                      fontSize: 14,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
