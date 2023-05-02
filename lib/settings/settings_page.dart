import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:victrix/dashboard/provider/venus_data_provider.dart';
import 'package:victrix/settings/broker_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController _brokerAddressController = TextEditingController();
  final TextEditingController _deviceIdController = TextEditingController();

  BrokerSettings? _brokerSettings;

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    Box settingsBox = await Hive.openBox('settings');

    _brokerSettings = settingsBox.get('broker_settings', defaultValue: BrokerSettings(url: "", venusId: ""));
    _brokerAddressController.text = _brokerSettings!.url;
    _deviceIdController.text = _brokerSettings!.venusId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text("Venus/Cerbo URL"),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _brokerAddressController,
                ),
              ),
            ]),
            Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text("Venus/Cerbo Id"),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _deviceIdController,
                ),
              ),
            ]),
            ElevatedButton(
              onPressed: () {
                _brokerSettings?.url = _brokerAddressController.text;
                _brokerSettings?.venusId = _deviceIdController.text;
                _brokerSettings?.save();

                Provider.of<VenusDataProvider>(context, listen: false).connect(
                  _brokerSettings!.url,
                  _brokerSettings!.venusId,
                );
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
