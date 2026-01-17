import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> mypages = [
  // create the custom widget
  {
    "icons": FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    "color": Colors.yellow,
    "name": "Food",
    "totalamount": "-\$40",
    "date": "Today",
  },
  {
    "icons": FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    "color": Colors.purple,
    "name": "Shpping",
    "totalamount": "-\$234.4",
    "date": "Today",
  },
  {
    "icons": FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white),
    "color": Colors.green,
    "name": "Health",
    "totalamount": "-\$78.0",
    "date": "Yesterday",
  },
  {
    "icons": FaIcon(FontAwesomeIcons.plane, color: Colors.white),
    "color": Colors.blue,
    "name": "Plane",
    "totalamount": "-\$40.90",
    "date": "yesterday",
  },
];
