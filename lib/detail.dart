import 'package:flutter/material.dart';
import 'package:flutter_app/models/coincollection.dart';
import 'package:transparent_image/transparent_image.dart';

class Detail extends StatelessWidget {
  Coin coin;

  Detail({this.coin});

  Color displayColor({double number}) {
    if (number < 0) {
      return Colors.red;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  generateHeader(),
                  SizedBox(height: 5),
                  Divider(),
                  generateDescription(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget generateHeader() {
    return ListTile(
      leading: ClipOval(
        child: FadeInImage.memoryNetwork(
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
    );
  }

  Widget generateDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Percent Change 24 hr",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Text(
                    "${coin.percentChange24H ?? 0}%",
                    style: TextStyle(
                      color: displayColor(
                        number: double.parse(coin.percentChange24H ?? "0"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Percent Change 1 hr",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Text(
                    "${coin.percentChange1H ?? 0}%",
                    style: TextStyle(
                      color: displayColor(
                        number: double.parse(coin.percentChange1H ?? "0"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Percent Change 7 Days",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Text(
                    "${coin.percentChange7D ?? 0}%",
                    style: TextStyle(
                      color: displayColor(
                        number: double.parse(coin.percentChange7D ?? "0"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Volumn 24 hr",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Text(
                    "${(coin.volume24 ?? 0).toStringAsFixed(2)}",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
