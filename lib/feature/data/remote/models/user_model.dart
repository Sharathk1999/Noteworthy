import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteworthy/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
  }) : super(
          name: name,
          email: email,
          uid: uid,
          status: status,
          password: password,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      status: documentSnapshot.get('status'),
      name: documentSnapshot.get('name'),
      email: documentSnapshot.get('email'),
      uid: documentSnapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "uid": uid,
      "email": email,
      "name": name,
    };
  }
}
