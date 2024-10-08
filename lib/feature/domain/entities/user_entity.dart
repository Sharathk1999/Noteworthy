import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? uid;
  final String? status;
  final String? password;

 const UserEntity({
     this.name,
     this.email,
     this.uid,
     this.status = "I Love this app.",
     this.password,
  });

  @override

  List<Object?> get props => [
    name,
    email,
    uid,
    status,
    password,
  ];
}
