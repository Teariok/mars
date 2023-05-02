import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum VenusConnectionState { none, connected, disconnected }

class VenusDataProvider {
  MqttServerClient? _client;
  String? _venusId;
  ValueNotifier<VenusConnectionState> state = ValueNotifier(VenusConnectionState.none);
  final Map<String, Function(String)> _topicListeners = {};

  void connect(String address, String venusId) async {
    _venusId = venusId;
    _client = MqttServerClient(address, 'Victrix');

    _client!.setProtocolV311();
    _client!.keepAlivePeriod = 20;
    _client!.connectTimeoutPeriod = 2000;
    _client!.onDisconnected = _onClientDisconnected;
    _client!.onConnected = _onClientConnected;
    _client!.onSubscribed = _onClientSubscribed;

    _client!.connectionMessage = MqttConnectMessage().withClientIdentifier('Victrix');

    try {
      await _client!.connect();
    } on NoConnectionException catch (e) {
      _client!.disconnect();
    } on SocketException catch (e) {
      _client!.disconnect();
    }

    if (_client!.connectionStatus!.state == MqttConnectionState.connected) {
      //subscribe('#');
    } else {
      _client!.disconnect();
    }
  }

  void subscribe(String topic, Function(String) callback) {
    String key = "N/$_venusId/$topic";
    if (!_topicListeners.containsKey(key)) {
      _client?.subscribe(key, MqttQos.atMostOnce);
    }

    _topicListeners[key] = callback;

    _client!.updates!.listen(_onTopicUpdated);
  }

  void _onClientDisconnected() {
    state.value = VenusConnectionState.disconnected;
  }

  void _onClientConnected() {
    state.value = VenusConnectionState.disconnected;
  }

  void _onClientSubscribed(String? topic) {}

  void _onTopicUpdated(List<MqttReceivedMessage<MqttMessage?>>? receivedMessages) {
    MqttReceivedMessage<MqttMessage?>? targetMessage = receivedMessages![0];
    MqttPublishMessage messagePayload = targetMessage.payload as MqttPublishMessage;
    String topicPayload = MqttPublishPayload.bytesToStringAsString(messagePayload.payload.message);

    debugPrint("${targetMessage.topic} == $topicPayload");
  }
}
