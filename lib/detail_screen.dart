import 'package:bully_vets_app/vet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreenWidget extends StatelessWidget {
  final Veterinarian model;

  DetailScreenWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDetailScreen(model);
  }
}

_buildDetailScreen(Veterinarian model) {
  return new ListView(
    children: <Widget>[_buildHeader(model), _buildCard(model)],
  );
}

_buildCard(Veterinarian model) {
  return SizedBox(
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
        title: Text("${model.veterinarian}",
            style: TextStyle(fontWeight: FontWeight.w500)),
        leading: Icon(
          Icons.person,
        )),
    Divider(),
    ListTile(
      title: Text("${model.phoneNumber}",
          style: TextStyle(fontWeight: FontWeight.w500)),
      leading: Icon(
        Icons.contact_phone,
      ),
      onTap: () {
        _launchURL("tel:" + model.phoneNumber); //https://github.com/flutter/flutter/issues/16864
      },
    ),
    Divider(),
    ListTile(
      title: Text("${model.city}, ${model.state}",
          style: TextStyle(fontWeight: FontWeight.w500)),
      leading: Icon(
        Icons.location_city,
      ),
    ),
    Divider(),
    ListTile(
      title: Text(model.email != null ? "${model.email}" : ""),
      leading: Icon(
        Icons.contact_mail,
      ),
    ),
  ];
}

Widget _buildHeader(Veterinarian model) {
  return Stack(
    children: [
      Center(child: CircularProgressIndicator()),
      _buildImageHeader(model.imageUrl),
    ],
  );
}

Widget _buildImageHeader(String url) {
  return SizedBox(
    child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: url),
  );
}

var backgroundGradient = SizedBox(
    child: Container(
  height: 310,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment(0.8, 0.0),
      // 10% of the width, so there are ten blinds.
      colors: [
        const Color(0xFFFFFFEE),
        const Color(0xFF999999)
      ], // whitish to gray
    ),
  ),
));

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}