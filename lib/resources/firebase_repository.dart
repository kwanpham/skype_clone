import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone/models/message.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/firebase_methos.dart';

class FireBaseRepository {

  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<User> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(User user) => _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

  Future<List<UserModel>> fetchAllUsers(User user) =>
      _firebaseMethods.fetchAllUsers(user);

  Future<void> addMessageToDb(Message message, UserModel sender, UserModel receiver) =>
      _firebaseMethods.addMessageToDb(message, sender, receiver);

}