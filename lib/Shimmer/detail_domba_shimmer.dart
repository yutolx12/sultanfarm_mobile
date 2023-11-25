import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailDombaShimmer extends StatelessWidget {
  const DetailDombaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: List.generate(6, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Warna dasar lebih terang
          highlightColor: Colors.grey[100]!, // Warna highlight lebih gelap
          child: Container(
            width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
            height: 208,
            color: Colors.white,
          ),
        );
      }),
    );
  }
}

class DetailDombaTersediaShimmer extends StatelessWidget {
  const DetailDombaTersediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: List.generate(10, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Warna dasar lebih terang
          highlightColor: Colors.grey[100]!, // Warna highlight lebih gelap
          child: Container(
            width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
            height: 208,
            color: Colors.white,
          ),
        );
      }),
    );
  }
}

class DombaList extends StatelessWidget {
  const DombaList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 18,
                    width: 100,
                    color: Colors.white,
                  ),
                  Container(
                    height: 18,
                    width: 100,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: List.generate(6, (index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!, // Warna dasar lebih terang
                    highlightColor:
                        Colors.grey[100]!, // Warna highlight lebih gelap
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
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
    );
  }
}
