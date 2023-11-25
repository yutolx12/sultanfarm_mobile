import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class mqttConnection {
  late MqttServerClient client;
  String host = '103.210.69.14';
  String pubTopic = 'sultanfarm/2/monitoring/dht/1';
  String pubTopic2 = 'sultanfarm/2/monitoring/mq/1';
  String username = 'mosquitto';
  String password = 'mqttsultanfarm123';
  int random = Random().nextInt(4294967296);
  String topic = 'rgb2';
  String message = '255000000';
  bool retain = true;
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
}
