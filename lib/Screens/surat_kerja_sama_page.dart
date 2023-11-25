// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Screens/invoice_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:intl/intl.dart';

class SuratKerjaSama extends StatefulWidget {
  const SuratKerjaSama({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<SuratKerjaSama> {
  bool _isChecked = false;
  var name = '';
  var alamat = '';
  late String namaPaket = ''; // Deklarasikan sebagai variabel kelas
  late int hargaPaket = 0; // Deklarasikan sebagai variabel kelas
  late SharedPreferences prefs;
  late SharedPreferences pref;
  bool isLoading = false;
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
    getDataAkun();
    getDataPaket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Surat Perjanjian Kerja Sama',
          style: greyTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 14,
            letterSpacing: 0.1,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Apakah anda Yakin ingin Membatalkan Transaksi ?",
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
                });
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       Icons.shopping_cart,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       // Add your cart icon's onPressed logic here
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const KeranjangPage()));
        //     },
        //   ),
        // ],
      ),
      body: WillPopScope(
        onWillPop: () async => await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Apakah anda Yakin ingin Membatalkan Transaksi ?",
                textAlign: TextAlign.center,
                style:
                    blackTextStyle.copyWith(fontSize: 15, fontWeight: regular),
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
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text('Surat Perjanjian',
                    style: blackTextStyle.copyWith(
                        fontWeight: bold, fontSize: 20)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                },
                children: [
                  TableRow(
                    children: [
                      RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Perjanjian Kerja Sama ini dibuat hari ini ',
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: DateFormat('EEEE', 'id_ID')
                                    .format(DateTime.now()),
                                style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: '\ttanggal ',
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: DateFormat('d').format(DateTime.now()),
                                style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: '\tbulan ',
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: DateFormat('MMMM', 'id_ID')
                                    .format(DateTime.now()),
                                style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: '\ttahun ',
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: DateFormat('y').format(DateTime.now()),
                                style: blackTextStyle.copyWith(
                                    fontWeight: semiBold,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                            TextSpan(
                                text: '.\tOleh dan antara :',
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular,
                                    fontSize: 11,
                                    letterSpacing: 0.1)),
                          ])),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(
                  color: Colors.transparent,
                ),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text:
                              'CV.Sultan Farm Jember, yang dalam hal ini diwakili oleh ',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 11)),
                      TextSpan(
                          text: 'Januar Adie Chandra, S.P, MM ',
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 11)),
                      TextSpan(
                          text:
                              'dalam kapasitasnya selaku Pengelola CV. Sultan Farm Jember, dan karenanya berhak dan sah bertindak untuk dan atas nama CV. Sultan Farm Jember, dan untuk selanjutnya disebut ',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 11)),
                      TextSpan(
                          text: 'PIHAK PERTAMA',
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 11)),
                    ])),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: name,
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 11)),
                      TextSpan(
                          text: '\tberkedudukan di\t',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 11)),
                      TextSpan(
                          text: alamat,
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 11)),
                      TextSpan(
                          text:
                              '\tyang dalam hal ini kapasitasnya sebagai Mitra/Investor dan karenanya berhak dan sah bertindak untuk dan atas nama dirinya sendiri, selanjutnya disebut Mitra Peternak, dan untuk selanjutnya disebut ',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 11)),
                      TextSpan(
                          text: 'PIHAK KEDUA',
                          style: blackTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 11)),
                    ])),
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('Pasal 1\nLingkup Kerjasama',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(
                  color: Colors.transparent,
                ),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama adalah pengelola usaha peternakan domba',
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Kedua adalah masyarakat atau individu, mitra yang ber investasi dalam bidang breeding kambing/domba atau memiliki dana yang diserahkan pengelolaannya kepada Pihak Pertama baik secara individu maupun kelompok',
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '3.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama dan Pihak Kedua bermaksud mengadakan kerjasama untuk usaha peternakan breeding domba',
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '4.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama akan menerima dan mengelola dengan baik investasi paket breeding kambidari Pihak Kedua',
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '5.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pada saat ditandatanganinya perjanjian kerjasama ini, Pihak Kedua menguasakan pembelian/pengadaan dan menyerahkan kambing/domba untuk dikelola oleh CV. Sultan Farm Jember sebagai berikut :',
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: IntrinsicColumnWidth(),
                  // 3:IntrinsicColumnWidth(),
                },
                border: TableBorder.all(
                  color: Colors.transparent,
                ),
                children: [
                  // TableRow(children: [
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: 20, right: 10),
                  //     child: Text(
                  //         textAlign: TextAlign.center,
                  //         'a)',
                  //         style: blackTextStyle.copyWith(
                  //             fontSize: 14, fontWeight: regular)),
                  //   ),
                  //   Text(
                  //       textAlign: TextAlign.justify,
                  //       'Jumlah Kambing/Domba',
                  //       style: blackTextStyle.copyWith(
                  //           fontSize: 14, fontWeight: regular)),
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     child: Text(
                  //         textAlign: TextAlign.center,
                  //         ':',
                  //         style: blackTextStyle.copyWith(
                  //             fontSize: 14, fontWeight: regular)),
                  //   ),
                  //   Text(
                  //       textAlign: TextAlign.justify,
                  //       'Jantan 1 ekor, Betina 11 ekor',
                  //       style: blackTextStyle.copyWith(
                  //           fontSize: 14, fontWeight: regular)),
                  // ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          'a)',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        'Jenis',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          ':',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        'Domba Dormas Krosing',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          'b)',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        'Pilihan paket kemitraan',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          ':',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        namaPaket,
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          'c)',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        'Total Investasi',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          textAlign: TextAlign.center,
                          ':',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp ',
                                decimalDigits: 0)
                            .format(hargaPaket),
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: regular)),
                  ]),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Pasal 2\nPelaksanaan',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(
                  color: Colors.transparent,
                ),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Kedua menyerahan/ berinvestasi untuk dikelola di kandang Pihak Pertama sebagaimana tersebut dalam pasal 1 ayat 5 dalam kondisi sehat dan baik di kandang CV. Sultan Farm Jember',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama menerima sebagaimana pada Pasal 2 ayat 1, kondisi kambing/Domba dan memastikan bahwa ternak dalam kondisi sehat dan baik',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '3.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Kerjasama ini menggunakan pola bagi hasil (mudharabah) dengan nisbah pembagian keuntungan sebagai berikut :',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          'a)',
                          textAlign: TextAlign.justify,
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Bagi hasil dari penjualan cempe (anak kambing usia 3 bulan) pada saat dijual 50% untuk Pihak Kedua dan 50% untuk Pihak Pertama.Dengan ketentuan harga untuk Paket Medium Rp.800.000 (Delapan Ratus Ribu Rupiah) per ekor',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          'b)',
                          textAlign: TextAlign.justify,
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Bagi hasil dari keuntungan penjualan induk pada saat dijual 50% untuk Pihak Kedua dan 50% untuk Pihak Pertama',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          'c)',
                          textAlign: TextAlign.justify,
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Kerugian penjualan indukan disaat berahirnya masa investasi, maka pihak pertama wajib mengembalikan sesuai harga nominal investasi diawal',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          'd)',
                          textAlign: TextAlign.justify,
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Pemutusan kerja sama/ investasi minimal di saat indukan melahirkan anakan ke 1',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '4.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Apabila dalam kerjasama ini terjadi risiko kerugian yang disebabkan karena kehilangan dan atau kematian, maka kerugian tersebut akan ditanggung sepenuhnya oleh Pihak Pertama yaitu :',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          '=>',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Kehilangan di ganti 100%',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          '=>',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Kematian kelalaian pihak pertama 60%',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 5, left: 20),
                        child: Text(
                          '=>',
                          style: blackTextStyle.copyWith(
                              fontWeight: regular, fontSize: 14),
                        )),
                    Text(
                      'Wabah musibah penyakit 0%',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('Pasal 3\nKewajiban Para Pihak',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama berkewajiban menyediakan kandang, pemberian pakan dan pemeliharaan ternak dengan baik',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama berkewajiban menjaga keamanan dan kesehatan ternak, terkecuali akibat bencana alam dan wabah penyakit',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '3.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama berkewajiban menyampaikan laporan perkembangan ternak kepada Pihak Kedua setiap 6 (enam) bulan sekali',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '4.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama berkewajiban untuk memberitahukan dan minta ijin rencana penjualan ternak melalui Telp/Wa/SMS, Email atau Faximile minial 1bulan sebelumnya',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '5.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak pertama mengganti 100% bila mana ada khilangan domba paket',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '6.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak pertama mengganti 60% bilamana ada kematian domba paket yang disebabkan kelalaian',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('Pasal 4\nHak Para Pihak',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Kedua berhak untuk melihat / berkunjung kePeternakan, memberi masukan/saran yang membangun',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama berhak untuk melakukan pengelolaan kambing yang diserahkan oleh pemilik kambing, mulai dari pengelolaan kandang, pemberian pakan, pemeliharaan kesehatan sampai dengan penjualan hasilnya sesuai dengan manajemen CV. Sultan Farm Jember',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '3.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak Pertama berhak mengusulkan penjualan atau mengembalikan ternak kepada Pihak Kedua atas pertimbangan ekonomis Peternakan',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('Pasal 5\nWaktu, Cara Panen dan Pembayaran',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Panen atau penjualan cempe (anak kambing) akan dilakukan setelahmasa pemeliharaan/pembesaran maksimal 3-4 bulan',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Penjualan induk kabmbing akan dilakukan berdasarkan pertimbangan nilai ekonomis yang menguntungkan kedua belah pihak',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '3.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Waktu pelaksanaan panen atau penjualan akan dikoordinasikan terlebih dahulu antara Pihak Pertama dengan Pihak Kedua',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '4.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Untuk penentuan harga penjualan kambing dan anak kambing sudah ditentukan di pasal 3 poin 2a',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '5.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pembayaran oleh Pihak Pertama kepada Pihak Kedua akan dilakukan 3 (tiga) hari setelah penjualan ternak melalui tunai atau transfer ke rekening Bank Pihak Kedua',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('Pasal 6\nJangka Waktu Perjanjian',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '1.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Waktu Kerjasama ini berlangsung 1 (satu) tahun atau 2x kelahiran terhitung setelah perjanjian ini ditandatangani, dan diperpanjang secara otomatis apabila tidak ada permintaan diakhirinya kemitraan dari Pihak Kedua',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '2.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Perjanjian kerjasama dapat diakhiri sebelum jangka waktunya atau atas permintaan dari salah satu pihak minimal disaat kelahiran ke 1',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          '3.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Pihak kedua wajib membayar 15% dari total investsiapabila mengahiri kerja sama sebelum kelahiran anak ke 1 domba breeding',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text('Pasal 7\nLain-lain',
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(
                        fontSize: 17, fontWeight: semiBold)),
              ),
              const SizedBox(height: 10),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(color: Colors.transparent),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          'a.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Apabila terjadi perselisihan antara kedua belah pihak akibat dari pelaksanaan Perjanjian ini, maka para pihak akan menyelesaikan secara musyawarah untuk mufakat',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                          textAlign: TextAlign.justify,
                          'b.',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular)),
                    ),
                    Text(
                      'Apabila pihak 1 meninggal dunia sebelum jatuh tempo pembagian hasil, maka secara asset domba sesuaidengan blok/kamar kerja sama akan di ambil dan diberikan kepada pihak ke 2 melalui ahliwaris keluarga pihak ke 1(istri dn atau keluarga) dengan menunjukan surat kerja sama ini',
                      textAlign: TextAlign.justify,
                      style: blackTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Text('Setujui Surat Perjanjian Kerja Sama',
                      style: blackTextStyle.copyWith(
                          fontWeight: semiBold, fontSize: 15)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      isLoading = false;
                    });
                    if (_isChecked) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => invoice()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            contentPadding: const EdgeInsets.all(20),
                            actionsPadding: const EdgeInsets.all(20),
                            content: Text(
                              textAlign: TextAlign.center,
                              'Anda harus menyetujui Surat Perjanjian Kerja Sama',
                              style: blackTextStyle.copyWith(
                                  fontWeight: regular, fontSize: 20),
                            ),
                            actions: [
                              CustomFilledButton(
                                bgcolor: bluetogreenColor,
                                width: 100,
                                height: 40,
                                title: 'Oke',
                                textColor: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  color: whiteColor,
                                ),
                                onPressed: () {
                                  // Lakukan aksi yang diperlukan ketika "Oke" ditekan.
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: bluetogreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: whiteColor,
                        )
                      : const Text(
                          'Lanjutkan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
