import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/studio_entity.dart';
import 'business_hours_model.dart';

part 'studio_model.freezed.dart';

@freezed
abstract class StudioModel with _$StudioModel {
  const factory StudioModel({
    required String id,
    required String studioName,
    required String description,
    required String address,
    required GeoPoint location,
    required List<String> imageUrl,
    required List<String> followers,
    BusinessHoursModel? businessHours,
  }) = _StudioModel;

  const StudioModel._();

  factory StudioModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return StudioModel(
      id: map['id'] as String,
      studioName: map['studioName'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      location: map['location'] as GeoPoint,
      imageUrl: List<String>.from(
        map['imageUrl'] ?? [],
      ),
      followers: List<String>.from(
        map['followers'] ?? [],
      ),
      businessHours: map['businessHours'] != null
          ? BusinessHoursModel.fromMap(
              Map<String, dynamic>.from(
                map['businessHours'] as Map,
              ),
            )
          : null,
    );
  }

  factory StudioModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    if (data == null) {
      throw Exception('Studio document does not exist');
    }

    return StudioModel.fromMap({
      ...data,
      'id': doc.id,
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studioName': studioName,
      'description': description,
      'address': address,
      'location': location,
      'imageUrl': imageUrl,
      'followers': followers,
      'businessHours': businessHours?.toMap(),
    };
  }

  StudioEntity toEntity() {
    return StudioEntity(
      id: id,
      studioName: studioName,
      description: description,
      address: address,
      location: location,
      imageUrl: imageUrl,
      followers: followers,
      businessHours: businessHours?.toEntity(),
    );
  }

  factory StudioModel.fromEntity(
    StudioEntity entity,
  ) {
    return StudioModel(
      id: entity.id,
      studioName: entity.studioName,
      description: entity.description,
      address: entity.address,
      location: entity.location,
      imageUrl: entity.imageUrl,
      followers: entity.followers,
      businessHours: entity.businessHours != null
          ? BusinessHoursModel.fromEntity(
              entity.businessHours!,
            )
          : null,
    );
  }
}

class Amenities {
  bool wheelchairAccessible;
  bool privateParking;
  bool nearbyTransit;

  Amenities({
    required this.wheelchairAccessible,
    required this.privateParking,
    required this.nearbyTransit,
  });
}

class Availability {
  String day;
  List<TimeSlot> timeSlots;

  Availability({
    required this.day,
    required this.timeSlots,
  });
}

class TimeSlot {
  String start;
  String end;

  TimeSlot({
    required this.start,
    required this.end,
  });
}

class Contact {
  String phone;
  String email;
  String website;
  Social social;

  Contact({
    required this.phone,
    required this.email,
    required this.website,
    required this.social,
  });
}

class Social {
  String instagram;
  String facebook;

  Social({
    required this.instagram,
    required this.facebook,
  });
}

class Ratings {
  double average;
  int reviewsCount;

  Ratings({
    required this.average,
    required this.reviewsCount,
  });
}

class Service {
  String id;
  String name;
  String description;
  int durationMinutes;
  int priceUsd;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.priceUsd,
  });
}
