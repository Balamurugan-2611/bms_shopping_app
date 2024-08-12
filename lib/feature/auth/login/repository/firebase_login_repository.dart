import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bms_shopping_app/feature/auth/login/repository/login_repository.dart';
import 'package:bms_shopping_app/feature/auth/model/user_app.dart';

class FirebaseLoginRepository extends LoginRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection("user");

  @override
  Future<bool> isSignedIn() async {
    return _auth.currentUser != null;
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      print('$email - $password');
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user != null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUserData(UserData userData) async {
    await _userCollection.doc(userData.uid).set({
      'username': userData.username,
      'email': userData.email,
      'dob': userData.dob,
      'firstname': userData.firstname,
      'lastname': userData.lastname,
    });
  }

  @override
  Future<bool> register(UserData userData) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );
      userData.uid = result.user?.uid ?? '';
      if (userData.uid.isNotEmpty) {
        await updateUserData(userData);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
