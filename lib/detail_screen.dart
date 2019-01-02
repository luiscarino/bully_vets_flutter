import 'package:bully_vets_app/vet.dart';
import 'package:flutter/material.dart';

class DetailScreenWidget extends StatelessWidget {
  final Veterinarian model;

  DetailScreenWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCard(model);
  }
}

_buildCard(Veterinarian model) {
  return SizedBox(
    height: 210,
    child: Card(
      child: Column(
        children: _buildCardInformation(model),
      ),
    ),
  );
}

List<Widget> _buildCardInformation(Veterinarian model) {
  return [
    ListTile(
      title: Text("${model.phoneNumber}",
          style: TextStyle(fontWeight: FontWeight.w500)),
      leading: Icon(
        Icons.contact_phone,
      ),
    ),
    ListTile(
      title: Text("${model.city}", style: TextStyle(fontWeight: FontWeight.w500)),
      leading: Icon(
        Icons.location_city,
      ),
    ),
    ListTile(
      title: Text("${model.email}"),
      leading: Icon(
        Icons.contact_mail,
      ),
    ),
  ];
}

Widget _buildHeader(BuildContext context, Veterinarian model) {
  return Stack(
    alignment: const Alignment(0.0, 0.0),
    children: [
      backgroundGradient,
      Container(
        decoration: BoxDecoration(
          color: Colors.black45,
        ),
        child: Text(
          model.veterinarian,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

var backgroundGradient = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
      colors: [
        const Color(0xFFFFFFEE),
        const Color(0xFF999999)
      ], // whitish to gray
    ),
  ),
);
