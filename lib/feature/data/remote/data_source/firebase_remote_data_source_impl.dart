import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteworthy/feature/data/remote/data_source/firebase_remote_data_source.dart';
import 'package:noteworthy/feature/data/remote/models/note_model.dart';
import 'package:noteworthy/feature/data/remote/models/user_model.dart';
import 'package:noteworthy/feature/domain/entities/note_entity.dart';
import 'package:noteworthy/feature/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> addNewNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection("users").doc(noteEntity.uid).collection("notes");
    final noteId = noteCollectionRef.doc().id;

    final newNote = NoteModel(
      uid: noteEntity.uid,
      noteId: noteId,
      note: noteEntity.note,
      time: noteEntity.time,
    ).toDocument();

    noteCollectionRef.doc(noteId).get().then(
      (note) {
        if (!note.exists) {
          noteCollectionRef.doc(noteId).set(newNote);
        }
        return;
      },
    );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> deleteNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection("users").doc(noteEntity.uid).collection("notes");

    noteCollectionRef.doc(noteEntity.noteId).get().then(
      (note) {
        if (note.exists) {
          noteCollectionRef.doc(noteEntity.noteId).delete();
        }
        return;
      },
    );
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUID();

    userCollectionRef.doc(user.uid).get().then(
      (value) {
        final newUser = UserModel(
          uid: uid,
          status: user.status,
          email: user.email,
          name: user.name,
        ).toDocument();
        if (!value.exists) {
          userCollectionRef.doc(uid).set(newUser);
        }
        return;
      },
    );
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollectionRef = firestore.collection("users").doc(uid).collection("notes");
    return noteCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs.map((docSnap) => NoteModel.fromSnapshot(docSnap)).toList();
    },);
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => 
  auth.signInWithEmailAndPassword(email: user.email!, password: user.password!);

  @override
  Future<void> signOut() => auth.signOut();


  @override
  Future<void> signUp(UserEntity user) async =>
   auth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);

  @override
  Future<void> updateNote(NoteEntity note)async {
    Map<String, dynamic> noteMap= {};
    final noteCollectionRef = firestore.collection("users").doc(note.uid).collection("notes");

    if(note.note != null) noteMap['note']=note.note;
    if(note.time != null) noteMap['time']=note.time;

    noteCollectionRef.doc(note.noteId).update(noteMap);

  }
}
