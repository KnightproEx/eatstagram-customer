import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc/restaurant_bloc.dart';
import '../../models/restaurant_model.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  bool _loaded = true;

  @override
  Widget build(BuildContext context) {
    final RestaurantModel _restaurant =
        BlocProvider.of<RestaurantBloc>(context).restaurant;

    return Drawer(
      child: Column(
        children: [
          //Profile picture
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _loaded
                        ? NetworkImage(_restaurant.imagePath)
                        // TODO: placeholder image
                        : AssetImage('assets/images/restaurantpic.jpg'),
                    onBackgroundImageError: (_, __) =>
                        setState(() => _loaded = false),
                  ),
                ),
              ],
            ),
          ),
          //Preferences
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _restaurant.title,
                ),
              ),
              Divider(
                indent: 70,
                height: 5,
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _restaurant.desc,
                  ),
                ),
              ),
              Divider(
                indent: 70,
                height: 5,
              ),
              ListTile(
                leading: Icon(Icons.call),
                title: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _restaurant.email,
                ),
              ),
              Divider(
                indent: 70,
                height: 5,
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text('Not at ${_restaurant.title}?'),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FlatButton.icon(
              icon: Icon(Icons.arrow_back_rounded),
              label: Text('Back'),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/Scanner',
                (_) => false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
