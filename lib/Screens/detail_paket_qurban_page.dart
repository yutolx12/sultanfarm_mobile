// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_trading_models.dart';
import 'package:sultan_farm_mobile/Screens/detail_domba.dart';
import 'package:sultan_farm_mobile/Screens/domba_tersedia_page.dart';
import 'package:sultan_farm_mobile/Shimmer/detail_domba_shimmer.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/card_domba.dart';
import 'package:sultan_farm_mobile/Widgets/video_breeding.dart';
import 'package:http/http.dart' as http;

class DetailPaketQurbanPage extends StatefulWidget {
  const DetailPaketQurbanPage({Key? key}) : super(key: key);

  @override
  State<DetailPaketQurbanPage> createState() => _DetailPaketQurbanPageState();
}

class _DetailPaketQurbanPageState extends State<DetailPaketQurbanPage> {
  List<DombaModels> dombaListDetail = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiConnect.datadomba));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<DombaModels> dombas =
            jsonResponse.map((data) => DombaModels.fromJson(data)).toList();

        setState(() {
          dombaListDetail = dombas;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
    }
  }

  Future<void> refreshData() async {
    // Tambahkan penundaan 2 detik untuk efek Shimmer
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = true;
    });
    await fetchData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "Detail Paket Qurban",
            style: greyTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
              letterSpacing: 0.1,
            ),
          ),
          centerTitle: false,
          // actions: [
          //   IconButton(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     icon: const Icon(
          //       Icons.shopping_cart,
          //       size: 20,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const KeranjangPage()));
          //       // Aksi ketika ikon ditekan
          //     },
          //   ),
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            child: Column(
              children: [
                Container(
                  color: whiteColor,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/domba_paket_qurban.png',
                        width: double.infinity,
                        height: 360,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          0,
                          20,
                          16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paket Qurban',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                letterSpacing: 0.1,
                                fontWeight: regular,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '40Kg',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: regular,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 12.5,
                                  color: neutral90Color,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                ),
                                Text(
                                  'Jantan',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: regular,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Deskripsi',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                letterSpacing: 0.1,
                                fontWeight: bold,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Ini merupakan paket qurban yang tersedia pada CV. Sultan Farm',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                letterSpacing: 0.1,
                                fontWeight: regular,
                              ),
                              maxLines: 4,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ButtonWhatsappQurban(
                              icon: 'assets/logo_whatsapp.png',
                              iconColor: whiteColor,
                              title: 'Chat WhatsApp',
                              textColor: whiteColor,
                              buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor: bluetogreenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                isLoading
                    ? const DombaList()
                    : Container(
                        color: whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Domba Tersedia',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      final bool fromDashboard = (ModalRoute.of(
                                                          context)!
                                                      .settings
                                                      .arguments
                                                  as Map<String, dynamic>?)?[
                                              'fromDashboard'] ??
                                          false;
                                      if (fromDashboard) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DombaTersediaPage()));
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      'Lihat Semua',
                                      style: bluetogreenTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Wrap(
                                spacing: 16.0,
                                runSpacing: 16.0,
                                children: List.generate(
                                  dombaListDetail.take(6).length,
                                  (index) {
                                    DombaModels domba = dombaListDetail[index];

                                    DateTime tanggalLahir = DateTime.parse(
                                        domba.tglLahir.toString());
                                    DateTime now = DateTime.now();

                                    Duration difference =
                                        now.difference(tanggalLahir);
                                    int tahun =
                                        (difference.inDays / 365).floor();
                                    int bulan = ((difference.inDays % 365) / 30)
                                        .floor();
                                    int hari = (difference.inDays % 365) % 30;

                                    String formattglLahir =
                                        '$tahun Tahun $bulan Bulan $hari Hari';

                                    return CardDomba(
                                      tgllahir: formattglLahir,
                                      gambar: domba.gambar,
                                      idJenis: domba.jenisDomba,
                                      jenisKelamin: domba.jenisKelamin,
                                      bobot: domba.bobot,
                                      hargaJual: domba.hargaJual,
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DetailDomba(),
                                            settings: RouteSettings(
                                              arguments: {
                                                'fromDashboard': true,
                                                'domba': domba,
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
