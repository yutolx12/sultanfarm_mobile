// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class CardDombaSaya extends StatelessWidget {
  final String gambar;
  final String namaPaket;
  final String noKamar;
  final String plasma;
  final String status;
  final int jumlahDomba;
  final int total;
  final Decoration? customDecoration;
  final TextStyle? customTextStyle;

  const CardDombaSaya({
    super.key,
    required this.gambar,
    required this.namaPaket,
    required this.plasma,
    required this.noKamar,
    required this.total,
    required this.jumlahDomba,
    required this.status,
    this.customDecoration,
    this.customTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 7, 20, 7),
      padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // card pertama
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "${ApiConnect.host}web-sultan-farm/public/breeding/$gambar",
                    fit: BoxFit.fitHeight,
                  ),
                ), // Replace with your image asset path
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaPaket,
                      style: TextStyle(
                        fontFamily: 'poppins_medium',
                        fontSize: 14,
                        letterSpacing: 0.1,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '$jumlahDomba\tekor',
                          style: TextStyle(
                            fontFamily: 'poppins_medium',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(plasma),
                        const SizedBox(
                          width: 8,
                        ),
                        Text('No\t$noKamar')
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                          .format(total),
                      style: TextStyle(
                        // fontFamily: 'poppins_semibold',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            decoration: customDecoration,
            width: 120,
            height: 35,
            child: Center(child: Text(status, style: customTextStyle)),
          ),
        ],
      ),
    );
  }
}
