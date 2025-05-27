import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';

class StudioServices {
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

  Future<void> addStudio(StudioModel studioData) async {
    final docRef = await FirebaseFirestore.instance
        .collection("studios")
        .add(studioData.toMap());

    final generatedId = docRef.id;

    await docRef.update({'id': generatedId});
  }
}
