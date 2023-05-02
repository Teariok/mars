import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:victrix/settings/broker_settings.dart';

import 'victrix_app.dart';

void main() {
  Hive
    ..init(Directory.current.path)
    ..registerAdapter(BrokerSettingsAdapter());

  runApp(const VictrixApp());
}
