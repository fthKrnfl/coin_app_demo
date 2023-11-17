import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_coin_app/service/post_model.dart';
import 'package:loadmore/loadmore.dart';
//import 'package:intl/intl.dart';

class CoinListPageDeneme extends StatefulWidget {
  const CoinListPageDeneme({super.key});

  @override
  State<CoinListPageDeneme> createState() => _CoinListPageDeneme();
}

class _CoinListPageDeneme extends State<CoinListPageDeneme> {
  List<PostModel>? _items;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPostItems();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItems() async {
    _changeLoading();
    final response =
        await Dio().get('https://api.coincap.io/v2/assets?limit=20');
    if (response.statusCode == HttpStatus.ok) {
      final datas = response.data["data"];
      if (datas is List) {
        setState(() {
          _items = datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }

  Future<void> _refresh() {
    fetchPostItems();
    return Future.delayed(Duration(seconds: 2));
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin List'),
        centerTitle: true,
        actions: [
          _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refresh();
        },
        child: const Icon(Icons.update),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _items?.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: coinImage(_items![index].symbol)),
                                Expanded(
                                  flex: 5,
                                  child: coinData(
                                      _items![index].name,
                                      _items![index].symbol,
                                      _items![index].priceUsd,
                                      _items![index].marketCapUsd,
                                      _items![index].changePercent24Hr,
                                      _items![index].volumeUsd24Hr),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: arrowField(
                                        _items![index].changePercent24Hr)),
                              ]),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(onPressed: () {}, child: Text('Load More...')),
          ),
        ],
      ),
    );
  }

  Column arrowField(
    var change,
  ) {
    var _change = double.parse(change);
    return Column(children: [
      SizedBox(
          width: 50,
          height: 50,
          child: Icon(_change < 0 ? Icons.arrow_downward : Icons.arrow_upward,
              color: _change < 0
                  ? const Color.fromARGB(255, 149, 0, 0)
                  : const Color.fromARGB(255, 1, 230, 27)))
    ]);
  }

  Column coinData(
    var name,
    var symbol,
    var price,
    var marketCap,
    var change,
    var volumePerDay,
  ) {
    String _marketCap = marketCap as String;
    String _price = price as String;
    String _change = change as String;
    String _volumePerDay = volumePerDay as String;
    String _name = name as String;

    //var _price2 =double.parse((change = NumberFormat("###.0#", "en_US")) as String);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        Tooltip(
                          message: _name,
                          child: Text(_name.length > 7
                              ? _name.substring(0, 7) + '...'
                              : _name),
                        ),
                        Text('Name\n  ',
                            style: Theme.of(context).textTheme.bodySmall)
                      ]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        Text(symbol),
                        Text('Sybol',
                            style: Theme.of(context).textTheme.bodySmall)
                      ]),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Tooltip(
                            message: _price,
                            child: Text(_price.length > 7
                                ? _price.substring(0, 7) + '..\$'
                                : _price),
                          ),
                          Text('Price\n  ',
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Tooltip(
                            message: _marketCap,
                            child: Text(
                              (_marketCap.length > 1
                                  ? _marketCap.substring(0, 1) + 'b'
                                  : _marketCap),
                              //subtitle: Text('deneme'),
                            ),
                          ),
                          Text(
                            'Market Cap',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(children: [
                          Tooltip(
                            message: _change,
                            child: Text(_change.length > 5
                                ? _change.substring(0, 5) + '%'
                                : _change),
                          ),
                          Text(
                            'Change\n(24Hr)',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(children: [
                          Tooltip(
                            message: _volumePerDay,
                            child: Text(_volumePerDay.length > 2
                                ? _volumePerDay.substring(0, 2) + 'b'
                                : _volumePerDay),
                          ),
                          Text(
                            'Volume',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ]),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Column coinImage(var symbol) {
    String _symbol = symbol as String;
    _symbol = _symbol.toLowerCase();
    String baseUrl = 'https://assets.coincap.io/assets/icons/$_symbol@2x.png';
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image.network(baseUrl),
        )
      ],
    );
  }
}
