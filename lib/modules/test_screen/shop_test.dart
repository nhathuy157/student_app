import 'dart:developer';

import 'package:flutter/material.dart';

import '../../service/action/shop/fake_data_shop.dart';


class ShopTestPage extends StatelessWidget {
  const ShopTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                FakeData()
                    .AddData()
                    .whenComplete(() => FakeData().setCategory())
                    .whenComplete(
                      () => log("Read Json Done"),
                    );
              },
              child: const Text('Read Json')),
          ElevatedButton(
              onPressed: () {
                FakeData().CategoryFirebase().whenComplete(
                      () => log("Category Done"),
                    );
              },
              child: const Text('Add category firebase')),
          ElevatedButton(
              onPressed: () {
                FakeData().ProductFireBase().whenComplete(
                      () => log("Product Done"),
                    );
              },
              child: const Text('Add product firebase')),
          ElevatedButton(
              onPressed: () {
                FakeData().PostFireBase().whenComplete(
                      () => log("Post Done"),
                    );
              },
              child: const Text('Add Post firebase')),
          ElevatedButton(
              onPressed: () {
                FakeData().patternFirebase().whenComplete(
                      () => log("Pattern Done"),
                    );
              },
              child: const Text('Add pattern firebase')),
          ElevatedButton(
              onPressed: () {
                FakeData().ShopLogFirebase().whenComplete(
                      () => log("Shop Log Done"),
                    );
              },
              child: const Text('Add Shop Log firebase')),
        ],
      ),
    );
  }
}
