import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc/restaurant_bloc.dart';
import '../../components/appbar/default_appbar.dart';
import '../../models/restaurant_model.dart';

class Restaurant extends StatefulWidget {
  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  RestaurantModel _restaurant;
  bool _loaded = true;

  @override
  void didChangeDependencies() {
    _restaurant = BlocProvider.of<RestaurantBloc>(context).restaurant;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: Column(
        children: [
          //Restaurant name
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              _restaurant.title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 25),
            child: Text(
              _restaurant.desc,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),

          // Restaurant profile pic
          Center(
            child: CircleAvatar(
              radius: 110,
              backgroundColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: CircleAvatar(
                radius: 105,
                backgroundColor: Colors.grey[50],
                child: CircleAvatar(
                  radius: 100,
                  // TODO: placeholder image
                  backgroundImage: _loaded
                      ? NetworkImage(_restaurant.imagePath)
                      : AssetImage('assets/images/restaurantpic.jpg'),
                  onBackgroundImageError: (_, __) =>
                      setState(() => _loaded = false),
                ),
              ),
            ),
          ),

          SizedBox(height: 40),

          // Continue button
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.black.withOpacity(0.9),
                textColor: Colors.white,
                minWidth: 250,
                height: 42,
                padding: EdgeInsets.all(8.0),
                onPressed: () => Navigator.of(context).pushNamed('/MealOption'),
                child: Text(
                  'CONTINUE',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
