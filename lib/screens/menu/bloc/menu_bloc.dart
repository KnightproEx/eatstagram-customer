import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../exceptions/network_exception.dart';
import '../../../models/menu_model.dart';
import '../../../models/response_model.dart';
import '../../../services/main_api.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  List<MenuModel> _menuList = [];

  MenuBloc() : super(MenuInitial());

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is FetchMenu) {
      yield MenuLoading();

      try {
        _menuList.clear();

        DataModel result = await DataModelApi().post(
          'customer/fetch_menu.php',
          {'id': event._id},
        );

        if (result.isError) {
          throw InvalidInputException(result.errorMsg);
        }

        for (Map<String, dynamic> map in result.data) {
          _menuList.add(MenuModel.fromJson(map));
        }

        yield MenuLoaded(_menuList);
      } on FetchDataException catch (e) {
        yield MenuError(e.toString());
      } catch (e) {
        print(e.toString());
        yield MenuError('Something went wrong!');
      } finally {
        yield MenuInitial();
      }
    }

    if (event is SearchMenu) {
      List<MenuModel> temp = [];

      for (MenuModel menu in _menuList) {
        String name = menu.name.toUpperCase();
        String search =
            event._search.toUpperCase().trim().replaceAll(RegExp(r'\s+'), ' ');

        if (!name.contains(search)) {
          continue;
        }

        temp.add(menu);
      }

      yield MenuSearchLoaded(temp);
    }
  }
}
