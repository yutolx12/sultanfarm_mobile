import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_breeding_models.dart';
import 'package:sultan_farm_mobile/Shimmer/breeding_page_shimmer.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/bottom_sheet_breeding.dart';
import 'package:sultan_farm_mobile/Widgets/card_breeding.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:http/http.dart' as http;
import 'package:sultan_farm_mobile/Widgets/handle_error.dart';

class DetailBreed extends StatefulWidget {
  const DetailBreed({super.key});

  @override
  State<DetailBreed> createState() => _DetailBreedState();
}

class _DetailBreedState extends State<DetailBreed> {
  List<DombaBreedingModels> breedingList = [];
  bool isLoading = true;

  Future<dynamic> _openModal(
      int idPaket, int hargaPaket, String namaPaket) async {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        context: context,
        builder: (_) {
          return ModalBottomSheet(
            idPaket: idPaket,
            namaPaket: namaPaket,
            hargaPaket: hargaPaket,
          );
        });
  }

  Future<void> fetchData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await http.get(Uri.parse(ApiConnect.datadombabreeding));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<DombaBreedingModels> breedings = jsonResponse
            .map((data) => DombaBreedingModels.fromJson(data))
            .toList();
        setState(() {
          breedingList = breedings;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
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
    final DombaBreedingModels? breeding = args?['breeding'];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Detail Paket',
              style: greyTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
                letterSpacing: 0.1,
              )),
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: whiteColor,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          breeding!.gambar != null
                              ? Image.network(
                                  breeding.gambar_url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Tampilkan placeholder atau pesan kesalahan kustom.
                                    return const Center(
                                        child: Text(
                                      'Gagal memuat gambar',
                                    ));
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'Gambar Tidak Tersedia',
                                    style:
                                        whitekTextStyle.copyWith(fontSize: 18),
                                  ),
                                ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  breeding.namaPaket,
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(breeding.harga),
                                  style: bluetogreenTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Deskripsi',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                ),
                                const SizedBox(height: 10),
                                Text(breeding.keterangan),
                                const SizedBox(height: 40),
                                CustomFilledButton(
                                  onPressed: () {
                                    _openModal(breeding.id, breeding.harga,
                                        breeding.namaPaket);
                                  },
                                  title: 'Beli',
                                  textColor: TextStyle(
                                    color: whiteColor,
                                  ),
                                  width: double.infinity,
                                  bgcolor: bluetogreenColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const ListBreeding()
                    : Container(
                        width: double.infinity,
                        color: whiteColor,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paket Breeding Lainnya',
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children:
                                  List.generate(breedingList.length, (index) {
                                DombaBreedingModels item = breedingList[index];

                                if (breeding.id == item.id) {
                                  return const SizedBox();
                                }

                                return Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  color: whiteColor,
                                  child: Column(
                                    children: [
                                      CardWidget(
                                        onTapp: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetailBreed(),
                                                settings:
                                                    RouteSettings(arguments: {
                                                  'breeding': item,
                                                })),
                                          );
                                        },
                                        childImage: item.gambar != null
                                            ? Image.network(
                                                item.gambar_url,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  // Tampilkan placeholder atau pesan kesalahan kustom.
                                                  if (error
                                                          is NetworkImageLoadException &&
                                                      error.statusCode == 404) {
                                                    // Kode status 404, gambar tidak ditemukan.
                                                    return const PlaceholderImageNotFound();
                                                  } else {
                                                    // Kesalahan lain, tampilkan pesan kesalahan umum.
                                                    return const ErrorPlaceholder();
                                                  }
                                                },
                                              )
                                            : Center(
                                                child: Text(
                                                  'Gambar Tidak Tersedia',
                                                  style: whitekTextStyle
                                                      .copyWith(fontSize: 18),
                                                ),
                                              ),
                                        subtitle1: item.namaPaket,
                                        subtitle2: item.harga,
                                        subtitle2Color: primary40Color,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
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
