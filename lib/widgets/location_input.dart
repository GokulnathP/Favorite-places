import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';

import '../pages/maps.dart';

import '../models/place.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation _pickedLoc;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final url = LocationHelper.generateImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    print(url);
    setState(() {
      _pickedLoc = PlaceLocation(
          langitude: locData.longitude, latitude: locData.latitude);
    });
    widget.selectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final selectedLoc = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => Map(
          initialLoacation: PlaceLocation(
              langitude: locData.longitude, latitude: locData.latitude),
          isSelecting: true,
        ),
      ),
    );
    if (selectedLoc == null) {
      return;
    }
    setState(() {
      _pickedLoc = PlaceLocation(
          langitude: selectedLoc.longitude, latitude: selectedLoc.latitude);
    });
    widget.selectPlace(selectedLoc.latitude, selectedLoc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _pickedLoc == null
              ? Center(
                  child: Text(
                    'No Location chosen!',
                    textAlign: TextAlign.center,
                  ),
                )
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _pickedLoc.latitude,
                      _pickedLoc.langitude,
                    ),
                    zoom: 16,
                  ),
                  onTap: null,
                  markers: {
                    Marker(
                      markerId: MarkerId('m1'),
                      position: LatLng(
                        _pickedLoc.latitude,
                        _pickedLoc.langitude,
                      ),
                    ),
                  },
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
