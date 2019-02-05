import 'package:bully_vets_app/detail_screen.dart';
import 'package:bully_vets_app/vet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: VetListWidget(title: "Bulldog Veterinarians \nDirectory"),
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
  final Set<Veterinarian> _saved = new Set<Veterinarian>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, textAlign: TextAlign.center,),
          centerTitle: true,
          actions: <Widget>[IconButton(icon: Icon(Icons.search), onPressed:(){})],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("vets").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> documents) {
    return new ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: documents
          .map((document) => _buildListItem(context, document))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final model = Veterinarian.fromSnapshot(document);

    return new Container(
      child: ListTile(
        title: new Text(model.practiceName, style: _biggerFont),
        trailing: new Icon(Icons.navigate_next),
        onTap: () {
          setState(() {
            _navigateToDetail(model);
          });
        },
      ),
      decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(width: 0.1))),
    );
  }

  void _navigateToDetail(Veterinarian model) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(model.practiceName),
        ),
        body: DetailScreenWidget(model: model),
      );
    }));
  }
}

