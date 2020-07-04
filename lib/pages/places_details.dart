import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/places.dart';
import './maps.dart';

class PlaceDetails extends StatelessWidget {
  static const routeName = '/place-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<Places>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${place.location.latitude.toStringAsFixed(2)} ${place.location.langitude.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => Map(
                    isSelecting: false,
                    initialLoacation: place.location,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
