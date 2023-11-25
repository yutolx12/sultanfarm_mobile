import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BreedingPageShimmer extends StatelessWidget {
  const BreedingPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAF3F4),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 18,
                          width: 250, // Sesuaikan panjang teks
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height:
                              200, // Sesuaikan dengan tinggi video container Anda
                          color: Colors.white,
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
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 18,
                          width: 100, // Sesuaikan panjang teks
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          children: List.generate(
                            4,
                            (index) {
                              return Shimmer.fromColors(
                                baseColor: Colors
                                    .grey[300]!, // Warna dasar lebih terang
                                highlightColor: Colors.grey[100]!,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 212,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListBreeding extends StatelessWidget {
  const ListBreeding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 18,
                width: 100, // Sesuaikan panjang teks
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: List.generate(
                  4,
                  (index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!, // Warna dasar lebih terang
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        children: [
                          Container(
                            height: 212,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
