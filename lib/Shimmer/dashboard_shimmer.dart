import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAF3F4),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 200, // Sesuaikan dengan tinggi slider Anda
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 18,
                            width: 150, // Sesuaikan panjang teks
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height:
                            200, // Sesuaikan dengan tinggi video container Anda
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 18,
                            width: 180, // Sesuaikan panjang teks
                            color: Colors.white,
                          ),
                          Container(
                            height: 18,
                            width: 80, // Sesuaikan panjang teks
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 180, // Sesuaikan dengan tinggi card widget Anda
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                        width: 180,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 200,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 18,
                        width: 250,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 18,
                        width: 320,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 18,
                        width: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 18,
                            width: 80,
                            color: Colors.white,
                          ),
                        ],
                      )
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
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 18,
                            width: 100, // Sesuaikan panjang teks
                            color: Colors.white,
                          ),
                          Container(
                            height: 18,
                            width: 80, // Sesuaikan panjang teks
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: List.generate(6, (index) {
                        return Shimmer.fromColors(
                          baseColor:
                              Colors.grey[300]!, // Warna dasar lebih terang
                          highlightColor:
                              Colors.grey[100]!, // Warna highlight lebih gelap
                          child: Container(
                            width:
                                (MediaQuery.of(context).size.width - 3 * 16) /
                                    2,
                            height: 208,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
