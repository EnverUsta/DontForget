import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/capel_item.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference capelCollection =
      Firestore.instance.collection('capels');

  Future<void> addNewCapel(CapelItem capelItem) async {
    await capelCollection.document(uid).collection('capelList').add(
      {
        'title': capelItem.title,
        'subtitle': capelItem.subtitle,
        'isFinished': false,
        'startingTime': capelItem.startTime,
        'level': capelItem.level,
        'term': capelItem.term,
      },
    );
  }

  Future<void> updateCapel(CapelItem capelItem) async {
    await capelCollection
        .document(uid)
        .collection('capelList')
        .document(capelItem.id)
        .updateData({
      'level': capelItem.level + 1,
    });
    if (capelItem.level + 1 == 5) {
      await capelCollection
          .document(uid)
          .collection('capelList')
          .document(capelItem.id)
          .updateData({
        'isFinished': true,
      });
    }
  }

  Future<void> deleteCapel(String capelItemId) async {
    await capelCollection
        .document(uid)
        .collection('capelList')
        .document(capelItemId)
        .delete();
  }

  List<CapelItem> _listOfCapelItemsFromQuerySnapshot(QuerySnapshot qSnapshot) {
    return qSnapshot.documents
        .map(
          (docSnap) => CapelItem(
            id: docSnap.documentID,
            title: docSnap.data['title'],
            subtitle: docSnap.data['subtitle'],
            term: docSnap.data['term'],
            level: docSnap.data['level'],
            isFinished: docSnap.data['isFinished'],
          ),
        )
        .toList();
  }

  Stream<List<CapelItem>> get capel {
    return capelCollection
        .document(uid)
        .collection('capelList')
        .orderBy('startingTime')
        .snapshots()
        .map((event) => _listOfCapelItemsFromQuerySnapshot(event));
  }
}
