import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';

final studioProvider = StreamProvider<List<StudioModel>>((ref) {
  return FirebaseFirestore.instance
      .collection("studios")
      .limit(10)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
          .map((doc) => StudioModel.fromSnapshot(doc))
          .toList());
});

final specificStudioProvider =
    StreamProvider.family<StudioModel, String>((ref, studioId) {
  return FirebaseFirestore.instance
      .collection("studios")
      .doc(studioId)
      .snapshots()
      .map(
        (querySnapshot) => StudioModel.fromSnapshot(querySnapshot),
      );
});
