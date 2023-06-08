import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pages/home_page.dart';
import 'package:qrreader/pages/mapa_page.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          "home": ((_) => HomePage()),
          "mapa": ((_) => MapaPage()),
        },
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blueAccent),
        ),
      ),
    );
  }
}
