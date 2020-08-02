import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataGlobal {
  int cases;
  int deaths;
  int recovered;

  DataGlobal(
      {@required this.cases, @required this.deaths, @required this.recovered});
}

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  Dio dio = Dio();
  Response response;
  // DataGlobal globalData = DataGlobal(cases: 0, deaths: 0, recovered: 0);
  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.none ||
              snap.data == null) {
            return Container(
              color: Colors.black,
              child: Text('no connection'),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else if (snap.data != null &&
              snap.connectionState == ConnectionState.done) {
            return Container(
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    color: Color(0xff1a1b1e),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Global cases',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        ),
                        Text(
                          '${snap.data['cases']}',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    height: 150,
                    color: Color(0xff1a1b1e),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Global deaths',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        ),
                        Text(
                          '${snap.data['deaths']}',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    height: 150,
                    color: Color(0xff1a1b1e),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Global recovered',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        ),
                        Text(
                          '${snap.data['recovered']}',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  getData() async {
    try {
      response = await dio.get('https://coronavirus-19-api.herokuapp.com/all');
      print(response);
      // if (response.statusCode == 200) {
      //   int cases = response.data['cases'];
      //   int deaths = response.data['deaths'];
      //   int recovered = response.data['recovered'];
      //   setState(() {
      //     globalData =
      //         DataGlobal(cases: cases, deaths: deaths, recovered: recovered);
      //   });
      // }
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
