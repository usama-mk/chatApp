import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_snaps/ApiPaths/ApiPath.dart';
import 'package:com_snaps/Model/Msg.dart';
import 'package:com_snaps/helper/constants.dart';
import 'package:flutter/cupertino.dart';

import 'T.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
      print('zzzzzzzzzzz DB ADD USER error');
    });
    print('zzzzzzzzzzz IN DB ADD USER');
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) async {
    return await Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> createMsg(msgDetails) {
    Firestore.instance.collection('chats').add(msgDetails);
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
      print('error in add msggggggggg');
    });
  }

  Stream<List<T>> getUserChats() {
    final reference = Firestore.instance.collection("/ChatRoom");
    final snapshots =
        reference.where('arr', arrayContains: Constants.myName).snapshots();
    return snapshots.map((coll) =>
        coll.documents.map((doc) => T(doc.data['chatRoomId'])).toList());
    // snapshots.listen((snapshot) {
    //   snapshot.documents.forEach((snapshot) {
    //     print('chatRoomId');
    //     print(snapshot['chatRoomId']);
    //     print('above ChatRoomID');
    //   });
  }
  // return snapshots.map((coll) => coll.documents.map((docs) {
  //       print(docs.data['chatRoomId']);
  //       return (Text(docs.data['chatRoomId']));
  //     }).toList());

  ///////////////////////////////////////////////////////////
  Future<void> addChat(Msg msg, mutualId) async {
    final path = ApiPath.chatsPath(mutualId);
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(msg.toMap());
  }

  Stream<List<Msg>> readChat(mutualId) {
    print(mutualId);
    final path = ApiPath.chatsPathRead(mutualId);
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();

    return snapshots.map((collSnapshots) => collSnapshots.documents
        .map((docSnapshot) => Msg(
              time: docSnapshot.data['time'],
              msg: docSnapshot.data['msg'],
              name: docSnapshot.data['name'],
            ))
        .toList());

    // snapshots.listen((snapshotsList) {
    //   print('inside list of collection snaps');
    //   print(snapshotsList.documents[0]['msg']);
    //   snapshotsList.documents.forEach((snapshot) {
    //     print('inside list of document snaps');
    //     print(snapshot.data);
    //   });
    // });
  }

  Stream<List<Msg>> recentUsers() {
    final path = ApiPath.recentUsersPathRead();
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();

    return snapshots.map((collSnapshots) => collSnapshots.documents
        .map((docSnapshot) => Msg(
            time: docSnapshot.data['time'],
            msg: docSnapshot.data['msg'],
            name: docSnapshot.data['name']))
        .toList());
  }

  setIdentity(mp) async {
    final path = ApiPath.identityPathSet();
    final documentReference = Firestore.instance.document(path);
    await documentReference.setData(mp);
  }
}
