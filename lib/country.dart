import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'model/country_model.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Dio dio = Dio();
  Response response;
  List<CountryData> listCountry = [];
  List<CountryData> searchList = [];
  var templist;
  TextEditingController controller = TextEditingController();
  initValue() async {
    var res = await getData();
    if (res != null) {
      setState(() {
        searchList = listCountry;
      });
    }
  }

  @override
  void initState() {
    initValue();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                searchCountry(value);
              },
              style: TextStyle(
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.greenAccent,
                    width: 5.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.data == null) {
                  return Container(
                    child: Text(
                      "No connection",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return createListCountry();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Column createListCountry() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: searchList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title:
                            Text('${searchList[index].country.toUpperCase()}'),
                        content: Text(
                            'Cases per one million:${searchList[index].casesPerOneMillion}\nDeaths per one mllion:${searchList[index].deathsPerOneMillion}\nTotal tests:${searchList[index].totalTests}'),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.grey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '${searchList[index].country}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Cases:${searchList[index].cases} | Today:${searchList[index].todayCases} | Active:${searchList[index].active}',
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Deaths:${searchList[index].deaths} | Today:${searchList[index].todayDeaths}',
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Recovered:${searchList[index].recovered} | Critical:${searchList[index].critical}',
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  getData() async {
    try {
      response =
          await dio.get('https://coronavirus-19-api.herokuapp.com/countries');
      if (response.data != null) {
        print(response.data);
        templist = response.data;
        print('temp:' + templist.toString());
        listCountry = [];
        templist.forEach((element) {
          CountryData newCountry = CountryData.fromJson(element);
          listCountry.add(newCountry);
        });
        return response.data;
      } else
        return [];
    } catch (e) {
      return null;
    }
  }

  searchCountry(String text) {
    if (text == '') {
      setState(() {
        searchList = listCountry;
      });
    } else {
      setState(() {
        listCountry.forEach((element) {
          if (element.country.toLowerCase().contains(text.toLowerCase())) {
            searchList = [];
            searchList.add(element);
          }
        });
      });
      setState(() {});
    }
  }
}
