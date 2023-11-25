import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Models/domba_saya_models.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/video_player_rtmp.dart';
import '../Widgets/card_domba_monitoring.dart';
import 'package:http/http.dart' as http;

class Monitoring extends StatefulWidget {
  const Monitoring({Key? key}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}
// late MQTTClientManager mqttClientManager;

class _MonitoringState extends State<Monitoring>
    with SingleTickerProviderStateMixin {
  var id = '';
  String idPenjualan = '';
  String suhu = '';
  String kelembapan = '';
  String metana = '';
  String host = '103.210.69.14';
  String pubTopic = 'sultanfarm/2/monitoring/dht/1';
  String pubTopic2 = 'sultanfarm/2/monitoring/mq/1';
  String pubTopic3 = 'statuskalung';
  String pubTopic4 = 'sultanfarm/2/kalung/count';
  String pesanKalung = '1';
  String jmlDomba = '';
  bool retain = true;
  String username = 'mosquitto';
  String password = 'mqttsultanfarm123';

  late MqttServerClient client;
  late MqttServerClient client2;
  late SharedPreferences prefs;

  int random = Random().nextInt(4294967296);
  int random2 = Random().nextInt(4294967296);

  List<DombaSayaModels>? responseDombaSaya;

  TabController? _tabController;

  // Future<void> getIdPenjualan() async {

  // }

  getDataAkun() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id").toString();
    });
    SharedPreferences prefss = await SharedPreferences.getInstance();
    int? savedIdPenjualan = prefss.getInt('idPenjualan');
    if (savedIdPenjualan != null) {
      setState(() {
        idPenjualan = savedIdPenjualan.toString();
      });
    }
  }

  Future<void> fetchDataDombaSaya() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConnect.dombaSaya),
        body: {
          'id_customer': id,
          'id': idPenjualan,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<DombaSayaModels> dombaku =
            data.map((item) => DombaSayaModels.fromJson(item)).toList();

        setState(() {
          responseDombaSaya = dombaku;
        });
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> refreshData() async {
    // Tambahkan penundaan 2 detik untuk efek Shimmer
    await Future.delayed(const Duration(seconds: 2));
    await getDataAkun();
    await fetchDataDombaSaya();
  }

  mqttSubscribe() async {
    final randomrandom = random.toString();
    client = MqttServerClient.withPort("103.210.69.14", randomrandom, 1883);
    client.keepAlivePeriod = 99999999999;
    client.autoReconnect = true;
    await client.connect(username, password).onError((error, stackTrace) {
      return null;
    });

    client.onConnected = () {};

    client.onDisconnected = () {};

    client.onSubscribed = (String topic) {};

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.subscribe(pubTopic, MqttQos.atMostOnce);

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        setState(() {
          suhu = jsonDecode(pt)["temperature"].toString();
          kelembapan = jsonDecode(pt)["humidity"].toString();
          mqttSubscribeMetana();
        });
      });
    }
  }

  mqttSubscribeToMetana() async {
    await client.connect(username, password).onError((error, stackTrace) {
      return null;
    });
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.subscribe(pubTopic2, MqttQos.atMostOnce);

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        setState(() {
          metana = jsonDecode(pt)["metana"].toString();
          mqttDisconnectFromTopic();
        });
      });
    }
  }

  mqttPublishKalung() async {
    final randomrandom = random2.toString();
    client = MqttServerClient.withPort("103.210.69.14", randomrandom, 1883);
    client.keepAlivePeriod = 99999999999;
    client.autoReconnect = true;
    await client.connect(username, password).onError((error, stackTrace) {
      return null;
    });

    client.onConnected = () {
      print('connect to broker');
    };

    client.onDisconnected = () {};

    // client.onSubscribed = (String pubTopic) {};

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(pesanKalung);
      client.publishMessage(
        pubTopic3,
        MqttQos.atLeastOnce,
        builder.payload!,
        retain: retain,
      );
      builder.clear();
    }
  }

  mqttDisconnectFromTopic() async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
        client.subscribe(pubTopic4, MqttQos.atMostOnce);

        client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
          final recMess = c![0].payload as MqttPublishMessage;
          final pt =
              MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          setState(() {
            jmlDomba = jsonDecode(pt)["jumlah"].toString();
            client.disconnect();
            mqttSubscribe();
          });
        });
      
    }
  }

  mqttSubscribeMetana() async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.disconnect();
      mqttSubscribeToMetana();
      
    }
  }

  mqttDisconnect() async {
    client.disconnect();
  }

  // publishMessage() {
  //   final builder = MqttClientPayloadBuilder();
  //   builder.addString(message);
  //   client.publishMessage(
  //     topic,
  //     MqttQos.atLeastOnce,
  //     builder.payload!,
  //     retain: retain,
  //   );
  //   builder.clear();
  // }

  @override
  void initState() {
    mqttSubscribe();
    // mqttSubscribeMetana();
    mqttPublishKalung();
    super.initState();
    getDataAkun().then((_) {
      fetchDataDombaSaya().then((_) {
        _tabController = TabController(
          length: responseDombaSaya?.length ?? 0,
          vsync: this,
        );
      });
    });
  }

  @override
  void dispose() {
    const VideoPlayerRtmp();
    mqttDisconnect();
    if (_tabController != null) {
      _tabController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: responseDombaSaya?.length ?? 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            'Monitoring',
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 14),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  // Text(
                  //   'Jumlah Domba \ndi dalam sekat : $jmlDomba\t',
                  //   style: blackTextStyle.copyWith(fontWeight: semiBold),
                  // ),
                  Image.asset(
                    'assets/icon_domba_saya.png',
                    width: 32,
                    height: 32,
                    color: dark50Color,
                  ),
                  Text(
                    '\t:\t$jmlDomba',
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  )
                ],
              ),
            ),
          ],
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.shopping_cart,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           new MaterialPageRoute(
          //               builder: (context) => new KeranjangPage()));
          // Add your cart icon's onPressed logic here
          //     },
          //   ),
          // ],
        ),
        body: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height * 0.07,
              color: whiteColor,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: bluetogreenColor),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Live',
                        style: whitekTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Metana',
                        style: greyTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                      Text(
                        // formatToPercentage(
                        //     3), //Mengubah angkan menjadi persentase
                        "$metana\t%",
                        style: blackTextStyle.copyWith(fontWeight: regular),
                      ),
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Kelembapan',
                          style: greyTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 14),
                        ),
                        Text(
                          "$kelembapan\t%", //Mengubah angkan menjadi persentase
                          // kelembapan,
                          style: blackTextStyle.copyWith(fontWeight: regular),
                        )
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Suhu',
                        style: greyTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                      Text(
                        "$suhu\t°C", // Menggunakan format Celsius
                        // suhu,
                        style: blackTextStyle.copyWith(fontWeight: regular),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const VideoPlayerRtmp(),
            const SizedBox(height: 5),
            (responseDombaSaya?.length ?? 0) > 4
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: bluetogreenColor,
                      unselectedLabelColor: greyColor,
                      labelColor: bluetogreenColor,
                      labelStyle:
                          bluetogreenTextStyle.copyWith(fontWeight: semiBold),
                      unselectedLabelStyle:
                          greyTextStyle.copyWith(fontWeight: semiBold),
                      controller: _tabController,
                      tabs: (responseDombaSaya ?? [])
                          .asMap()
                          .entries
                          .map((entry) {
                        final int index = entry.key + 1;
                        return Tab(
                          text: 'Domba $index',
                        );
                      }).toList(),
                    ),
                  )
                : TabBar(
                    indicatorColor: bluetogreenColor,
                    unselectedLabelColor: greyColor,
                    labelColor: bluetogreenColor,
                    labelStyle:
                        bluetogreenTextStyle.copyWith(fontWeight: semiBold),
                    unselectedLabelStyle:
                        greyTextStyle.copyWith(fontWeight: semiBold),
                    controller: _tabController,
                    tabs:
                        (responseDombaSaya ?? []).asMap().entries.map((entry) {
                      final int index = entry.key + 1;
                      return Tab(
                        text: 'Domba $index',
                      );
                    }).toList(),
                  ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: (responseDombaSaya ?? []).map((domba) {
                  return ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DateTime tanggalLahir =
                          DateTime.parse(domba.tglLahir.toString());
                      DateTime now = DateTime.now();
                      Duration difference = now.difference(tanggalLahir);
                      int tahun = (difference.inDays / 365).floor();
                      int bulan = ((difference.inDays % 365) / 30).floor();
                      int hari = (difference.inDays % 365) % 30;
                      String formattglLahir =
                          '$tahun Tahun $bulan Bulan $hari Hari';

                      return CardDombaMonitoring(
                        gambar: domba.gambar,
                        bobot: domba.bobot,
                        jenisDomba: domba.jenisDomba,
                        jenisKelamin: domba.jenisKelamin,
                        tglLahir: formattglLahir,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
