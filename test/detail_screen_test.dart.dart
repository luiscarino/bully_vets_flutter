import 'package:bully_vets_app/VeterinarianListModel.dart';
import 'package:bully_vets_app/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bully_vets_app/main.dart';

void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets("detail screen test widget", (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    var vetModel = VeterinarianListModel(
        state: "FL",
        city: "Orlando",
        practiceName: "Dr. Strange",
        veterinarian: "Dr. X",
        phoneNumber: "999-9999-999",
        email: "email@vet.com",
        imageUrl: "image.png");
    await tester.pumpWidget(MyApp());

    final finderTitle = find.text("Bulldog Vet Finder");
    expect(finderTitle, findsOneWidget);˚

  });
}
