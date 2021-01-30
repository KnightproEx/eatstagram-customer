import 'package:equatable/equatable.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/network_exception.dart';
import '../../models/response_model.dart';
import '../../models/restaurant_model.dart';
import '../../services/main_api.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantModel _restaurant = RestaurantModel('', '', '', '', '', 0);
  int _table = 0;
  List<String> _tableList = [];

  RestaurantBloc() : super(RestaurantInitial());

  RestaurantModel get restaurant => _restaurant;
  int get table => _table;

  List<String> get tableList {
    _tableList = [];

    for (int i = 1; i <= _restaurant.tableCount; i++) {
      _tableList.add(i.toString());
    }

    return _tableList;
  }

  void setTable(int table) {
    if (table < 0 || table > _restaurant.tableCount) {
      _table = 0;
      return;
    }

    _table = table;
  }

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is Scan) {
      yield RestaurantLoading();

      try {
        String qr = await FlutterBarcodeScanner.scanBarcode(
          '#2f2f2f',
          'Cancel',
          true,
          ScanMode.QR,
        );

        if (qr == '-1') {
          return;
        }

        DataModel result = await DataModelApi().post(
          'customer/fetch_restaurant.php',
          {'id': qr},
        );

        if (result.isError) {
          throw NetworkException(result.errorMsg);
        }

        if (result.count != 1) {
          yield RestaurantError('Invalid restaurant QR!');
          return;
        }

        _restaurant = RestaurantModel.fromJson(result.data);

        yield RestaurantLoaded();
      } on FetchDataException catch (e) {
        yield RestaurantError(e.toString());
      } catch (e) {
        print(e.toString());
        yield RestaurantError('Something went wrong!');
      } finally {
        yield RestaurantInitial();
      }
    }
  }
}
