import 'package:flutter/material.dart';
import 'package:victrix/settings/settings_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: GridView.count(
            crossAxisCount: 3,
            children: const [
              Text("Example Tile 1"),
              Text("Example Tile 2"),
              Text("Example Tile 3"),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const SettingsPage();
                  }),
                );
              },
              icon: const Icon(Icons.settings),
              color: Colors.black26),
        ),
      ]),
    );
  }
}
