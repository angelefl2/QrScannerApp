import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapType maptype = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLang(),
      tilt: 20,
      zoom: 19,
    );

    // Chinchetas
    Set<Marker> markers = new Set<Marker>();
    markers.add(
      Marker(
        markerId: MarkerId("geo-location"),
        position: scan.getLatLang(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa"),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller
                  .animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
            },
            icon: Icon(Icons.location_pin),
          ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: maptype,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: () {
          if (maptype == MapType.normal) {
            maptype = MapType.satellite;
          } else {
            maptype = MapType.normal;
          }
          setState(() {});
        },
      ),
    );
  }
}
