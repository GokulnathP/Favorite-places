import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

import '../helpers/db_helper.dart';
// import '../helpers/location_helper.dart';

class Places extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addPlace(String title, File image, PlaceLocation pickedLocation) async {
    // final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.langitude);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: pickedLocation,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.langitude,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location:
                PlaceLocation(latitude: e['loc_lat'], langitude: e['loc_lng']),
            image: File(e['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
