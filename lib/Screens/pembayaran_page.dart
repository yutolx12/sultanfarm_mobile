// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Screens/navigation_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  File? _selectedImage;
  bool isLoading = false;
  int totalHarga = 0;
  late SharedPreferences prefs;
  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  getTotalharga() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      totalHarga = pref.getInt("TransaksiHargaPaket")!;
    });
  }

  Future _uploadImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> sendTransaksi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var idPaket = sharedPreferences.getString('TransaksiIdPaket');
    var idPlasma = sharedPreferences.getString('TransaksiIdPlasma');
    var idKamar = sharedPreferences.getString('TransaksiIdKamar');
    var idCustomer = sharedPreferences.getString('id');
    var lokasiAudio = sharedPreferences.getString('lokasi_audio');
    var total = sharedPreferences.getInt('TransaksiHargaPaket');

    final request =
        http.MultipartRequest('POST', Uri.parse(ApiConnect.transaksi));
    // request.fields['akad'] = lokasiAudio.toString();

    request.fields['id_paket'] = idPaket.toString();
    request.fields['total'] = total.toString();
    request.fields['id_customer'] = idCustomer.toString();
    request.fields['id_kamar'] = idKamar.toString();
    request.fields['id_plasma'] = idPlasma.toString();

    // Tambahkan gambar KK (jika sudah dipilih)
    if (_selectedImage != null) {
      final fileBuktiPembayaran = await http.MultipartFile.fromPath(
        'bukti_pembayaran',
        _selectedImage!.path,
        contentType: MediaType('image', path.extension(_selectedImage!.path)),
      );
      request.files.add(fileBuktiPembayaran);
      if (lokasiAudio != null) {
        final fileAkad = await http.MultipartFile.fromPath(
          'akad',
          lokasiAudio,
          contentType: MediaType('audio', path.extension(lokasiAudio)),
        );
        request.files.add(fileAkad);
      }
    }

    try {
      // Kirim permintaan ke backend
      final response = await request.send();
      if (response.statusCode == 200) {
        isLoading = false;
        _snackBarSuccess('Transaksi Berhasil');
      } else {
        setState(() {
          isLoading = false;
          _snackBarGagal('Transaksi Gagal');
        });
      }
    } catch (e) {
      // Tangkap kesalahan jika terjadi kesalahan selain dari respons server
    }
  }

  showConfirmationDialog() async {
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
              onPressed: () async {
                setState(() {
                  isLoading = true;
                  sendTransaksi();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _snackBarSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: primary99Color,
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: primary40Color, size: 50),
            const SizedBox(width: 20),
            Text(
              message,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Setelah Snackbar muncul, arahkan pengguna ke halaman login
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPage()),
          ((route) => false));
    });
  }

  void _snackBarGagal(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: danger99Color,
        content: Row(
          children: [
            Icon(Icons.error_outline, color: danger40Color, size: 50),
            const SizedBox(width: 20),
            Text(
              message,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getTotalharga();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            'Pembayaran',
            style: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
              letterSpacing: 0.1,
            ),
          ),
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
            return canPop;
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  children: [
                    RichText(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Lakukan pembayaran sebesar ',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                              letterSpacing: 0.1,
                            ),
                          ),
                          TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp ',
                                    decimalDigits: 0)
                                .format(totalHarga),
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                              letterSpacing: 0.1,
                            ),
                          ),
                          TextSpan(
                            text: '\tpada nomor rekening berikut:',
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '000-0000-0000-0000',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: dark50Color,
                            width: 0.5,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Masukan Bukti Pembayaran',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: regular,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            strokeAlign: BorderSide.strokeAlignInside,
                            color: primary40Color, // Warna garis pinggir
                            width: 1.0, // Lebar garis pinggir
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            _uploadImage();
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload,
                                    color: primary40Color,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Unggah File',
                                    style: blackTextStyle.copyWith(
                                      fontWeight: bold,
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                      color: primary40Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keterangan:',
                            style: blackTextStyle.copyWith(
                                fontWeight: semiBold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
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
                                      '1.',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: regular)),
                                ),
                                Text(
                                  'Bukti pembayaran harus memperlihatkan informasi yang jelas',
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
                                  'Simpan bukti pembayaran sebagai cadangan jika terjadi kesalahan dalam proses konfirmasi pesanan',
                                  textAlign: TextAlign.justify,
                                  style: blackTextStyle.copyWith(
                                      fontWeight: regular, fontSize: 14),
                                )
                              ])
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Expanded(child: SizedBox()),
                const Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
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
                          : Text(
                              'Kirim Bukti Pembayaran',
                              style: whitekTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 14,
                                  letterSpacing: 0.5),
                            ),
                    ),
                    onPressed: () {
                      // bloc.changeNavigationIndex(Navigation.akun);
                      if (_selectedImage != null) {
                        showConfirmationDialog();
                      } else {
                        // Show a Snackbar error if an image is not uploaded.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: danger99Color,
                            content: Row(
                              children: [
                                Icon(Icons.error_outline,
                                    color: danger40Color, size: 50),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Upload bukti pembayaran jika ingin melanjutkan',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: medium),
                                ),
                              ],
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
