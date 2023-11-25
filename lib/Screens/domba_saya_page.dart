import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/riwayat_selesai_models.dart';
import 'package:sultan_farm_mobile/Screens/monitoring_page.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import '../Widgets/card_domba_saya.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DombaSaya extends StatefulWidget {
  const DombaSaya({Key? key}) : super(key: key);

  @override
  State<DombaSaya> createState() => _DombaSayaState();
}

class _DombaSayaState extends State<DombaSaya> {
  List<RiwayatSelesaiModels>? responseDataselesai;

  late SharedPreferences prefs;
  var id = '';
  final Uri _url = Uri.parse('https://sultanfarm.id/globalscanQr');

  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAkun().then((_) {
      fetchDataRiwayatSelesai();
    });
  }

  Future<void> saveShared(idPenjualan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("idPenjualan", idPenjualan);
  }

  Future<void> fetchDataRiwayatSelesai() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConnect.riwayatSelesai),
        body: {
          'id_customer': id,
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);

        final List<RiwayatSelesaiModels> selesai =
            data.map((item) => RiwayatSelesaiModels.fromJson(item)).toList();
        setState(() {
          responseDataselesai = selesai;
        });
      } else {}
    } catch (e) {}
  }

  Future<void> refreshData() async {
    // Tambahkan penundaan 2 detik untuk efek Shimmer
    await Future.delayed(const Duration(seconds: 2));
    await getDataAkun();
    await fetchDataRiwayatSelesai();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Domba Saya',
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold)),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            tooltip: 'Buka Scanner',
            onPressed: () {
              _launchUrl();
            },
          ),
        ],
        // actions: [s
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: responseDataselesai != null && responseDataselesai!.isNotEmpty
              ? ListView.builder(
                  itemCount: responseDataselesai?.length ?? 0,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    RiwayatSelesaiModels item = responseDataselesai![index];

                    DateTime tanggalLahir =
                        DateTime.parse(item.createdAt.toString());
                    DateTime now = DateTime.now();

                    Duration difference = now.difference(tanggalLahir);
                    int tahun = (difference.inDays / 365).floor();
                    int bulan = ((difference.inDays % 365) / 30).floor();
                    int hari = (difference.inDays % 365) % 30;

                    String formattglLahir =
                        '$tahun Tahun $bulan Bulan $hari Hari';

                    int jumlahDomba;
                    if (item.idPaket == 16) {
                      jumlahDomba = 12;
                    } else if (item.idPaket == 18) {
                      jumlahDomba = 8;
                    } else if (item.idPaket == 19) {
                      jumlahDomba = 6;
                    } else {
                      jumlahDomba =
                          0; // Set a default value or handle accordingly
                    }
                    return CardDombaSaya(
                      gambar: item.gambar,
                      namaPaket: item.namaPaket,
                      total: item.total,
                      jumlah: jumlahDomba,
                      noKamar: item.noKamar,
                      plasma: item.namaPlasma,
                      hari: formattglLahir,
                      onTap: () {
                        var idPenjualan = item.id;
                        saveShared(idPenjualan);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Monitoring()),
                        );
                      },
                    );
                  },
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height *
                        0.83, // Set an appropriate height
                    child: Text(
                      'Anda masih belum memiliki domba',
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
