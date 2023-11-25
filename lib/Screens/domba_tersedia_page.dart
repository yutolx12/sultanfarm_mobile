// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_trading_models.dart';
import 'package:sultan_farm_mobile/Screens/detail_domba.dart';
import 'package:sultan_farm_mobile/Shimmer/detail_domba_shimmer.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/card_domba.dart';
import 'package:sultan_farm_mobile/Widgets/modal_filter.dart';
import 'package:http/http.dart' as http;

class DombaTersediaPage extends StatefulWidget {
  const DombaTersediaPage({Key? key}) : super(key: key);

  @override
  State<DombaTersediaPage> createState() => _DombaTersediaPageState();
}

class _DombaTersediaPageState extends State<DombaTersediaPage> {
  bool isFilterActive = false;
  bool isModalVisible = false;
  bool isLoading = true;
  var getDomba = '';
  // String textOutput = "apa gitu kek";

  List<DombaModels> dombaList = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(ApiConnect.datadomba));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<DombaModels> dombas =
            jsonResponse.map((data) => DombaModels.fromJson(data)).toList();

        setState(() {
          dombaList = dombas;
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

  getFilterValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      getDomba = prefs.getString("getDomba").toString();
    });
    // final jenis = prefs.getString("jenis") ?? "";
    // final kelamin = prefs.getString("kelamin") ?? "";
    // final bobotMax = prefs.getInt("bobotMax") ?? 250;
    // final bobotMin = prefs.getInt("bobotMin") ?? 0;

    // return {
    //   "jenis": jenis,
    //   "kelamin": kelamin,
    //   "bobotMax": bobotMax,
    //   "bobotMin": bobotMin,
    // };
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

  void _openModal() async {
    final result = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ModalFilter(
          onFilterApplied: (isFiltered) {
            setState(() {
              isModalVisible = false;
              isFilterActive = isFiltered;
              getFilterValues();
              // textOutput = "kontol";
            });
          },
        );
      },
    );

    setState(() {
      isModalVisible = false;
      isFilterActive = result ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Domba Tersedia",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isModalVisible = true;
                    });
                    _openModal();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isFilterActive || isModalVisible
                          ? bluetogreenColor
                          : neutral95Color,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            isFilterActive || isModalVisible
                                ? 'assets/filter_fill.png'
                                : 'assets/filter.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Filter",
                            style: greyTextStyle.copyWith(
                              color: isFilterActive || isModalVisible
                                  ? whiteColor
                                  : dark50Color,
                              fontWeight: semiBold,
                              fontSize: 14,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(getDomba),
                const SizedBox(
                  height: 16,
                ),
                isLoading
                    ? const DetailDombaTersediaShimmer()
                    : Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: dombaList.isNotEmpty
                            ? List.generate(
                                dombaList.length,
                                (index) {
                                  DombaModels domba = dombaList[index];

                                  DateTime tanggalLahir =
                                      DateTime.parse(domba.tglLahir.toString());
                                  DateTime now = DateTime.now();

                                  Duration difference =
                                      now.difference(tanggalLahir);
                                  int tahun = (difference.inDays / 365).floor();
                                  int bulan =
                                      ((difference.inDays % 365) / 30).floor();
                                  int hari = (difference.inDays % 365) % 30;

                                  String formattglLahir =
                                      '$tahun Tahun $bulan Bulan $hari Hari';

                                  return CardDomba(
                                    jenisKelamin: domba.jenisKelamin,
                                    bobot: domba.bobot,
                                    gambar: domba.gambar,
                                    tgllahir: formattglLahir,
                                    idJenis: domba.jenisDomba,
                                    hargaJual: domba.hargaJual,
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DetailDomba(),
                                            settings: RouteSettings(arguments: {
                                              'fromDashboard': false,
                                              'domba': domba,
                                            })),
                                      );
                                    },
                                  );
                                },
                              )
                            : [
                                Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height *
                                      0.8, // Set an appropriate height
                                  child: Text(
                                    'Data domba tidak tersedia',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ),
                              ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
