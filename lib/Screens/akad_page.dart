// ignore_for_file: unnecessary_null_comparison, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Screens/pembayaran_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class AkadPage extends StatefulWidget {
  const AkadPage({super.key});

  @override
  State<AkadPage> createState() => _AkadPageState();
}

class _AkadPageState extends State<AkadPage> {
  late Record audioRecord;
  late Timer recordingTimer;
  late AudioPlayer audioPlayer;
  late SharedPreferences prefs;
  late SharedPreferences pref;
  late String namaPaket = ''; // Deklarasikan sebagai variabel kelas
  bool isRecording = false;
  bool isLoading = false;
  String audioPath = '';
  Duration currentDuration = const Duration(seconds: 0);
  var name = '';

  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("nama").toString();
    });
  }

  Future<void> getDataPaket() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      namaPaket = pref.getString('TransaksiNamaPaket').toString();
    });
  }

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    recordingTimer = Timer(const Duration(seconds: 0), () {});
    super.initState();
    getDataPaket();
    getDataAkun();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    recordingTimer.cancel();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
        recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (!isRecording) {
            timer.cancel(); // Cancel the timer if recording is stopped
          } else {
            setState(() {
              currentDuration = currentDuration + const Duration(seconds: 1);
            });
          }
        });
      }
    } catch (e) {}
  }

  Future<void> stopRecording() async {
    try {
      if (isRecording) {
        recordingTimer.cancel(); // Cancel the timer before stopping recording
        String? path = await audioRecord.stop();
        setState(() {
          isRecording = false;
          audioPath = path!;
        });
      }
    } catch (e) {}
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {}
  }

  Future<void> resetRecording() async {
    if (isRecording) {
      stopRecording();
      await startRecording();
    }
    setState(() {
      currentDuration = const Duration(seconds: 0);
      audioPath = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            'Akad',
            style: greyTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 14,
              letterSpacing: 0.1,
            ),
          ),
          centerTitle: false,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (audioPath.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Jika anda kembali, Rekaman akan Terhapus",
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
                                resetRecording();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
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
                  }
                },
              );
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (audioPath.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Jika anda kembali, Rekaman akan Terhapus",
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
                          resetRecording();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Apakah anda Yakin ingin kembali ?",
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
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Untuk melanjutkan transaksi, silahkan untuk mengucapkan akad sesuai teks dibawah berikut. Agar transaksi tetap berjalan sesuai syariat agama islam yang berlaku',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                      letterSpacing: 0.1,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: greyColor,
                          blurRadius: 0.1,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Saya $name secara sadar menerima penawaran ini dari penjual dan bersedia untuk membeli atau berinvestasi domba di sultan farm dengan jenis $namaPaket dengan harga yang telah disepakati. Saya memahami bahwa domba breeding tersebut memiliki catatan kesehatan yang baik dan telah diberi perawatan dengan baik.',
                            style: blackTextStyle.copyWith(
                              fontSize: 17,
                              fontWeight: bold,
                              letterSpacing: 0.1,
                            ),
                            // maxLines: 7,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () {
                              if (isRecording) {
                                stopRecording();
                              } else {
                                if (audioPath.isNotEmpty) {
                                  // Tampilkan AlertDialog untuk konfirmasi hanya jika ada rekaman
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actionsPadding:
                                            const EdgeInsets.all(20),
                                        title: Text(
                                          'Untuk Mererekam kembali klik Ulangi',
                                          textAlign: TextAlign.center,
                                          style: blackTextStyle.copyWith(
                                              fontSize: 15,
                                              fontWeight: regular),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: <Widget>[
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
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  startRecording();
                                }
                              }
                            },
                            child: isRecording
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundColor: bluetogreenColor,
                                    child: Icon(
                                      Icons.stop,
                                      color: whiteColor,
                                      size: 60,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundColor: audioPath.isNotEmpty
                                        ? bluetogreenColor
                                        : neutral95Color,
                                    child: Icon(
                                      isRecording ? Icons.stop : Icons.mic_none,
                                      color: isRecording
                                          ? dark50Color
                                          : whiteColor,
                                      size: 60,
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            currentDuration.toString().split('.').first,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                              letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (!isRecording && audioPath != null)
                                Material(
                                  color: primary99Color,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: playRecording,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.headphones,
                                              color: primary40Color,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'Dengarkan',
                                              style: blackTextStyle.copyWith(
                                                fontWeight: bold,
                                                fontSize: 14,
                                                letterSpacing: 0.5,
                                                color: primary40Color,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Material(
                                color: Colors.transparent,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          primary40Color, // Warna garis pinggir
                                      width: 1.0, // Lebar garis pinggir
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: resetRecording,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.replay_outlined,
                                              color: primary40Color,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'Ulangi',
                                              style: blackTextStyle.copyWith(
                                                fontWeight: bold,
                                                fontSize: 14,
                                                letterSpacing: 0.5,
                                                color: primary40Color,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: bluetogreenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 1), () async {
                        setState(() {
                          isLoading = false;
                        });
                        if (audioPath.isNotEmpty) {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'lokasi_audio', audioPath);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PembayaranPage()));
                          stopRecording();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: danger99Color,
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: danger40Color,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Upload Bukti Rekaman jika ingin melanjutkan',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: medium),
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      });
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
                              'Kirim',
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
        ),
      ),
    );
  }
}
