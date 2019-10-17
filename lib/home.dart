import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/detail.dart';
import 'package:flutter_app/models/coincollection.dart';
import 'package:flutter_app/models/tabmodel.dart';
import 'package:flutter_app/services/coinservice.dart';
import 'package:flutter_app/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorTopCoinKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorAllCoinKey =
      GlobalKey<RefreshIndicatorState>();
  final List<TabModel> tabMenuList = TabModel.getInitialTabMenu();
  final UserService userService = UserService();
  var random = new Random();
  int startpage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startpage = random.nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: tabMenuList.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                onPressed: () {
                  showAlertLogout();
                },
              )
            ],
            bottom: TabBar(
                tabs: tabMenuList.map((TabModel tab) {
              return Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(tab.icon),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(tab.title),
                    )
                  ],
                ),
              );
            }).toList()),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: FutureBuilder<List<Coin>>(
                  future: CoinService.getCoinList(start: 0, limit: 0),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        key: refreshIndicatorTopCoinKey,
                        onRefresh: handleRefresh,
                        child: generateTopCoinTab(coinList: snapshot.data),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),
              Center(
                child: FutureBuilder<List<Coin>>(
                  future: CoinService.getCoinList(
                      start: startpage, limit: 200),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        key: refreshIndicatorAllCoinKey,
                        onRefresh: handleRefresh,
                        child: generateAllCoinTab(coinList: snapshot.data),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generateTopCoinTab({List<Coin> coinList}) {
    return ListView.builder(
      itemCount: coinList.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            generateTopCoinList(coin: coinList[index]),
            Divider(
              height: 2,
              color: Colors.grey.shade300,
            ),
          ],
        );
      },
    );
  }

  Widget generateTopCoinList({Coin coin}) {
    return GestureDetector(
      child: ListTile(
        leading: ClipOval(
          child: FadeInImage.memoryNetwork(
            height: 50,
            width: 50,
            placeholder: kTransparentImage,
            image: "https://www.coinlore.com/img/${coin.nameid}.png",
          ),
        ),
        title: Text("#${coin.rank} ${coin.name}"),
        subtitle: Text("${coin.symbol}"),
        trailing: Card(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              "฿ ${(double.parse(coin.priceUsd) * 30.28).toStringAsFixed(2)}",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Detail(coin: coin),
          ),
        );
      },
    );
  }

  Widget generateAllCoinTab({List<Coin> coinList}) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: coinList.length,
      itemBuilder: (context, index) {
        return generateAllCoinCard(coin: coinList[index]);
      },
    );
  }

  Widget generateAllCoinCard({Coin coin}) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              FadeInImage.memoryNetwork(
                height: 50,
                width: 50,
                placeholder: kTransparentImage,
                image: "https://www.coinlore.com/img/${coin.nameid}.png",
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${coin.name}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "${coin.symbol}",
                style: TextStyle(color: Colors.black45),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                child: Text(
                  "฿ ${(double.parse(coin.priceUsd) * 30.28).toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Detail(coin: coin),
          ),
        );
      },
    );
  }

  Future<Null> handleRefresh() async {
    await Future.delayed(Duration(
      seconds: 2,
    ));

    setState(() {
      startpage = random.nextInt(100);
    });

    return null;
  }

  Future showAlertLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${prefs.getString(UserService.USERNAME)} to Logout."),
            content: Text("Are you sure?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  userService.logout();

                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (Route<dynamic> route) => false);
                },
                child: Text("Yes"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              )
            ],
          );
        });
  }
}
