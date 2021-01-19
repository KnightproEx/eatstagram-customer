import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc/restaurant_bloc.dart';

class ScannerUI extends StatefulWidget {
  @override
  _ScannerUIState createState() => _ScannerUIState();
}

class _ScannerUIState extends State<ScannerUI> {
  RestaurantBloc _scannerBloc;

  @override
  void didChangeDependencies() {
    _scannerBloc = BlocProvider.of<RestaurantBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                'Scan QR Code',
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Scan the QR code displayed in front of your desired restaurant',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.0, bottom: 60),
          child: Image.asset('assets/images/qr_sample.png'),
        ),
        Container(
          height: 50.0,
          width: _width - 100,
          margin: EdgeInsets.only(
            bottom: 50.0,
          ),
          child: RaisedButton.icon(
            icon: Text('CONTINUE'),
            label: Icon(Icons.arrow_forward),
            onPressed: () => _scannerBloc.add(Scan()),
          ),
        ),
      ],
    );
  }
}
