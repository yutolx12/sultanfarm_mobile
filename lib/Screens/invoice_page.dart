// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Screens/akad_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';

class invoice extends StatefulWidget {
  invoice({super.key, this.idPaket, this.idPlasma, this.idKamar});

  int? idPaket;
  int? idPlasma;
  int? idKamar;

  @override
  State<invoice> createState() => _invoiceState();
}

class _invoiceState extends State<invoice> {
  var name = '';
  var alamat = '';
  late String namaPaket = '';
  late int hargaPaket = 0;
  late SharedPreferences pref;
  bool isLoading = false;
  String currentDate =
      DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now());

  late SharedPreferences prefs;
  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("nama").toString();
      alamat = prefs.getString("alamat").toString();
    });
  }

  Future<void> getDataPaket() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      namaPaket = pref.getString('TransaksiNamaPaket').toString();
      hargaPaket = pref.getInt('TransaksiHargaPaket')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataPaket();
    getDataAkun();
  }

  @override
  Widget build(BuildContext context) {
    //tab atas invoice
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: Text("Invoice",
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold)),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        " Apakah anda Yakin ingin kembali ?",
                        textAlign: TextAlign.center,
                        style: blackTextStyle.copyWith(
                            fontSize: 15, fontWeight: regular),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
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
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Batal',
                                style: bluetogreenTextStyle.copyWith(
                                    fontWeight: semiBold, fontSize: 14),
                              )),
                        ),
                        CustomFilledButton(
                          bgcolor: bluetogreenColor,
                          width: 100,
                          height: 40,
                          title: 'Yakin',
                          textColor: blackTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14,
                            letterSpacing: 0.5,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            // Lakukan aksi yang diperlukan ketika "Yakin" ditekan.
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool canPop = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  " Apakah anda Yakin ingin kembali ?",
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(
                      fontSize: 15, fontWeight: regular),
                ),
                actionsAlignment: MainAxisAlignment.center,
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
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Batal',
                        style: bluetogreenTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                    ),
                  ),
                  CustomFilledButton(
                    bgcolor: bluetogreenColor,
                    width: 100,
                    height: 40,
                    title: 'Yakin',
                    textColor: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 14,
                      letterSpacing: 0.5,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      // Lakukan aksi yang diperlukan ketika "Yakin" ditekan.
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return canPop;
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Code : ',
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                    ),
                    TextSpan(
                      text: '09876545678',
                      style: bluetogreenTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                    ),
                  ])),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFFFF4DB),
                    ),
                    child: Center(
                      child: Text(
                        "Belum Dibayar",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFDDA700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Table(
                columnWidths: {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(
                  color: Colors.transparent,
                ),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          textAlign: TextAlign.justify,
                          'Nama',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          textAlign: TextAlign.center,
                          ':',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        name,
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          textAlign: TextAlign.justify,
                          'Tanggal Pembelian',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          textAlign: TextAlign.center,
                          ':',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        currentDate,
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          textAlign: TextAlign.justify,
                          'Alamat',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          textAlign: TextAlign.center,
                          ':',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        alamat,
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                  ]),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Table(
                  columnWidths: {
                  },
                  border: TableBorder.all(
                    color: blackColor,
                  ),
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Color(0xFFEAF3F4)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                textAlign: TextAlign.center,
                                'Produk',
                                style: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                textAlign: TextAlign.center,
                                'Harga',
                                style: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: bold)),
                          ),
                        ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(namaPaket,
                            textAlign: TextAlign.center,
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            textAlign: TextAlign.center,
                            NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(hargaPaket),
                            style: bluetogreenTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular)),
                      ),
                    ]),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Total Tagihan',
                            textAlign: TextAlign.center,
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            textAlign: TextAlign.center,
                            NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(hargaPaket),
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: bluetogreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(
                    () {
                      isLoading = true;
                    },
                  );
                  Future.delayed(
                    Duration(seconds: 1),
                    () {
                      setState(
                        () {
                          isLoading = false;
                        },
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AkadPage(),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: whiteColor,
                        )
                      : Text(
                          'Lanjutkan',
                          style: blackTextStyle.copyWith(
                            fontWeight: bold,
                            fontSize: 14,
                            letterSpacing: 0.5,
                            color: whiteColor,
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
