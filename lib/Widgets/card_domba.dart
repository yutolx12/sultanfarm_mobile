import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/handle_error.dart';

class CardDomba extends StatelessWidget {
  final String jenisKelamin;
  final int bobot;
  final String gambar;
  final String tgllahir;
  final String idJenis;
  final int hargaJual;
  final VoidCallback? onTap;

  const CardDomba({
    super.key,
    required this.jenisKelamin,
    required this.bobot,
    required this.gambar,
    required this.tgllahir,
    required this.idJenis,
    this.onTap,
    required this.hargaJual,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 232,
        width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              10,
            ),
            boxShadow: [
              BoxShadow(
                color: dark20color,
                blurRadius: 0.1,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 152,
                  width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        10,
                      ),
                    ),
                    child: Image.network(
                      "${ApiConnect.host}web-sultan-farm/public/images/$gambar",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        if (error is NetworkImageLoadException &&
                            error.statusCode == 404) {
                          return PlaceholderImageNotFound(
                            width:
                                (MediaQuery.of(context).size.width - 3 * 16) /
                                    2,
                            height: 152,
                            fontsize: 14,
                          );
                        } else {
                          return const ErrorPlaceholder();
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      color: dark20color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      tgllahir,
                      style: blackTextStyle.copyWith(
                        color: primary99Color,
                        fontSize: 10,
                        fontWeight: regular,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    idJenis,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                      letterSpacing: 0.1,
                      height: 1.9,
                      color: dark20color,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$bobot Kg',
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          letterSpacing: 0.1,
                          height: 1.9,
                          color: dark20color,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 12.5,
                        color: neutral90Color,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                      ),
                      Text(
                        jenisKelamin,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                          letterSpacing: 0.1,
                          height: 1.9,
                          color: dark20color,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
                        .format(hargaJual),
                    style: blackTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 14,
                      letterSpacing: 0.1,
                      color: primary40Color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// c

class CardKeranjang extends StatefulWidget {
  const CardKeranjang({super.key});

  @override
  State<CardKeranjang> createState() => _CardKeranjangState();
}

class _CardKeranjangState extends State<CardKeranjang> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isChecked
                          ? bluetogreenColor
                          : const Color(0xffD9D9D9),
                    ),
                    child: isChecked
                        ? Center(
                            child: Icon(
                              Icons.check,
                              color: whiteColor,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    child: Image.asset(
                      'assets/domba_paket_qurban.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paket Breeding',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          '4 Ekor',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                            letterSpacing: 0.1,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 12.5,
                          color: neutral90Color,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Text(
                          'Plasma 1 No. 2',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Rp 1.000.000',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: neutral95Color,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primary95Color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tersedia',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                        letterSpacing: 0.4,
                        color: primary40Color,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: danger40Color,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: Text(
                          'Hapus',
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                            letterSpacing: 0.5,
                            color: danger40Color,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
