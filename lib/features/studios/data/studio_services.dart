import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';

import '../domain/chat_repository.dart';

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
