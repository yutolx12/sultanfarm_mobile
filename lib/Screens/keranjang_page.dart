import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/card_domba.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<Map<String, dynamic>> data = [
    {
      "title": "Paket 1",
      "price": "Rp. 1.000.000",
      "image": "https://picsum.photos/id/237/200/300",
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    {
      "title": "Paket 2",
      "price": "Rp. 1.500.000",
      "image": "https://picsum.photos/seed/picsum/200/300"
    },
    // ... data lainnya
  ];

  bool isChecked = false;

  bool _customTileExpanded = false;

  bool isLoading = false;
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(20),
          title: Text(
            'Apakah anda yakin dengan data yang anda masukkan?',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(fontSize: 15, fontWeight: regular),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            SizedBox(
              height: 40,
              width: 100,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    side: BorderSide(color: bluetogreenColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set the border radius to 10
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Batal',
                    style: bluetogreenTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 14),
                  )),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff228896),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  child: Text('Yakin',
                      style: whitekTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 20,
                      )),
                ))
            // CustomFilledButton(
            //   key: _formKey,
            //   bgcolor: bluetogreenColor,
            //   width: 100,
            //   height: 40,
            //   textColor: blackTextStyle.copyWith(
            //     fontWeight: semiBold,
            //     fontSize: 14,
            //     letterSpacing: 0.5,
            //     color: whiteColor,
            //   ),
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       CircularProgressIndicator();
            //     }
            //     setState(() {
            //       isLoading = true;
            //       Future.delayed(Duration(seconds: 2), () {
            //         // Setelah selesai, tutup dialog
            //         Navigator.of(context).pop();
            //       });
            //     });
            //   },
            //   child: isLoading
            //       ? const CircularProgressIndicator()
            //       : const Text('Yakin'),
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: whiteColor,
          title: Text(
            "Keranjang",
            style: greyTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
              letterSpacing: 0.1,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Row(
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
                        width: 4,
                      ),
                      Text(
                        'Pilih Semua',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                          letterSpacing: 0.4,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 580,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.normal,
                      ),
                      child: Wrap(
                        children: List.generate(data.length, (index) {
                          return const CardKeranjang();
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Container(
                  color: whiteColor,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        trailing: const SizedBox(),
                        initiallyExpanded: false,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _customTileExpanded = expanded;
                            // if (_customTileExpanded) {
                            //   _titleText = 'Detail Pesanan';
                            //   _jumlahBreeding = '10';
                            // } else {
                            //   _titleText = 'Pesanan';
                            //   _jumlahBreeding = '5';
                            // }
                            //
                          });
                        },
                        title: Center(
                          child: Icon(
                            _customTileExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                          ),
                        ),
                        children: const [],
                      ),
                      Text(
                        'Pesanan',
                        style: filterTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            'Jumlah Breeding',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                              letterSpacing: 0.4,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '5',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                              letterSpacing: 0.4,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Harga',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Rp 5.000.000',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                              letterSpacing: 0.5,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: neutral95Color,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff228896),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onPressed: () {
                            _showConfirmationDialog();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 40,
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text('Yakin',
                                    style: whitekTextStyle.copyWith(
                                      fontWeight: regular,
                                      fontSize: 20,
                                    )),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
