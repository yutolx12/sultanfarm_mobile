import 'dart:io';
import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// late SharedPreferences s_prefs;
// var datauser = '';

// var namaDepan = '';

// String tdata = DateFormat("HH:mm:ss").format(DateTime.now());

// int random = 0, randomminmax = 0;
// double randomdouble = 0.00;

// int randomNumber() {
//   int random = Random().nextInt(1000000); //1000 is MAX value
//   //generate random number below 1000
//   return random;
// }

int random = Random().nextInt(4294967296);
final randomrandom = random.toString();

class MQTTClientManagerChart {
  MqttServerClient client =
      MqttServerClient.withPort('103.210.69.14', randomrandom, 1883);

  Future<int> connect(String username, String passwo) async {
    client.logging(on: true);
    client.keepAlivePeriod = 999999999999999999;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage =
        MqttConnectMessage().startClean().withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      client.disconnect();
    } on SocketException catch (e) {
      client.disconnect();
    }

    return 0;
  }

  void disconnect() {
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
  }

  bool isConnected() {
    return client.connectionStatus!.state == MqttConnectionState.connected;
  }

  void onDisconnected() {
    
  }

  void onSubscribed(String topic) {
    
  }

  void pong() {
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }
}

