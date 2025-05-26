import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tugtugan/commons/helpers/permissions.dart';

class Maps extends StatelessWidget {
  final String name;
  const Maps({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final LocationService locationService = LocationService();
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: MapWidget(
        key: const ValueKey('map'),
        cameraOptions: CameraOptions(
          center: Point(
            coordinates: Position(0.0, 0.0),
          ),
          zoom: 12,
        ),
        styleUri: MapboxStyles.MAPBOX_STREETS,
        onMapCreated: (MapboxMap map) async {
          final locationData = await locationService.getCurrentLocation();
          map.flyTo(
            CameraOptions(
              center: Point(
                coordinates: Position(
                  locationData?.longitude ?? 0.0,
                  locationData?.latitude ?? 0.0,
                ),
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
                locationData?.longitude ?? 0.0,
                locationData?.latitude ?? 0.0,
              ),
            ),
          ));
        },
      ),
    );
  }
}
