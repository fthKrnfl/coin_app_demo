// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/custome_theme_data.dart';
import 'coin_page.dart';
import 'denemeler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool swich = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Coins App'),
        actions: [],
      ),
      drawer: nawigationDrawer(),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoinListPage()),
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                backgroundColor: Colors.white70,
                foregroundColor: const Color.fromARGB(255, 52, 52, 52)),
            label: const Text('Coin list'),
            icon: const Icon(Icons.monetization_on),
          ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Lorem ipsum dolor sit amet consectetuer'),
                action: SnackBarAction(label: 'undo', onPressed: () {}),
              ));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                backgroundColor: Colors.white70,
                foregroundColor: const Color.fromARGB(255, 52, 52, 52)),
            label: const Text('Snack Bar Action'),
            icon: const Icon(Icons.branding_watermark_outlined),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (swich == true) {
                Provider.of<CustomeThemeDataModel>(context, listen: false)
                    .setThemeData(ThemeData.dark());
                swich = !swich;
              } else {
                Provider.of<CustomeThemeDataModel>(context, listen: false)
                    .setThemeData(ThemeData.light());
                swich = !swich;
              }
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                backgroundColor: Colors.white70,
                foregroundColor: const Color.fromARGB(255, 52, 52, 52)),
            label: const Text('Theme Swicher'),
            icon: Icon(swich == true ? Icons.sunny : Icons.dark_mode_outlined),
          )
        ]),
      ),
    );
  }

  NavigationDrawer nawigationDrawer() {
    return NavigationDrawer(children: [
      InkWell(
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CoinListPageDeneme()),
          );
        },
        child: const Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
            )
          ],
        ),
      ),
      const Column(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Sec Page'),
          )
        ],
      ),
      const Column(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('theme'),
          )
        ],
      ),
    ]);
  }
}
