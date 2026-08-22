import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/availability_entity.dart';
import '../../domain/entities/business_hours_entity.dart';
import '../../domain/repos/studio_repository.dart';
import '../datasource/remote/studio_information_remote_datasource.dart';
import '../model/studio_model.dart';

class StudioServices implements StudioRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> followStudio(
    String studioId,
    String userId,
  ) async {
    await FirebaseFirestore.instance
        .collection("studios")
        .doc(studioId)
        .update({
      "followers": FieldValue.arrayUnion([userId])
    });
  }

  @override
  Future<void> unfollowStudio(
    String studioId,
    String userId,
  ) async {
    await FirebaseFirestore.instance
        .collection("studios")
        .doc(studioId)
        .update({
      "followers": FieldValue.arrayRemove([userId])
    });
  }

  @override
  Future<void> addStudio(StudioModel studioData) async {
    final docRef = await FirebaseFirestore.instance
        .collection("studios")
        .add(studioData.toMap());

    final generatedId = docRef.id;

    await docRef.update({'id': generatedId});
  }

  @override
  Stream<StudioModel?> streamSpecificStudio(String studioId, String clientId) {
    return _firestore.collection('studios').doc(studioId).snapshots().map(
      (docSnapshot) {
        if (!docSnapshot.exists) return null;
        return StudioModel.fromMap(docSnapshot.data()!);
      },
    );
  }
}

class StudioInformationRepositoryImpl implements StudioInformationRepository {
  final StudioInformationRemoteDatasource studioInformationRemoteDatasource;

  StudioInformationRepositoryImpl(
      {required this.studioInformationRemoteDatasource});
  @override
  Future<List<StudioAvailabilityEntity>?> getAvailability(
    String studioId,
    int year,
    int month,
  ) async {
    final models = await studioInformationRemoteDatasource.getAvailability(
      studioId,
      year,
      month,
    );

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<BusinessHoursEntity> getBusinessHours(
      String studioId, int year, int month, int day) async {
    final model = await studioInformationRemoteDatasource.getBusinessHours(
      studioId,
      year,
      month,
      day,
    );
    return model.toEntity();
  }
}
