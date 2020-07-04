import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Providers/places.dart';

import './pages/places_list.dart';
import './pages/add_place.dart';
import './pages/places_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Your Favorite',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
          PlaceDetails.routeName: (ctx) => PlaceDetails(),
        },
      ),
    );
  }
}
