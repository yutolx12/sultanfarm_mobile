import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_breeding_models.dart';
import 'package:sultan_farm_mobile/Models/domba_trading_models.dart';
import 'package:sultan_farm_mobile/Models/navigation_page_bloc.dart';
import 'package:sultan_farm_mobile/Screens/detail_domba.dart';
import 'package:sultan_farm_mobile/Screens/detail_paket_qurban_page.dart';
import 'package:sultan_farm_mobile/Screens/detail_breeding.dart';
import 'package:sultan_farm_mobile/Screens/domba_tersedia_page.dart';
import 'package:sultan_farm_mobile/Shimmer/dashboard_shimmer.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/card_breeding.dart';
import 'package:sultan_farm_mobile/Widgets/card_domba.dart';
import 'package:sultan_farm_mobile/Widgets/handle_error.dart';
import 'package:sultan_farm_mobile/Widgets/photo_view.dart';
import 'package:sultan_farm_mobile/Widgets/video_breeding.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final NavigationBloc bloc;
  const Dashboard({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Dashboard> createState() => _DashboardState(bloc: bloc);
}

final List<String> imgList = [
  'https://plus.unsplash.com/premium_photo-1661963041652-40cb0675fb4b?auto=format&fit=crop&q=80&w=2073&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1511117833895-4b473c0b85d6?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1554755209-85e44182e019?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1602027438676-ad64751bdbc1?auto=format&fit=crop&q=80&w=1931&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1517486795373-6b76787246bb?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://plus.unsplash.com/premium_photo-1661826051876-10b1d7916f42?auto=format&fit=crop&q=80&w=1791&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
];

int _current = 0;
final CarouselController _controller = CarouselController();

class _DashboardState extends State<Dashboard> {
  final NavigationBloc bloc;
  List<DombaModels> dombaList = [];
  List<DombaBreedingModels> breedingList = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      // await Future.delayed(const Duration(seconds: 2));
      final response = await http.get(Uri.parse(ApiConnect.datadomba));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<DombaModels> dombas =
            jsonResponse.map((data) => DombaModels.fromJson(data)).toList();

        setState(() {
          dombaList = dombas;
          isLoading =
              false; // Perbaikan: Setelah mendapatkan data, hentikan loading.
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

  Future<void> fetchData2() async {
    try {
      // await Future.delayed(const Duration(seconds: 2));
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
        isLoading = false;
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
    await fetchData2();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchData2();
  }

  _DashboardState({required this.bloc});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text(
            "Dashboard",
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
          child: isLoading
              ? const DashboardShimmer()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: imgList.map((imgUrl) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Photo_View(
                                        imageUrl: imgUrl,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }).toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: false,
                              aspectRatio: 2.0,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    _current = index;
                                  },
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == entry.key
                                          ? bluetogreenColor.withOpacity(0.9)
                                          : neutral80Color,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Video Informasi Mengenai Breeding',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const YoutubeThumbnailContainer(
                                videoId: 'EeriZHFu6hY',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Paket Breeding Tersedia',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => bloc.changeNavigationIndex(
                                        Navigation.breeding),
                                    child: Text(
                                      'Lihat Semua',
                                      style: bluetogreenTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: breedingList.isNotEmpty
                                    ? breedingList.take(1).length
                                    : 1, // Mengganti itemCount dengan 1 jika breedingList kosong
                                itemBuilder: (context, index) {
                                  if (breedingList.isEmpty) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Text(
                                        'Data breeding tidak tersedia',
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14, fontWeight: regular),
                                      ),
                                    );
                                  }
                                  DombaBreedingModels breeding =
                                      breedingList[index];
                                  return CardWidget(
                                    onTapp: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DetailBreed(),
                                          settings: RouteSettings(
                                            arguments: {
                                              'breeding': breeding,
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    childImage: Image.network(
                                      breeding.gambar_url,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        if (error
                                                is NetworkImageLoadException &&
                                            error.statusCode == 404) {
                                          return const PlaceholderImageNotFound();
                                        } else {
                                          return const ErrorPlaceholder();
                                        }
                                      },
                                    ),
                                    subtitle1: breeding.namaPaket,
                                    subtitle2: breeding.harga,
                                    subtitle2Color: primary40Color,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DetailPaketQurbanPage(),
                              settings: const RouteSettings(
                                arguments: {'fromDashboard': true},
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Paket Qurban',
                                      style: blackTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: semiBold,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/domba_paket_qurban.png',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Dengan harga ',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: regular,
                                          letterSpacing: 0.1,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Rp 6.000.000',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: bold,
                                          letterSpacing: 0.1,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' Anda akan mendapatkan 1 ekor domba layak qurban setiap tahun',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 11,
                                          fontWeight: regular,
                                          letterSpacing: 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DetailPaketQurbanPage(),
                                            settings: const RouteSettings(
                                              arguments: {
                                                'fromDashboard': true
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Lihat Detail',
                                        style: bluetogreenTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DombaTersediaPage()));
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
                                children: dombaList.isNotEmpty
                                    ? List.generate(
                                        dombaList.take(6).length,
                                        (index) {
                                          DombaModels domba = dombaList[index];

                                          DateTime tanggalLahir =
                                              DateTime.parse(
                                                  domba.tglLahir.toString());
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
                                            tgllahir: formattglLahir,
                                            gambar: domba.gambar,
                                            idJenis: domba.jenisDomba,
                                            jenisKelamin: domba.jenisKelamin,
                                            bobot: domba.bobot,
                                            hargaJual: domba.hargaJual,
                                            onTap: () {
                                              Navigator.push(
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
                                      )
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
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
