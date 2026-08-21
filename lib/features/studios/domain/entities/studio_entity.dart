import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'business_hours_entity.dart';

class StudioEntity extends Equatable {
  final String id;
  final String studioName;
  final String description;
  final String address;
  final GeoPoint location;
  final String imageUrl;
  final List<String> followers;
  final BusinessHoursEntity? businessHours;

  const StudioEntity({
    required this.id,
    required this.studioName,
    required this.description,
    required this.address,
    required this.location,
    required this.imageUrl,
    required this.followers,
    this.businessHours,
  });

  @override
  List<Object?> get props => [
        id,
        studioName,
        description,
        address,
        location,
        imageUrl,
        followers,
        businessHours,
      ];
}
