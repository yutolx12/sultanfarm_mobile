import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/api_Connect.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:sultan_farm_mobile/Widgets/buttons.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sultan_farm_mobile/Models/mqttPublish.dart';

// class mqttConnection {
//   late MqttServerClient client;
//   String host = '103.210.69.14';
//   String pubTopic = 'sultanfarm/2/monitoring/dht/1';
//   String pubTopic2 = 'sultanfarm/2/monitoring/mq/1';
//   String username = 'mosquitto';
//   String password = 'mqttsultanfarm123';
//   int random = Random().nextInt(4294967296);
//   String topic = 'rgb2';
//   String message = '255000000';
//   bool retain = true;
//   mqttPublish() async {
//     final randomrandom = random.toString();
//     client = MqttServerClient.withPort("103.210.69.14", randomrandom, 1883);
//     client.keepAlivePeriod = 99999999999;
//     client.autoReconnect = true;
//     await client.connect(username, password).onError((error, stackTrace) {
//       return null;
//     });

//     client.onConnected = () {};

//     client.onDisconnected = () {};

//     client.onSubscribed = (String topic) {};

//     if (client.connectionStatus!.state == MqttConnectionState.connected) {
//       final builder = MqttClientPayloadBuilder();
//       builder.addString(message);
//       client.publishMessage(
//         topic,
//         MqttQos.atLeastOnce,
//         builder.payload!,
//         retain: retain,
//       );
//       builder.clear();
//     }
//   }
// }

class CardDombaMonitoring extends StatefulWidget {
  final String gambar;
  final String jenisDomba;
  final String jenisKelamin;
  final String tglLahir;
  final int bobot;

  const CardDombaMonitoring({
    super.key,
    required this.gambar,
    required this.jenisDomba,
    required this.jenisKelamin,
    required this.tglLahir,
    required this.bobot,
  });

  @override
  State<CardDombaMonitoring> createState() => _CardDombaMonitoringState();
}

late MqttServerClient client;
String host = '103.210.69.14';
String pubTopic = 'statuskalung';
String pesanKalung = '1';
String pubTopic2 = 'sultanfarm/2/kalung/count';
String username = 'mosquitto';
String password = 'mqttsultanfarm123';
int random = Random().nextInt(4294967296);
String topic = 'rgb2';
String message = '255000000';
bool retain = true;
String jmlDomba = '';

mqttPublish() async {
  final randomrandom = random.toString();
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

  client.onSubscribed = (String topic) {};

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: retain,
    );
    builder.clear();
  }
}

mqttPublishKalung() async {
  final randomrandom = random.toString();
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
      pubTopic,
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: retain,
    );
    builder.clear();
  }
}



class _CardDombaMonitoringState extends State<CardDombaMonitoring> {
  // get client => mqttConnection();

  // mqttPublishKalung() async {
  //   final randomrandom = random.toString();
  //   client = MqttServerClient.withPort("103.210.69.14", randomrandom, 1883);
  //   client.keepAlivePeriod = 99999999999;
  //   client.autoReconnect = true;
  //   await client.connect(username, password).onError((error, stackTrace) {
  //     return null;
  //   });

  //   client.onConnected = () {
  //     print('connect to broker');
  //   };

  //   client.onDisconnected = () {};

  //   client.onSubscribed = (String pubTopic) {};

  //   if (client.connectionStatus!.state == MqttConnectionState.connected) {
  //     final builder = MqttClientPayloadBuilder();
  //     builder.addString(pesanKalung);
  //     client.publishMessage(
  //       pubTopic,
  //       MqttQos.atLeastOnce,
  //       builder.payload!,
  //       retain: retain,
  //     );
  //     builder.clear();
  //   }
  // }

  mqttSubscribeToKalungCount() async {
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
          jmlDomba = jsonDecode(pt)["kalung"].toString();
        });
      });
    }
  }

  @override
  void initState() {
    mqttPublishKalung();
    mqttSubscribeToKalungCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      color: whiteColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: whiteColor),
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${ApiConnect.host}web-sultan-farm/public/images/${widget.gambar}',
                fit: BoxFit.cover,
              ),
            ), // Replace with your image network path
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Keterangan',
            style: blackTextStyle.copyWith(fontSize: 15, fontWeight: regular),
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
                  padding: const EdgeInsets.only(
                    right: 50,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jenis Domba',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      Text(widget.jenisDomba,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 50,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bobot',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      Text('${widget.bobot} Kg',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular))
                    ],
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 50,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kelamin',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      Text(widget.jenisKelamin,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 50,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Umur',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      Text(widget.tglLahir,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: regular))
                    ],
                  ),
                ),
              ]),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomFilledButton(
                onPressed: () {
                  mqttPublish();
                },
                title: 'Hidupkan Lampu',
                textColor: TextStyle(
                  color: whiteColor,
                ),
                width: 135,
                height: 40,
                bgcolor: bluetogreenColor,
              ),
              const SizedBox(
                width: 10,
              ),
              
            ],
          )
        ],
      ),
    );
  }
}
