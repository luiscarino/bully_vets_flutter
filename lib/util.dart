import 'package:bully_vets_app/dummy_vets_snapshot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void populateDatabase() {
  var fireStoreInstance = Firestore.instance;
  var batch = fireStoreInstance.batch();
  void iterateMapList(map) {
    var newDocument = fireStoreInstance.collection("vets").document();
    batch.setData(newDocument, map);
  }
  dummySnapshot.forEach(iterateMapList);
  batch.commit();

}