import 'package:cloud_firestore/cloud_firestore.dart';

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
}
