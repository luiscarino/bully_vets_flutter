import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bully Vets',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: VetListWidget(title: "Bully Vets"),
    );
  }
}

class VetListWidget extends StatefulWidget {
  VetListWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _VetListWidgetState createState() => _VetListWidgetState();
}

class _VetListWidgetState extends State<VetListWidget> {
  final Set<VetDirectory> _saved = new Set<VetDirectory>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("vets").snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> documents) {
    return new ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: documents.map((document) => _buildListItem(context, document)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final model = VetDirectory.fromSnapshot(document);

    return new Container(
        child: ListTile(
      title: new Text(model.veterinarian, style: _biggerFont),
      trailing: new Icon(Icons.navigate_next),
      onTap: () {
        setState(() {
          print(model.toString());
        });
      },
    ),
    decoration: new BoxDecoration(
        border: new Border(bottom:new BorderSide(width: 0.1))),);
  }

  /*/
   * generates the ListTile rows.
   * The divideTiles() method of ListTile adds horizontal
   * spacing between each ListTile.
   * The divided variable holds the final rows,
   * converted to a list by the convenience function, toList().
   */
  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((VetDirectory model) {
        return new ListTile(
          title: new Text(model.veterinarian, style: _biggerFont),
        );
      });
      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: const Text('Favorites'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}

class VetDirectory {
  final String state;
  final String city;
  final String practiceName;
  final String veterinarian;
  final String phoneNumber;

  final DocumentReference documentReference;

  VetDirectory.fromMap(Map<String, dynamic> map, {this.documentReference})
      : assert(map['Veterinarians'] != null),
        state = map['State'],
        city = map['City'],
        practiceName = map['Practice Name'],
        veterinarian = map['Veterinarians'],
        phoneNumber = map['Phone'];

  VetDirectory.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data,
            documentReference: documentSnapshot.reference);

  @override
  String toString() => "VetDirectory<$practiceName>";
}
