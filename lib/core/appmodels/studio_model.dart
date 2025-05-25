import 'package:cloud_firestore/cloud_firestore.dart';

class StudioModel {
  String id;
  String name;
  String description;
  String address;
  GeoPoint location;
  Contact contact;
  List<String> images;
  List<String> facilities;
  List<Service> services;
  List<Availability> availability;
  List<String> rules;
  Ratings ratings;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;

  StudioModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.location,
    required this.contact,
    required this.images,
    required this.facilities,
    required this.services,
    required this.availability,
    required this.rules,
    required this.ratings,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });
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
