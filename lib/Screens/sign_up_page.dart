// ignore_for_file: unused_import
// import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/RegisterModel.dart';
import 'package:sultan_farm_mobile/Screens/sign_in_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:sultan_farm_mobile/Widgets/custom_textformfield.dart';
import 'package:http/http.dart' as http;
// import 'package:sultan_farm_mobile/libs/http.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChekced = false;
  List<String> privacy = [];
  bool isLoading = false;

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  register() async {
    setState(() {
      isLoading = true;
    });

    if (await _isAccountAlreadyRegistered()) {
      setState(() {
        isLoading = false;
      });
      _showSnackBar("Akun sudah terdaftar.");
    } else {
      try {
        // ignore: unused_local_variable
        final res = await http.post(Uri.parse(ApiConnect.register), body: {
          "nama_customer": namaController.text,
          "email": emailController.text,
          "no_telp": teleponController.text,
          "alamat": alamatController.text,
          "password": passwordController.text,
        });
      } catch (e) {
        
      }

      setState(() {
        isLoading = false;
      });
      // _showSnackBarAndNavigateToLogin();
      _showSnackBarAndNavigateToLogin("Pendaftaran berhasil");
    }
  }

  void _updateCheckboxStatus(bool value) {
    setState(() {
      _isChekced = value;
    });
  }

  Future<bool> _isAccountAlreadyRegistered() async {
    // Simulasi cek database
    // Ganti bagian ini dengan logika pengecekan yang sesuai
    final res = await http.post(Uri.parse(ApiConnect.checkEmail),
        body: {'email': emailController.text});
    final hasil = jsonDecode(res.body);


    if (!hasil['success']) {
      return true;
    } else {
      return false;
    }
  }

  void _showSnackBarAndNavigateToLogin(String message) {
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
        duration: const Duration(seconds: 2),
      ),
    );

    // Setelah Snackbar muncul, arahkan pengguna ke halaman login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
          (route) => false);
    });
  }

  void _showSnackBar(String message) {
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
      ),
    );
  }

  //showprivacy ini digunakan untuk menampilkan modal dialog untuk syarat dan kebijakan
  Future<void> showPrivacy() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Syarat, Ketentuan & Kebijakan",
                textAlign: TextAlign.left,
                style: blackTextStyle.copyWith(fontWeight: extraBold),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateCheckboxStatus(true); // Menutup AlertDialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluetogreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Saya Setuju',
                    style: whitekTextStyle.copyWith(fontWeight: bold),
                  ),
                ),
              ],
              content: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang di Aplikasi SultanFarm. Syarat dan Ketentuan Penggunaan ini ("Perjanjian") mengatur penggunaan aplikasi ini dan layanan yang disediakan oleh kami. Dengan mengunduh, mengakses, atau menggunakan aplikasi ini, Anda menyetujui sepenuhnya dan tunduk pada syarat dan ketentuan yang tercantum di bawah ini. Harap baca dengan seksama dan pahami syarat-syarat ini sebelum melanjutkan. Jika Anda tidak menyetujui syarat-syarat ini, Anda tidak diperkenankan menggunakan aplikasi ini.',
                        textAlign: TextAlign.left,
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Ketentuan Penggunaan',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(fontWeight: bold),
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
                                    textAlign: TextAlign.left,
                                    '1.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Penggunaan Aplikasi: Anda diizinkan untuk menggunakan aplikasi ini hanya untuk tujuan yang sah, seperti menjelajahi informasi tentang domba breeding, berinvestasi, dan mengelola aktivitas breeding Anda. Anda tidak diperkenankan menggunakan aplikasi ini untuk tujuan ilegal atau melanggar hukum yang berlaku.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '2.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                ' Pendaftaran Akun: Untuk mengakses fitur-fitur tertentu dalam aplikasi ini, Anda mungkin diminta untuk mendaftarkan akun. Anda bertanggung jawab atas informasi yang Anda berikan selama proses pendaftaran, dan Anda harus menjaga kerahasiaan kata sandi Anda.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '3.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Konten Pengguna: Anda bertanggung jawab penuh atas konten yang Anda unggah atau bagikan melalui aplikasi ini. Konten yang melanggar hukum atau menyinggung norma-norma etika akan dilarang. Kami berhak untuk menghapus konten yang melanggar ketentuan ini.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '4.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Hak Kekayaan Intelektual: Aplikasi ini dan semua kontennya, termasuk namun tidak terbatas pada teks, gambar, audio, dan video, dilindungi oleh hak cipta dan hak kekayaan intelektual lainnya. Anda tidak diperkenankan mendistribusikan, mereproduksi, atau menggunakan konten dalam aplikasi ini tanpa izin tertulis dari pemiliknya.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '5.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Investasi dan Keputusan Keuangan: Anda harus menyadari bahwa investasi dalam breeding domba melibatkan risiko. Keputusan keuangan yang Anda buat adalah tanggung jawab Anda sendiri. Kami tidak memberikan jaminan atas hasil investasi atau keuntungan.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '6.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Penutupan Akun: Kami berhak untuk menutup akun pengguna yang melanggar syarat dan ketentuan ini atau melibatkan diri dalam perilaku yang melanggar hukum atau melanggar etika.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    '7.',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 14, fontWeight: regular)),
                              ),
                              Text(
                                'Perubahan pada Syarat dan Ketentuan: Kami berhak untuk mengubah syarat dan ketentuan ini kapan saja. Perubahan tersebut akan diberlakukan setelah diterbitkan dalam aplikasi ini. Anda diwajibkan untuk memeriksa syarat dan ketentuan ini secara berkala.',
                                textAlign: TextAlign.left,
                                style: blackTextStyle.copyWith(
                                    fontWeight: regular, fontSize: 14),
                              )
                            ]),
                          ]),
                      const SizedBox(height: 10),
                      Text(
                        'Kontak Kami',
                        textAlign: TextAlign.left,
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Jika Anda memiliki pertanyaan atau komentar tentang syarat dan ketentuan ini, silakan hubungi kami melalui developer.sultanfarm@gmail.com. \n\nTerima kasih telah menggunakan Aplikasi SultanFarm. Kami berharap Anda mendapatkan manfaat yang maksimal dari penggunaan aplikasi ini.',
                        textAlign: TextAlign.left,
                        style: greyTextStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        appBar: AppBar(
          title: Text('REGISTER',
              style: bluetogreenTextStyle.copyWith(
                  fontSize: 25, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: SingleChildScrollView(
              //agar bisa di scroll apabila halaman kelebihan
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey, //
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 130,
                                width: 150,
                                child: Image.asset(
                                  'assets/logosultanfarm.png',
                                  fit: BoxFit.contain,
                                )),
                            const SizedBox(height: 20),
                            Text('Isi dengan data yang valid',
                                style: blackTextStyle.copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    RegisterField(
                      //ini merupakan widget yang textformfield yang diambil dari Widgets/textformfield, pada folder tersebut bisa di custom widgetnya
                      controller: namaController,
                      isLoading: isLoading,
                      hint: 'Masukkan Nama',
                      prefixIcon: Icons.account_circle,
                      validator: (val) {
                        //validator untuk memunculkan alert pada bawah textfield jika yg diinputkan tidak sesuai dengan validasi yang tertera
                        if (val == null || val.isEmpty) {
                          return 'Kolom Nama harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    RegisterField(
                        controller: emailController,
                        isLoading: isLoading,
                        keyType: TextInputType.emailAddress,
                        hint: 'Masukkan E-mail',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Kolom E-mail harus diisi';
                          }
                          if (!val.contains('@')) {
                            return 'E-mail tidak valid';
                          }
                          return null;
                        },
                        prefixIcon: Icons.mail),
                    const SizedBox(
                      height: 20,
                    ),
                    RegisterField(
                      controller: teleponController,
                      isLoading: isLoading,
                      prefixIcon: Icons.phone,
                      keyType: TextInputType.phone,
                      maxLenght: 13,
                      hint: 'Masukkan nomor telepon',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Kolom No. Telepon harus diisi';
                        }
                        if (val.length <= 10) {
                          return 'Nomor telepon tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    RegisterField(
                      controller: alamatController,
                      isLoading: isLoading,
                      prefixIcon: Icons.add_location_rounded,
                      hint: 'Masukkan Alamat',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Kolom Alamat harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    RegisterField(
                      controller: passwordController,
                      isLoading: isLoading,
                      prefixIcon: Icons.key,
                      hint: 'Masukkan password',
                      isPassword: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Kolom Password harus diisi';
                        }
                        if (val.length < 8) {
                          return 'Password harus 8 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    RegisterField(
                      controller: konfirmasiController,
                      isLoading: isLoading,
                      prefixIcon: Icons.key,
                      hint: 'Konfirmasi password',
                      isPassword: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Kolom Konfirmasi Password harus diisi';
                        }
                        if (val != passwordController.text) {
                          return 'Password dan Konfirmasi password harus sama';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChekced,
                          onChanged: (value) {
                            setState(() {
                              _isChekced = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Wrap(
                            spacing: 2,
                            children: [
                              Text(
                                'Saya menyetujui',
                                style: blackTextStyle.copyWith(fontSize: 14),
                              ),
                              InkWell(
                                child: Text('Syarat, Ketentuan & Kebijakan',
                                    style: bluetogreenTextStyle.copyWith(
                                        fontWeight: bold, fontSize: 15)),
                                onTap: () => showPrivacy(),
                              ),
                              Text(
                                'yang berlaku',
                                style: blackTextStyle.copyWith(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              //kondisi dibawah menunjukkan bahwa, apabila klik button daftar dan belum checklist privacy. maka akan muncul showprivacy(). Jika sudah, maka pendaftaran berhasil
                              if (_formKey.currentState!.validate()) {
                                if (_isChekced) {
                                  register();
                                } else {
                                  showPrivacy();
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: bluetogreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: whiteColor,
                              )
                            : Text('Daftar',
                                style: whitekTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 17,
                                )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sudah memiliki akun?', style: blackTextStyle),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignInPage()),
                                  (route) => false);
                            },
                            child: Text('Masuk',
                                style: bluetogreenTextStyle.copyWith(
                                    fontWeight: bold)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
