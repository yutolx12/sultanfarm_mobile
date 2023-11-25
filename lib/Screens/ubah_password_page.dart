// ignore_for_file: unused_import

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Screens/sign_in_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:sultan_farm_mobile/Widgets/custom_textformfield.dart';
import 'package:http/http.dart' as http;

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isChekced = false;
  List<String> privacy = [];
  bool isLoading = false;
  var idString = '';
  int id = 0;
  late SharedPreferences s_prefs;

  // var s_prefs;

  // final namaController = TextEditingController();
  // final emailController = TextEditingController();
  final passwordLamaController = TextEditingController();
  final passwordBaruController = TextEditingController();
  final konfirmasiPasswordBaruController = TextEditingController();
  // final konfirmasiController = TextEditingController();

  updatePassword() async {
    setState(() {
      isLoading = true;
      sendData();
    });
    // if (await sendData()) {
    //   isLoading = false;
    //   _showSnackBarAndNavigateToLogin();

    //   // _showSnackBarAndNavigateToLogin();
    // }
  }

  Future<void> sendData() async {
    // Simulasi cek database
    // Ganti bagian ini dengan logika pengecekan yang sesuai
    // late SharedPreferences s_prefs;
    s_prefs = await SharedPreferences.getInstance();
    var email = s_prefs.getString("email").toString();
    // id = int.parse(idString);
    // final url = 'http://192.168.100.4:8000/api/updatePassword';
    // final res = await http.post(Uri.parse(url), body: {
    //   "email": email,
    //   "old_password": passwordLamaController.text,
    //   "password": passwordBaruController.text
    // });
    // final hasil = jsonDecode(res.body);

    try {
      var response = await http.post(Uri.parse(ApiConnect.updatePassword), body: {
        "email": email,
        "old_password": passwordLamaController.text,
        "password": passwordBaruController.text
      });

      if (response.statusCode == 200) {
        isLoading = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        prefs.remove('id');
        prefs.remove('nama');
        prefs.remove('nomor');
        prefs.remove('alamat');
        prefs.remove('email');
        prefs.remove('jenis_kelamin');
        _showSnackBarAndNavigateToLogin();
      } else {
        setState(() {
          isLoading = false;
          _showSnackBar(
              'Ubah password gagal, pastikan password lama benar dan smartphone terhubung ke internet');
        });
      }
    } catch (e) {
      rethrow;
    }

    
  }

  void _updateCheckboxStatus(bool value) {
    setState(() {
      _isChekced = value;
    });
  }


  
  void _showSnackBarAndNavigateToLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: SizedBox(
          height: 40,
          child: Center(
            child: Text(
              "Ubah Password Berhasil!",
              style: whitekTextStyle.copyWith(fontWeight: medium, fontSize: 18),
            ),
          ),
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
        backgroundColor: Colors.red[400],
        content: SizedBox(
            height: 80,
            child: Center(
                child: Text(
              message,
              textAlign: TextAlign.center,
              style: whitekTextStyle.copyWith(fontWeight: medium, fontSize: 18),
            ))),
        duration: const Duration(seconds: 3),
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
                "Apakah anda yakin ingin merubah password akun anda?",
                style: blackTextStyle.copyWith(fontWeight: extraBold),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateCheckboxStatus(true);
                    updatePassword(); // Menutup AlertDialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff228896),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Saya Yakin',
                    style: whitekTextStyle.copyWith(fontWeight: bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _updateCheckboxStatus(false); // Menutup AlertDialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Batal',
                    style: whitekTextStyle.copyWith(fontWeight: bold),
                  ),
                ),
              ],
              content: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Peringatan: Password anda akan diperbarui dan anda akan keluar dari akun saat ini.",
                    style: greyTextStyle,
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
        title: Text('Ubah Password',
            style: blackTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30, top: 120),
          child: SingleChildScrollView(
            //agar bisa di scroll apabila halaman kelebihan
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey, //
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Center(
                        
                        ),
                  ),
                 
                  RegisterField(
                    controller: passwordLamaController,
                    isLoading: isLoading,
                    prefixIcon: Icons.key,
                    // maxLenght: 13,
                    hint: 'Masukkan Password Lama',
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Password Lama harus diisi';
                      }
                      if (val.length < 8) {
                        return 'Minimal Password adalah 8 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  RegisterField(
                    controller: passwordBaruController,
                    isLoading: isLoading,
                    prefixIcon: Icons.key,
                    hint: 'Masukkan Password Baru',
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Password Baru harus diisi';
                      }
                      if (val.length < 8) {
                        return 'Minimal Password adalah 8 karakter';
                      }
                      return null;
                    },
                  ),
                 
                  const SizedBox(height: 20),
                  RegisterField(
                    controller: konfirmasiPasswordBaruController,
                    isLoading: isLoading,
                    prefixIcon: Icons.key,
                    hint: 'Konfirmasi password',
                    isPassword: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Kolom Konfirmasi Password harus diisi';
                      }
                      if (val != passwordBaruController.text) {
                        return 'Password dan Konfirmasi password harus sama';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            //kondisi dibawah menunjukkan bahwa, apabila klik button daftar dan belum checklist privacy. maka akan muncul showprivacy(). Jika sudah, maka pendaftaran berhasil
                            if (_formKey.currentState!.validate()) {
                              if (_isChekced) {
                                updatePassword();
                              } else {
                                showPrivacy();
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff228896),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Text('Konfirmasi',
                              style: whitekTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 20,
                              )),
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
