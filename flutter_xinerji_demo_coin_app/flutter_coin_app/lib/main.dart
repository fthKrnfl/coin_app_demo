import 'package:flutter/material.dart';
import 'package:flutter_coin_app/theme/custome_theme_data.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CustomeThemeDataModel(),
        )
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<CustomeThemeDataModel>(context).getThemeData,
      home: const HomePage(),
    );
  }
}
