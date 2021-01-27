import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc/restaurant_bloc.dart';
import '../../models/menu_model.dart';
import '../../utils/round_number.dart';
import 'bloc/menu_bloc.dart';
import 'menu_bottom_sheet.dart';

class MenuUI extends StatefulWidget {
  @override
  _MenuUIState createState() => _MenuUIState();
}

class _MenuUIState extends State<MenuUI> {
  MenuBloc _homeBloc;
  List<MenuModel> _menuList;
  List<String> _categoryList;
  var _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    _homeBloc = BlocProvider.of<MenuBloc>(context);
    _menuList = [];
    _categoryList = [];

    String id = BlocProvider.of<RestaurantBloc>(context).restaurant.id;
    _homeBloc.add(FetchMenu(id));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Search bar
        Container(
          margin: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            bottom: 10.0,
          ),
          child: TextField(
            onChanged: (value) => _homeBloc.add(SearchMenu(value)),
            controller: _controller,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 17),
              hintText: 'Let\'s find good food',
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black.withOpacity(0.9),
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          // child: DefaultTextfield(
          //   hintText: 'Let\'s find good food',
          //   suffixIcon: Icons.search,
          // ),
        ),

        // Food cuisine chip
        BlocConsumer<MenuBloc, MenuState>(
          buildWhen: (_, current) =>
              current is! MenuLoaded || current is! MenuSearchLoaded,
          listenWhen: (_, current) => current is MenuLoaded,
          listener: (_, state) {
            if (state is MenuLoaded) {
              _menuList = state.menuList;
              _categoryList.clear();

              for (MenuModel menu in _menuList) {
                _categoryList.add(menu.category);
              }
            }
          },
          builder: (_, state) {
            if (state is MenuLoading) {
              return Container();
            }

            List<GestureDetector> chipList = [];

            for (String category in _categoryList) {
              chipList.add(
                GestureDetector(
                  onTap: () => _controller.text = category,
                  child: Chip(
                    label: Text(
                      category,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: chipList,
              ),
            );
          },
        ),

        // Menu cards
        BlocBuilder<MenuBloc, MenuState>(
          buildWhen: (_, current) => current is! MenuError,
          builder: (_, state) {
            if (state is MenuLoading) {
              return LinearProgressIndicator();
            }

            if (state is MenuLoaded) {
              _menuList = state.menuList;
            }

            if (state is MenuSearchLoaded) {
              _menuList = state.menuList;
            }

            return Expanded(
              child: ListView.builder(
                itemCount: _menuList.length,
                itemBuilder: (_, index) {
                  return Container(
                    height: 270,
                    child: Card(
                      margin: const EdgeInsets.only(
                        top: 5.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 5.0,
                      ),
                      elevation: 7.0,
                      // Prevents picture from overriding card borders
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.network(
                              // TODO: placeholder image
                              // TODO: loading builder
                              // TODO: error builder
                              _menuList[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 160,
                            left: 15,
                            child: Text(
                              _menuList[index].name,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: 15,
                            child: Text(
                              _menuList[index].desc,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 15,
                            child: Chip(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              label: Text(
                                  '\R\M${roundCurrency(_menuList[index].price, 2)}'),
                            ),
                          ),
                          Positioned(
                            top: 180.0,
                            right: 15.0,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle_outlined,
                                color: Colors.white.withOpacity(0.9),
                                size: 32,
                              ),
                              onPressed: () => showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                builder: (_) =>
                                    MenuBottomSheet(_menuList[index]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
