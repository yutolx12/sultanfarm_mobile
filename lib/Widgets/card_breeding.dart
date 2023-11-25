// ignore: unused_import
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    this.childImage,
    required this.subtitle1,
    required this.subtitle2,
    this.subtitle2Color,
    this.onTapp,
  });
  final Widget? childImage;
  final String subtitle1;
  final int subtitle2;
  final VoidCallback? onTapp;
  final Color? subtitle2Color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapp,
      child: Card(
        shadowColor: dark20color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: whiteColor,
        margin: const EdgeInsets.all(0),
        elevation: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: childImage,
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subtitle1,
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                          .format(subtitle2),
                      style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                          color: subtitle2Color),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
