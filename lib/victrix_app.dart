import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:victrix/dashboard/provider/venus_data_provider.dart';

import 'dashboard/dashboard.dart';

class VictrixApp extends StatelessWidget {
  const VictrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => VenusDataProvider()),
      ],
      child: const MaterialApp(
        title: 'Victrix',
        home: Dashboard(),
      ),
    );
  }
}
