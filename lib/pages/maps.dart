import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class Map extends StatefulWidget {
  final PlaceLocation initialLoacation;
  final bool isSelecting;

  Map(
      {this.initialLoacation =
          const PlaceLocation(latitude: 37.422, langitude: -122.084),
      this.isSelecting = false});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng _pickedloc;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedloc = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedloc == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedloc);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLoacation.latitude,
            widget.initialLoacation.langitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedloc == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedloc ??
                      LatLng(
                        widget.initialLoacation.latitude,
                        widget.initialLoacation.langitude,
                      ),
                ),
              },
      ),
    );
  }
}
