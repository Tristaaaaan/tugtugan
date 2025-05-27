import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Maps extends StatelessWidget {
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
  Widget build(BuildContext context) {
    developer.log('Longitude: $longitude, Latitude: $latitude, Name: $name');
    // final LocationService locationService = LocationService();
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: MapWidget(
        key: const ValueKey('map'),
        cameraOptions: CameraOptions(
          center: Point(
            coordinates: Position(
              longitude,
              latitude,
            ),
          ),
          zoom: 12,
        ),
        styleUri: MapboxStyles.MAPBOX_STREETS,
        onMapCreated: (MapboxMap map) async {
          // final locationData = await locationService.getCurrentLocation();
          map.flyTo(
            CameraOptions(
              center: Point(
                coordinates: Position(longitude, latitude),
              ),
              zoom: 14.0,
            ),
            MapAnimationOptions(duration: 1000),
          );

          final annotationManager =
              await map.annotations.createPointAnnotationManager();

          await annotationManager.create(PointAnnotationOptions(
            geometry: Point(
              coordinates: Position(
                longitude,
                latitude,
              ),
            ),
          ));
        },
      ),
    );
  }
}
