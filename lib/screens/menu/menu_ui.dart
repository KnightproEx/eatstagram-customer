import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc/restaurant_bloc.dart';
import '../../components/chip/default_filter_chip.dart';
import '../../models/menu_model.dart';
import '../../utils/round_number.dart';
import 'bloc/menu_bloc.dart';
import 'menu_bottom_sheet.dart';

class MenuUI extends StatefulWidget {
  @override
  _MenuUIState createState() => _MenuUIState();
}

class _MenuUIState extends State<MenuUI> {
  MenuBloc _menuBloc;
  List<MenuModel> _menuList;
  List<String> _categoryList;
  TextEditingController _searchController;

  @override
  void didChangeDependencies() {
    _searchController = TextEditingController();
    _menuBloc = BlocProvider.of<MenuBloc>(context);
    _menuList = [];
    _categoryList = [];

    _menuBloc.add(FetchMenu(
      BlocProvider.of<RestaurantBloc>(context).restaurant.id,
    ));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            onChanged: (value) => _menuBloc.add(SearchMenu(value)),
            controller: _searchController,
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
        ),

        // Category chip
        BlocConsumer<MenuBloc, MenuState>(
          buildWhen: (_, current) =>
              current is! MenuLoaded || current is! MenuSearchLoaded,
          listenWhen: (_, current) => current is MenuLoaded,
          listener: (_, state) {
            if (state is MenuLoaded) {
              _menuList = state.menuList;
              _categoryList.clear();

              for (MenuModel menu in _menuList) {
                if (!_categoryList.contains(menu.category)) {
                  _categoryList.add(menu.category);
                }
              }
            }
          },
          builder: (_, state) {
            List<DefaultFilterChip> chipList = [];

            for (String category in _categoryList) {
              chipList.add(
                DefaultFilterChip(
                  text: category,
                  onSelected: (selected) {
                    _searchController.clear();
                    _menuBloc.add(FilterMenu(category));
                  },
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
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.network(
                            _menuList[index].imagePath,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 160,
                            left: 15,
                            child: Container(
                              width: 320,
                              child: Text(
                                _menuList[index].name,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: 15,
                            child: Container(
                              width: 340,
                              child: Text(
                                _menuList[index].desc,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
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
