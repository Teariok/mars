import 'package:hive/hive.dart';

part 'broker_settings.g.dart';

@HiveType(typeId: 0)
class BrokerSettings extends HiveObject {
  @HiveField(0)
  String url;

  @HiveField(1)
  String venusId;

  BrokerSettings({required this.url, required this.venusId});
}
