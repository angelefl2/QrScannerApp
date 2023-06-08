import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scanTiles.dart';
import 'package:qrreader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial localizaciones"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              final uiProvider =
                  Provider.of<UiProvider>(context, listen: false);
              final currentIndex = uiProvider.selectedMenuOpt;

              print(currentIndex);
              if (currentIndex == 0) {
                scanListProvider.borrarScanPorTipo("geo");
              } else {
                scanListProvider.borrarScanPorTipo("http");
              }
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo("geo");
        return const ScanTiles(tipo: "geo");
      case 1:
        scanListProvider.cargarScansPorTipo("http");
        return const ScanTiles(tipo: "http");
      default:
        return const ScanTiles(tipo: "geo");
    }
  }
}
