import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:evently_c19/model/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/event.dart';

class FirestoreManager {
  static CollectionReference<User> getUserCollection() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter<User>(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return User.fromFireStore(data);
      },
      toFirestore: (User value, SetOptions? options) {
        return value.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> saveUser(User user) {
    var collection = getUserCollection();
    var document =
    collection.doc(auth.FirebaseAuth.instance.currentUser!.uid);
    return document.set(user);
  }

  static Future<User?> getUser() async {
    var collection = getUserCollection();
    var doc =
    collection.doc(auth.FirebaseAuth.instance.currentUser!.uid);
    var docSnapShot = await doc.get();
    var user = docSnapShot.data();
    return user;
  }

  static CollectionReference<Event> getEventCollection() {
    var collection = FirebaseFirestore.instance
        .collection("Event")
        .withConverter<Event>(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return Event.fromFirestore(data);
      },
      toFirestore: (Event event, SetOptions? options) {
        return event.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> addEvent(Event event) {
    var collection = getEventCollection();
    var doc = collection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docsList = querySnapshot.docs;
    var eventList = docsList.map((doc) => doc.data()).toList();
    return eventList;
  }

  static Stream<List<Event>> getAllEventsRealTime() async* {
    var collection = getEventCollection();
    var querySnapshotStream = collection.snapshots();
    var docsStream =
    querySnapshotStream.map((querySnapshot) => querySnapshot.docs);
    var eventsStream = docsStream.map(
            (docs) => docs.map((document) => document.data()).toList());
    yield* eventsStream;
  }

  static Future<List<Event>> getFilteredEvents(String type) async {
    var collection =
    getEventCollection().where("type", isEqualTo: type);
    var querySnapshot = await collection.get();
    var docsList = querySnapshot.docs;
    var eventList = docsList.map((doc) => doc.data()).toList();
    return eventList;
  }

  static CollectionReference<Event> getFavoritesCollection() {
    var userCollection = getUserCollection();
    var userDoc = userCollection
        .doc(auth.FirebaseAuth.instance.currentUser!.uid);
    var collection =
    userDoc.collection("Favorite").withConverter<Event>(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return Event.fromFirestore(data);
      },
      toFirestore: (Event event, SetOptions? options) {
        return event.toFirestore();
      },
    );
    return collection;
  }

  static Future<void> addFavoriteEvent(Event event) {
    var collection = getFavoritesCollection();
    var docRef = collection.doc(event.id);
    return docRef.set(event);
  }

  static Future<void> deleteFavoriteEvent(Event event) {
    var collection = getFavoritesCollection();
    var docRef = collection.doc(event.id);
    return docRef.delete();
  }

  static Stream<List<Event>> getFavoritesList() async* {
    var collection = getFavoritesCollection();
    var querySnapshotStream = collection.snapshots();
    var docsStream =
    querySnapshotStream.map((querySnapshot) => querySnapshot.docs);
    var eventsStream = docsStream.map(
            (docs) => docs.map((document) => document.data()).toList());
    yield* eventsStream;
  }

  static Future<void> updateEvent(Event event) {
    var collection = getEventCollection();
    var doc = collection.doc(event.id);
    return doc.set(event);
  }

  static Future<void> deleteEvent(String eventId) {
    var collection = getEventCollection();
    var doc = collection.doc(eventId);
    return doc.delete();
  }

  static Future<void> updateUserFavorites(List<String> favorites) {
    var collection = getUserCollection();
    var doc =
    collection.doc(auth.FirebaseAuth.instance.currentUser!.uid);
    return doc.update({"favorites": favorites});
  }

  // ── Google Sign-In (google_sign_in v7.2.0) ───────────────────────
  static Future<auth.UserCredential> signInWithGoogle() async {
    await GoogleSignIn.instance.signOut();

    // authenticate() throws on failure instead of returning null
    final GoogleSignInAccount googleUser =
    await GoogleSignIn.instance.authenticate();

    // authentication is now SYNCHRONOUS in v7
    final idToken = googleUser.authentication.idToken;

    // authorizeScopes() is still async
    final clientAuth = await googleUser.authorizationClient
        .authorizeScopes(['email', 'profile']);

    final credential = auth.GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: clientAuth.accessToken,
    );

    final userCredential =
    await auth.FirebaseAuth.instance.signInWithCredential(credential);

    // If new user, create Firestore doc
    if (userCredential.additionalUserInfo?.isNewUser ?? false) {
      await saveUser(User(
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        id: userCredential.user!.uid,
      ));
    }

    return userCredential;
  }
}