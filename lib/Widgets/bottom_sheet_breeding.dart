// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/kamar_models.dart';
import 'package:sultan_farm_mobile/Models/plasmaModels.dart';
import 'package:sultan_farm_mobile/Screens/surat_kerja_sama_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:http/http.dart' as http;

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet(
      {super.key,
      required this.idPaket,
      required this.hargaPaket,
      required this.namaPaket});

  final int idPaket;
  final int hargaPaket;
  final String namaPaket;

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  PlasmaModels? selectedPlasma;
  int? selectedRoom;
  bool isLoading = false;

  List<kamarModels> kamarList = [];
  List<PlasmaModels> plasmaList = [];

  Future<void> dataKamarByPlasma(int idPlasma) async {
    try {
      final res = await http
          .post(Uri.parse('${ApiConnect.dataKamar}?id_plasma=$idPlasma'));
      if (res.statusCode == 200) {
        // Berhasil mendapatkan respons dari API
        final List<dynamic> data = json.decode(res.body);

        setState(() {
          kamarList = [];
        });

        for (var item in data) {
          setState(() {
            kamarList.add(kamarModels.fromJson(item));
          });
        }
        // Selanjutnya, Anda dapat memproses data sesuai kebutuhan Anda
      } else {
        // Gagal mendapatkan respons dari API, Anda dapat menangani kesalahan di sini

      }
    } catch (error) {
      // Terjadi kesalahan jaringan, Anda dapat menangani kesalahan di sini
     
    }
  }

  getDataPlasma() async {
    try {
      final res = await http.get(Uri.parse(ApiConnect.dataPlasma));
      if (res.statusCode == 200) {
        // Berhasil mendapatkan respons dari API
        final List<dynamic> data = json.decode(res.body);

        for (var item in data) {
          setState(() {
            plasmaList.add(PlasmaModels.fromJson(item));
          });
        }

        // Selanjutnya, Anda dapat memproses data sesuai kebutuhan Anda
      } else {
        // Gagal mendapatkan respons dari API, Anda dapat menangani kesalahan di sini
       
      }
    } catch (error) {
      // Terjadi kesalahan jaringan, Anda dapat menangani kesalahan di sini
      
    }
  }

  popUpFailed() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'Kamar Yang Anda Pilih Sudah Tidak Tersedia,\n\nSilahkan pilih kamar lain!',
            style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 18),
          ),
          content: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: bluetogreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: Text('OKE',
                style: whitekTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 18,
                )),
          ),
        );
      },
    );
  }

  sendData() async {
    try {
      // var StringRoom =
      var StringRoom = selectedRoom.toString();
     
      var response =
          await http.post(Uri.parse(ApiConnect.checkDataKamar), body: {
        "kamar_id": StringRoom,
        "status": 'Tidak tersedia',
      });

      if (response.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('TransaksiIdPaket', widget.idPaket.toString());
        await pref.setInt('TransaksiHargaPaket', widget.hargaPaket);
        await pref.setString('TransaksiNamaPaket', widget.namaPaket);
        await pref.setString(
            'TransaksiIdPlasma', selectedPlasma!.id.toString());
        await pref.setString('TransaksiIdKamar', selectedRoom.toString());

        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SuratKerjaSama()),
        );
      } else {
        popUpFailed();
       
      }
    } catch (e) {
     
      // rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataPlasma();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(
              color: Color(0xffD9D9D9),
              thickness: 4,
              indent: 165,
              endIndent: 165,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Kamar',
                    style:
                        blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Plasma',
                    style: blackTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: List.generate(plasmaList.length, (index) {
                      final plasma = plasmaList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Panggil fungsi fetchPlasmaData dengan idPlasma yang sesuai saat tombol diklik
                                  dataKamarByPlasma(plasma.id);
                                  if (selectedPlasma != plasma) {
                                    setState(() {
                                      selectedPlasma = plasma;
                                      selectedRoom = null;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        selectedPlasma?.id == plasma.id
                                            ? bluetogreenColor
                                            : neutral95Color),
                                child: Text(
                                  plasma.namaPlasma,
                                  style: selectedPlasma?.id == plasma.id
                                      ? whitekTextStyle.copyWith(
                                          fontWeight: medium)
                                      : blackTextStyle.copyWith(
                                          fontWeight: medium),
                                )),
                            const SizedBox(width: 10),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Alamat Plasma',
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: neutral95Color,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedPlasma != null
                            ? selectedPlasma!.alamatPlasma
                            : 'Loading Address...',
                        maxLines: 2,
                        style: blackTextStyle.copyWith(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No. Kamar',
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: List.generate(kamarList.length, (index) {
                      kamarModels kamar = kamarList[index];
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              onPressed: kamar.status == 'Tersedia'
                                  ? () {
                                      setState(() {
                                        selectedRoom = kamar.id;
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                disabledBackgroundColor: Colors.grey[50],
                                backgroundColor: selectedRoom == kamar.id
                                    ? bluetogreenColor
                                    : kamar.status == 'Tersedia'
                                        ? neutral95Color
                                        : whiteColor, // Men-disable tombol jika kamar tidak tersedia
                              ),
                              child: Text(
                                kamar.noKamar.toString(),
                                style: kamar.status == 'Tersedia'
                                    ? selectedRoom == kamar.id
                                        ? whitekTextStyle.copyWith(
                                            fontWeight: medium)
                                        : blackTextStyle.copyWith(
                                            fontWeight: medium)
                                    : greyTextStyle.copyWith(
                                        fontWeight: medium,
                                        color: Colors.grey.shade400),
                              )),
                          const SizedBox(width: 10)
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: Color(0xffD9D9D9),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: selectedRoom != null
                      ? bluetogreenColor
                      : bluetogreenColor.withOpacity(.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: selectedRoom != null
                    ? () {
                        setState(() {
                          isLoading = true;
                          sendData();
                        });
                      }
                    : null,
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
                          style: whitekTextStyle.copyWith(fontWeight: bold),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
