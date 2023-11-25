// ignore_for_file: unused_import

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Screens/navigation_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:sultan_farm_mobile/Widgets/custom_textformfield.dart';
import 'package:http/http.dart' as http;

class EditAkunPage extends StatefulWidget {
  const EditAkunPage({super.key});

  @override
  State<EditAkunPage> createState() => _EditAkunPageState();
}

class _EditAkunPageState extends State<EditAkunPage> {
  final _formKey = GlobalKey<FormState>();
  // final _dialogKey = GlobalKey<FormState>();
  // ignore: unused_field
  bool _isChekced = false;
  List<String> privacy = [];
  bool isLoading = false;
  late String nama = 'Yunanta';
  var id = '';
  var token = '';
  // var id = '';
  var name = '';
  var nomor = '';
  var alamat = '';
  var email = '';
  var jenis_kelamin = '';

  late SharedPreferences s_prefs;

  final namaController = TextEditingController();
  // final emailController = TextEditingController();
  final alamatController = TextEditingController();
  final teleponController = TextEditingController();
  final passwordController = TextEditingController();

  popUpPassoword() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Masukkan Password Untuk Edit Akun'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  RegisterField(
                    controller: passwordController,
                    isLoading: isLoading,
                    prefixIcon: Icons.key,
                    // maxLenght: 7,
                    // key: _formKey,
                    hint: 'Password',
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        // sendData();
                        updateUserData();
                        Navigator.of(context).pop();
                      });
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
                      child:
                          // isLoading
                          // ? CircularProgressIndicator()
                          // :
                          Text('Edit Akun',
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
        );
      },
    );
  }

  Future<void> updateUserData() async {
    // Simulasi cek database
    // Ganti bagian ini dengan logika pengecekan yang sesuai
    // late SharedPreferences s_prefs;
    s_prefs = await SharedPreferences.getInstance();
    var email = s_prefs.getString("email").toString();

    try {
      final response = await http.post(Uri.parse(ApiConnect.updateCustomer), body: {
        "password": passwordController.text,
        "email": email,
        "nama_customer": namaController.text,
        "alamat": alamatController.text,
        "no_telp": teleponController.text,
      });

      if (response.statusCode == 200) {
        isLoading = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String datauser = response.body;
        var hasiluser = jsonDecode(datauser);
        var nama = hasiluser["nama_customer"];
        prefs.setString('nama', nama.toString());
        var nomor = hasiluser["no_telp"];
        prefs.setString('nomor', nomor.toString());
        var alamat = hasiluser["alamat"];
        prefs.setString('alamat', alamat.toString());
        _showSnackBarAndNavigateToAkunPage();
      } else {
        setState(() {
          isLoading = false;
          _showSnackBar(
              'Edit Akun gagal, pastikan password lama benar dan smartphone terhubung ke internet');
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


  
  void _showSnackBarAndNavigateToAkunPage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: SizedBox(
          height: 40,
          child: Center(
            child: Text(
              "Edit Akun Berhasil!",
              style: whitekTextStyle.copyWith(fontWeight: medium, fontSize: 18),
            ),
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Setelah Snackbar muncul, arahkan pengguna ke halaman login
    //
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPage()),
          (route) => false);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[400],
        content: SizedBox(
            height: 90,
            child: Center(
                child: Text(
              message,
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
                "Apakah anda yakin ingin merubah data akun anda?",
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
                    "Peringatan: Data anda akan diperbarui berdasarkan input yang telah Anda masukkan.",
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

  _showSavedValue() async {
    s_prefs = await SharedPreferences.getInstance();
    setState(() {
      token = s_prefs.getString("token").toString();
      id = s_prefs.getString("id").toString();
      name = s_prefs.getString("nama").toString();
      nomor = s_prefs.getString("nomor").toString();
      alamat = s_prefs.getString("alamat").toString();
      email = s_prefs.getString("email").toString();
      jenis_kelamin = s_prefs.getString("jenis_kelamin").toString();
      namaController.text = name;
      alamatController.text = alamat;
      teleponController.text = nomor;
    });
  }


  @override
  void initState() {
    setState(() {
      _showSavedValue();

      // getCurrentName(name);
      // name = name;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text('Edit Akun',
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
                      if (val.length <= 11) {
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
                  
                  const SizedBox(height: 20),
                  
                  const SizedBox(height: 10),
                  
                  ElevatedButton(
                    onPressed: () {
                      //kondisi dibawah menunjukkan bahwa, apabila klik button daftar dan belum checklist privacy. maka akan muncul showprivacy(). Jika sudah, maka pendaftaran berhasil
                      if (_formKey.currentState!.validate()) {
                        popUpPassoword();
                    
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
