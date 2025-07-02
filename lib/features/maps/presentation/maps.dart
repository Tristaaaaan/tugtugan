import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final String name;
  final double latitude;
  final double longitude;

  const Maps({
    super.key,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<Maps> createState() => _MapState();
}

class _MapState extends State<Maps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late final CameraPosition _initialPosition;

  @override
  void initState() {
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 15.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: const MarkerId('targetLocation'),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow(title: widget.name),
          ),
        },
      ),
    );
  }
}
