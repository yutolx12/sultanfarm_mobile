import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class CardDombaSaya extends StatelessWidget {
  final String gambar;
  final String namaPaket;
  final String noKamar;
  final String plasma;
  final int total;
  final int jumlah;
  final String hari;
  final VoidCallback? onTap;
  const CardDombaSaya(
      {super.key,
      required this.gambar,
      required this.namaPaket,
      required this.total,
      required this.hari,
      this.onTap,
      required this.jumlah,
      required this.noKamar,
      required this.plasma});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "${ApiConnect.host}web-sultan-farm/public/breeding/$gambar",
                      fit: BoxFit.cover,
                    ),
                  ), // Replace with your image asset path
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaPaket,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '$jumlah Ekor',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            plasma,
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'No\t$noKamar',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp ',
                                decimalDigits: 0)
                            .format(total),
                        style: bluetogreenTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(hari,
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: semiBold)),
                const Spacer(),
                TextButton.icon(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.monitor,
                    color: bluetogreenColor,
                  ),
                  label: Text(
                    'monitoring',
                    style: bluetogreenTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
