import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:qrreader/pages/direcciones_page.dart';
import 'package:qrreader/pages/mapas_page.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial localizaciones"),
        backgroundColor:  Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
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
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    final tempSCan = new ScanModel(valor: "https://gooooogleeesocio.es/");
    DBProvider.db.nuevoScan(tempSCan);
    // DBProvider.db.getScanById(1).then((value) => print(value.valor));
    // DBProvider.db.getTodosLosScans().then((value) => print(value));

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
       scanListProvider.cargarScansPorTipo("geo");
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo("http");
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
