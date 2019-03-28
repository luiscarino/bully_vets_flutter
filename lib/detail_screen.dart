import 'package:bully_vets_app/VeterinarianListModel.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreenWidget extends StatelessWidget {
  final VeterinarianListModel model;

  DetailScreenWidget({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDetailScreen(model);
  }
}

_buildDetailScreen(VeterinarianListModel model) {
  return new ListView(
    children: <Widget>[_buildHeader(model), _buildCard(model)],
  );
}

_buildCard(VeterinarianListModel model) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: SizedBox(
      child: Card(
        child: Column(
          children: _buildCardInformation(model),
        ),
      ),
    ),
  );
}

List<Widget> _buildCardInformation(VeterinarianListModel model) {
  return [
    ListTile(
      title: Text("${model.phoneNumber}",
          style: TextStyle(fontWeight: FontWeight.w500)),
      leading: new Container(
          width: 35.0,
          height: 35.0,
          child: new Icon(Icons.call),
          decoration:
              new BoxDecoration(shape: BoxShape.circle, color: Colors.blue)),
      onTap: () {
        _call(model);
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

Widget _buildHeader(VeterinarianListModel model) {
  return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: new Container(
              width: 120.0,
              height: 120.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('images/vet_icon.png')))),
        ),
        new Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(model.veterinarian, textScaleFactor: 1.5)),
      ]);
}

Widget _buildImageHeader(String url) {
  return SizedBox(
    child:
        FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: url),
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

_call(VeterinarianListModel model) {
  _launchURL("tel:" + model.phoneNumber);
}

_launchURL(String url) async {
  //https://github.com/flutter/flutter/issues/16864
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
