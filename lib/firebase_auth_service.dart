import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_test_app/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserModel> signIn({required String email, required String password}) async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          email: userCredential.user?.email ?? "",
          id: userCredential.user?.uid ?? "",
          error: "",
      );
      return userModel;
    } on FirebaseAuthException catch (e){
      print(e.message);
      print(e.code);

      return UserModel(email: "", id: "", error: "");
    }

    //40sHpqnNhbQ0TYG6IjCvowgNNQd2
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}