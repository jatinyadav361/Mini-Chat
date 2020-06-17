import 'package:chat/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {

  final CollectionReference personalCollection = Firestore.instance.collection('personal');

  final String uid;
  FireStoreService({this.uid});


  //stream of user data document
  Stream<UserData> get userData {
    return personalCollection.document().snapshots().map(
      _userDataFromDocumentSnapshot
    );
  }

  //get user data from document snapshot
  UserData _userDataFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      username: snapshot.data['username'],
      photoUrl: snapshot.data['photoUrl'],
      uid: uid,
      email: snapshot.data['email'],
    );
  }

  //stream of user list
  Stream<List<UserData>> get users {
    return personalCollection.snapshots().map(
      _getUserListFromQuerySnapshot
    );
  }

  List<UserData> _getUserListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return UserData(
        uid: doc.documentID,
        username: doc.data['username'],
        photoUrl: doc.data['photoUrl'],
        email: doc.data['email'],
      );
    }).toList();
  }


  //update or create user data
  Future updateUserData(String name,String photoUrl,String email) async {
    return  await personalCollection.document(uid).setData({
      'username' : name,
      'photoUrl': photoUrl,
      'email' : email,
    });
  }

}