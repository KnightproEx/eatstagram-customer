import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/restaurant_bloc/restaurant_bloc.dart';
import '../../components/appbar/default_appbar.dart';
import '../../components/input/default_drop_down.dart';
import 'bloc/meal_option_bloc.dart';

class MealOptionUI extends StatefulWidget {
  @override
  _MealOptionUIState createState() => _MealOptionUIState();
}

class _MealOptionUIState extends State<MealOptionUI> {
  List<String> _itemList;

  @override
  void didChangeDependencies() {
    BlocProvider.of<RestaurantBloc>(context).setTable(1);

    _itemList = BlocProvider.of<RestaurantBloc>(context).tableList;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: DefaultAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Select your meal option',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // Sliding Switch
                  SlidingSwitch(
                    value: false,
                    onChanged: (_) => BlocProvider.of<MealOptionBloc>(context)
                        .add(ToggleSwitch()),
                    width: 250,
                    height: 55,
                    textOff: "Dine in",
                    textOn: "Take away",
                  ),

                  SizedBox(height: 50),

                  BlocConsumer<MealOptionBloc, bool>(
                    listener: (context, state) {
                      BlocProvider.of<RestaurantBloc>(context)
                          .setTable(state ? 0 : 1);
                    },
                    builder: (_, state) {
                      return state
                          // display when take away is selected
                          ? Image.asset(
                              'assets/images/take_away.png',
                              height: 300.0,
                              fit: BoxFit.contain,
                            )

                          // display when dine in is selected
                          : _itemList.length > 0
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        'Table Number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      subtitle: Container(
                                        height: 50.0,
                                        width: 250,
                                        child: DefaultDropDown(
                                          _itemList,
                                          onChanged: (value) =>
                                              BlocProvider.of<RestaurantBloc>(
                                                      context)
                                                  .setTable(int.parse(value)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Text(
                                    'No table available!',
                                    style: TextStyle(
                                      color: Color(0xffaaaaaa),
                                    ),
                                  ),
                                );
                    },
                  ),
                ],
              ),
            ),
          ),

          // If table count is 0 show empty container instead of button
          BlocBuilder<MealOptionBloc, bool>(
            builder: (context, state) {
              return state || (!state && _itemList.length > 0)
                  ? Container(
                      height: 50.0,
                      width: width - 100,
                      margin: const EdgeInsets.only(bottom: 50.0),
                      child: RaisedButton.icon(
                          icon: Text('CONTINUE'),
                          label: Icon(Icons.arrow_forward),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(EmptyCart());
                            Navigator.of(context).pushNamed('/Menu');
                          }),
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
