import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/core/appmodels/user_model.dart';
import 'package:tugtugan/features/notification/notification_services.dart';

final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessage firebaseMessaging = FirebaseMessage();
  Future<UserCredential?> signInWithGoogle(
      WidgetRef ref, BuildContext context) async {
    final String? fcmtoken = await firebaseMessaging.getFCMToken();
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      if (guser != null) {
        // Obtain auth details from request
        final GoogleSignInAuthentication gAuth = await guser.authentication;

        // Create a new credential for user
        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        // Sign in with Google
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        UserModel newUserData = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          fcmtoken: fcmtoken!,
          fullName: userCredential.user!.displayName!,
          imageUrl: userCredential.user!.photoURL.toString(),
        );

        final DocumentReference docRef =
            _firestore.collection('users').doc(userCredential.user!.uid);

        final DocumentSnapshot docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          // Document exists, update only necessary fields
          await docRef.update({
            'fcmToken': fcmtoken,
          });
        } else {
          // Document does not exist, create it

          await docRef.set(newUserData.toMap());
        }

        return userCredential;
      }
      return null;
    } catch (e) {
      if (context.mounted) {
        await signOutAccount(ref);
      }

      return null;
    }
  }

  Future<void> signOutAccount(
    WidgetRef ref,
  ) async {
    // Cancel any active streams
    // ref.invalidate(userInfoProvider(_auth.currentUser!.uid));
    // ref.invalidate(detectionInfoProvider); // Cancel detection streams

    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
