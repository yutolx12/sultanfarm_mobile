import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_breeding_models.dart';
import 'package:sultan_farm_mobile/Screens/detail_breeding.dart';
import 'package:sultan_farm_mobile/Shimmer/breeding_page_shimmer.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/card_breeding.dart';
import 'package:sultan_farm_mobile/Widgets/handle_error.dart';
import 'package:http/http.dart' as http;
import 'package:sultan_farm_mobile/Widgets/video_breeding.dart';

class BreedingPage extends StatefulWidget {
  const BreedingPage({Key? key}) : super(key: key);

  @override
  State<BreedingPage> createState() => _BreedingPageState();
}

class _BreedingPageState extends State<BreedingPage> {
  List<DombaBreedingModels> breedingList = [];
  bool isLoading = true;

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
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Text(
              "Paket Breeding",
              style: greyTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
                letterSpacing: 0.1,
              ),
            ),
            // actions: [
            //   IconButton(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     icon: const Icon(Icons.shopping_cart),
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
            child: isLoading
                ? const BreedingPageShimmer()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal,
                    ),
                    // scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Video Informasi Mengenai Breeding',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold),
                                ),
                                const SizedBox(height: 16),
                                const YoutubeThumbnailContainer(
                                  videoId: 'EeriZHFu6hY',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: whiteColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilihan Paket Breeding',
                                style: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: breedingList.isEmpty
                                    ? [
                                        Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Text(
                                            'Data breeding tidak tersedia',
                                            style: blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: regular),
                                          ),
                                        )
                                      ]
                                    : List.generate(breedingList.length,
                                        (index) {
                                        DombaBreedingModels breding =
                                            breedingList[index];
                                        return Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          color: whiteColor,
                                          child: Column(
                                            children: [
                                              CardWidget(
                                                onTapp: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const DetailBreed(),
                                                      settings: RouteSettings(
                                                          arguments: {
                                                            'breeding': breding,
                                                          }),
                                                    ),
                                                  );
                                                },
                                                childImage: Image.network(
                                                  breding.gambar_url,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    if (error
                                                            is NetworkImageLoadException &&
                                                        error.statusCode ==
                                                            404) {
                                                      return const PlaceholderImageNotFound();
                                                    } else {
                                                      return const ErrorPlaceholder();
                                                    }
                                                  },
                                                ),
                                                subtitle1: breding.namaPaket,
                                                subtitle2: breding.harga,
                                                subtitle2Color: primary40Color,
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }
}
