// ignore_for_file: unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:login_register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Screens/navigation_page.dart';
import 'package:sultan_farm_mobile/Screens/sign_up_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Screens/onboarding_page.dart';
// import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:sultan_farm_mobile/Widgets/custom_textformfield.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  // ignore: unused_field
  // bool _isLoading = false;
  // var errorMsg = null;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    setState(() {
      isLoading = true;
    });

    // if (await _isAccountNotRegisteredYet()) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   _showSnackBar("Akun belum terdaftar.");
    // } else {
    var keyLogin = '1';
    // final url = 'http://192.168.1.41:8000/api/login_customer';
    // ignore: unused_local_variable
    // final res = await http.post(Uri.parse(url), body: {
    //   "email": emailController.text,
    //   "password": passwordController.text,
    // });
    try {
      final res = await http.post(Uri.parse(ApiConnect.login), body: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      if (res.statusCode == 200) {
       
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
       
        String datauser = res.body;
        var hasiluser = jsonDecode(datauser);
        // sharedPreferences.setString('userdata', hasiluser.toString());
        var token = hasiluser["token"];
        sharedPreferences.setString('token', token.toString());
        var id = hasiluser["id"];
        sharedPreferences.setString('id', id.toString());
        var nama = hasiluser["nama_customer"];
        sharedPreferences.setString('nama', nama.toString());
        var nomor = hasiluser["no_telp"];
        sharedPreferences.setString('nomor', nomor.toString());
        var alamat = hasiluser["alamat"];
        sharedPreferences.setString('alamat', alamat.toString());
        var email = hasiluser["email"];
        sharedPreferences.setString('email', email.toString());
        var jenis_kelamin = hasiluser["jenis_kelamin"];
        sharedPreferences.setString('jenis_kelamin', jenis_kelamin.toString());
        sharedPreferences.setString('keyLogin', keyLogin);

       
        setState(() {
          isLoading = false;
        });
        // _showSnackBarAndNavigateToLogin();
        _showSnackBarAndNavigateToLogin("Login berhasil");
      }

      if (res.statusCode == 401) {
        setState(() {
          isLoading = false;
          _showSnackBar('Password Yang Anda Masukkan Salah');
        });
      }
      if (res.statusCode == 400) {
       
        setState(() {
          isLoading = false;
          _showSnackBar(
              'Login gagal, email tidak terdaftar');
        });
      }
    } catch (e) {
      
      rethrow;
    }

    
  }

  Future<bool> _isAccountNotRegisteredYet() async {
    // Simulasi cek database
    // Ganti bagian ini dengan logika pengecekan yang sesuai
    final res = await http.post(Uri.parse(ApiConnect.login), body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
    final hasil = json.decode(json.encode(res.body));

    String hasilhasil = hasil.toString();
    if (hasilhasil.contains('id')) {
      return false;
    } else {
      return true;
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
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Setelah Snackbar muncul, arahkan pengguna ke halaman login
    Future.delayed(const Duration(seconds: 1), () {
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   '/navigation-page',
      //   (route) => false,
      // );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPage()),
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
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text('LOGIN',
              style: bluetogreenTextStyle.copyWith(
                  fontSize: 25, fontWeight: FontWeight.bold)),
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
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                                height: 130,
                                width: 150,
                                child: Image.asset(
                                  'assets/logosultanfarm.png',
                                  fit: BoxFit.contain,
                                )),
                            const SizedBox(height: 20),
                            Text('Login dengan akun yang terdaftar',
                                style: blackTextStyle.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
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
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                            login();
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
                            : Text('Masuk',
                                style: whitekTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 17,
                                )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Belum memiliki akun?', style: blackTextStyle),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                  (route) => false);
                            },
                            child: Text('Daftar',
                                style: bluetogreenTextStyle.copyWith(
                                    fontWeight: bold))),
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
