import 'package:bully_vets_app/VeterinarianListModel.dart';
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
        fontFamily: 'Raleway',
      ),
      home: VetListWidget(title: "Bulldog Veterinarians Finder"),
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
  final TextStyle _biggerFont =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
  final TextStyle _headerFont =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
          ),
          centerTitle: true,
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
    var map = _createVetMapFromDocuments(documents);
    var listWithStates = _createListWithStates(map);
    return new ListView(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      children: listWithStates
          .map((model) => _buildListItem(context, model))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, VeterinarianListModel model) {
    if (model.isHeader == null) {
      return new Container(
        child: ListTile(
          leading: const Icon(Icons.local_hospital),
          title: new Text(model.practiceName, style: _biggerFont),
          subtitle: new Text(model.city, style: _headerFont),
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
    } else {
      return new Container(
        child: ListTile(
          title: new Text(model.isHeader, style: _headerFont),
        ),
        decoration: new BoxDecoration(
            border: new Border(bottom: new BorderSide(width: 0.1))),
      );
    }
  }

  void _navigateToDetail(VeterinarianListModel model) {
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

  Map<String, List<Veterinarian>> _createVetMapFromDocuments(
      List<DocumentSnapshot> documents) {
    var veterinariansMap = new Map<String, List<Veterinarian>>();
    for (var doc in documents) {
      final vetModel = Veterinarian.fromSnapshot(doc);
      if (veterinariansMap.containsKey(vetModel.state)) {
        var key = vetModel.state;
        veterinariansMap[key].add(vetModel);
      } else {
        List<Veterinarian> list = new List();
        list.add(vetModel);
        veterinariansMap.putIfAbsent(vetModel.state, () => list);
      }
    }
    return veterinariansMap;
  }

  List<VeterinarianListModel> _createListWithStates(
      Map<String, List<Veterinarian>> map) {
    List<VeterinarianListModel> vets = new List();
    for (var stateKey in map.keys) {
      vets.add(new VeterinarianListModel(
          isHeader: US_STATES.containsKey(stateKey)
              ? US_STATES[stateKey]
              : stateKey));
      map[stateKey].forEach((vetModel) {
        vets.add(new VeterinarianListModel(
            state: vetModel.state,
            city: vetModel.city,
            practiceName: vetModel.practiceName,
            veterinarian: vetModel.veterinarian,
            phoneNumber: vetModel.phoneNumber,
            email: vetModel.email,
            imageUrl: vetModel.imageUrl));
      });
    }
    return vets;
  }

  static const Map<String, String> US_STATES = {
    "AL": "Alabama",
    "AK": "Alaska",
    "AS": "American Samoa",
    "AZ": "Arizona",
    "AR": "Arkansas",
    "CA": "California",
    "CO": "Colorado",
    "CT": "Connecticut",
    "DE": "Delaware",
    "DC": "District Of Columbia",
    "FM": "Federated States Of Micronesia",
    "FL": "Florida",
    "GA": "Georgia",
    "GU": "Guam",
    "HI": "Hawaii",
    "ID": "Idaho",
    "IL": "Illinois",
    "IN": "Indiana",
    "IA": "Iowa",
    "KS": "Kansas",
    "KY": "Kentucky",
    "LA": "Louisiana",
    "ME": "Maine",
    "MH": "Marshall Islands",
    "MD": "Maryland",
    "MA": "Massachusetts",
    "MI": "Michigan",
    "MN": "Minnesota",
    "MS": "Mississippi",
    "MO": "Missouri",
    "MT": "Montana",
    "NE": "Nebraska",
    "NV": "Nevada",
    "NH": "New Hampshire",
    "NJ": "New Jersey",
    "NM": "New Mexico",
    "NY": "New York",
    "NC": "North Carolina",
    "ND": "North Dakota",
    "MP": "Northern Mariana Islands",
    "OH": "Ohio",
    "OK": "Oklahoma",
    "OR": "Oregon",
    "PW": "Palau",
    "PA": "Pennsylvania",
    "PR": "Puerto Rico",
    "RI": "Rhode Island",
    "SC": "South Carolina",
    "SD": "South Dakota",
    "TN": "Tennessee",
    "TX": "Texas",
    "UT": "Utah",
    "VT": "Vermont",
    "VI": "Virgin Islands",
    "VA": "Virginia",
    "WA": "Washington",
    "WV": "West Virginia",
    "WI": "Wisconsin",
    "WY": "Wyoming"
  };
}
