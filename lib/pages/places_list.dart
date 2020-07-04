import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place.dart';
import './places_details.dart';

import '../Providers/places.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorite Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlace.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: Text('No places yet! Start adding!'),
                ),
                builder: (context, places, child) => places.items.length <= 0
                    ? child
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(places.items[index].image),
                          ),
                          title: Text(places.items[index].title),
                          subtitle: Text(
                              '${places.items[index].location.latitude.toStringAsFixed(2)} ${places.items[index].location.langitude.toStringAsFixed(2)}'),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PlaceDetails.routeName,
                                arguments: places.items[index].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
