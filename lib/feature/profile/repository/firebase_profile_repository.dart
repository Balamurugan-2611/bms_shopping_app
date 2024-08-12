import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bms_shopping_app/feature/auth/model/user_app.dart';  // Updated path
import 'package:bms_shopping_app/feature/profile/repository/profile_repository.dart';  // Updated path

class FirebaseProfileRepository extends ProfileRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection('user');

  @override
  Future<void> logout() async {
    return _auth.signOut();
  }

  @override
  Future<UserData?> getUserInfo() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return null;

    final userDoc = await userCollection.doc(currentUser.uid).get();
    if (!userDoc.exists) return null;

    return _mapDocumentToUserData(userDoc);
  }

  UserData _mapDocumentToUserData(DocumentSnapshot<Map<String, dynamic>> data) {
    final userData = data.data()!;
    return UserData(
      uid: userData['uid'] ?? '',
      email: userData['email'] ?? '',
      firstname: userData['firstname'] ?? '',
      lastname: userData['lastname'] ?? '',
      username: userData['username'] ?? '',
      dob: userData['dob'] ?? '',
    );
  }
}
