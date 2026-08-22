import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../model/availability_model.dart';
import '../../model/business_hours_model.dart';

abstract class StudioInformationRemoteDatasource {
  Future<BusinessHoursModel> getBusinessHours(
      String studioI, int year, int month, int day);
  Future<List<AvailabilityModel>> getAvailability(
    String studioId,
    int year,
    int month,
  );
}

class StudioInformationRemoteDatasourceImpl
    implements StudioInformationRemoteDatasource {
  final FirebaseFunctions functions;

  StudioInformationRemoteDatasourceImpl({
    required this.functions,
  });

  @override
  Future<BusinessHoursModel> getBusinessHours(
      String studioId, int year, int month, int day) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('studios')
          .doc(studioId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('Studio not found');
      }

      final data = docSnapshot.data();
      if (data == null || !data.containsKey('businessHours')) {
        throw Exception('Business hours not found for this studio');
      }

      return BusinessHoursModel.fromMap(data['businessHours']);
    } catch (e) {
      throw Exception(
        'Failed to get business hours: $e',
      );
    }
  }

  @override
  Future<List<AvailabilityModel>> getAvailability(
    String studioId,
    int year,
    int month,
  ) async {
    try {
      final callable = functions.httpsCallable('get_availability');

      final result = await callable.call({
        'studioId': studioId,
        'year': year,
        'month': month,
      });

      final data = Map<String, dynamic>.from(result.data);

      final availabilityData = List<Map<String, dynamic>>.from(
        (data['availability'] as List).map(
          (item) => Map<String, dynamic>.from(item),
        ),
      );

      return availabilityData
          .map(
            (item) => AvailabilityModel.fromMap(item),
          )
          .toList();
    } on FirebaseFunctionsException catch (e) {
      throw Exception(
        'Failed to get availability: ${e.code} - ${e.message}',
      );
    } catch (e) {
      throw Exception(
        'Failed to get availability: $e',
      );
    }
  }
}
