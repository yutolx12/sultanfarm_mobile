// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_trading_models.dart';
import 'package:sultan_farm_mobile/Screens/domba_tersedia_page.dart';
import 'package:sultan_farm_mobile/Shimmer/detail_domba_shimmer.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/card_domba.dart';
import 'package:sultan_farm_mobile/Widgets/handle_error.dart';
import 'package:sultan_farm_mobile/Widgets/video_breeding.dart';
import 'package:http/http.dart' as http;

class DetailDomba extends StatefulWidget {
  const DetailDomba({Key? key}) : super(key: key);

  @override
  State<DetailDomba> createState() => _DetailDombaState();
}

class _DetailDombaState extends State<DetailDomba> {
  List<DombaModels> dombaListDetail = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
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
      setState(() {
        isLoading = false; // Perbaikan: Hentikan loading jika ada kesalahan.
      });
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
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final DombaModels? domba = args?['domba'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "Detail Domba",
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
                      Image.network(
                        "${ApiConnect.host}/web-sultan-farm/public/images/${domba?.gambar ?? ''}",
                        // domba?.gambar ?? '',
                        width: double.infinity,
                        height: 360,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          if (error is NetworkImageLoadException &&
                              error.statusCode == 404) {
                            return const PlaceholderImageNotFound(
                              width: double.infinity,
                              height: 360,
                            );
                          } else {
                            return const ErrorPlaceholder();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              domba?.jenisDomba ?? '',
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
                                  '${domba?.bobot.toString() ?? ' '} Kg',
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
                                  domba?.jenisKelamin ?? '',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: regular,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(domba?.hargaJual ?? 0),
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 14,
                                letterSpacing: 0.1,
                                color: primary40Color,
                              ),
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
                              domba?.keterangan ?? '',
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
                            // Material(
                            //   color: primary99Color,
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: InkWell(
                            //     onTap: () {},
                            //     borderRadius: BorderRadius.circular(10),
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //         horizontal: 24,
                            //         vertical: 10,
                            //       ),
                            //       child: SizedBox(
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           children: [
                            //             Icon(
                            //               Icons.shopping_cart,
                            //               color: primary40Color,
                            //             ),
                            //             const SizedBox(
                            //               width: 4,
                            //             ),
                            //             Text(
                            //               'Keranjang',
                            //               style: blackTextStyle.copyWith(
                            //                 fontWeight: bold,
                            //                 fontSize: 14,
                            //                 letterSpacing: 0.5,
                            //                 color: primary40Color,
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 8,
                            // ),
                            ButtonWhatsapp(
                              buttonStyle: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: bluetogreenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              title: 'Beli',
                              icon: 'assets/logo_whatsapp.png',
                              textColor: whiteColor,
                              // domba: domba,
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
                                children: dombaListDetail.isNotEmpty
                                    ? dombaListDetail
                                        .take(6)
                                        .where(
                                            (dombas) => dombas.id != domba?.id)
                                        .map((dombas) {
                                        DateTime tanggalLahir = DateTime.parse(
                                            dombas.tglLahir.toString());
                                        DateTime now = DateTime.now();

                                        Duration difference =
                                            now.difference(tanggalLahir);
                                        int tahun =
                                            (difference.inDays / 365).floor();
                                        int bulan =
                                            ((difference.inDays % 365) / 30)
                                                .floor();
                                        int hari =
                                            (difference.inDays % 365) % 30;

                                        String formattglLahir =
                                            '$tahun Tahun $bulan Bulan $hari Hari';

                                        return CardDomba(
                                          key: ValueKey(dombas.id),
                                          tgllahir: formattglLahir,
                                          gambar: dombas.gambar,
                                          idJenis: dombas.jenisDomba,
                                          jenisKelamin: dombas.jenisKelamin,
                                          bobot: dombas.bobot,
                                          hargaJual: dombas.hargaJual,
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetailDomba(),
                                                settings: RouteSettings(
                                                  arguments: {
                                                    'fromDashboard': true,
                                                    'domba': dombas,
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList()
                                    : [
                                        Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4, // Set an appropriate height
                                          child: Text(
                                            'Data domba tidak tersedia',
                                            style: blackTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: regular,
                                            ),
                                          ),
                                        ),
                                      ],
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
