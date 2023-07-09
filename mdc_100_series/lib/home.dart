// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/model/products_repository.dart';
import 'package:shrine/supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // TODO: Make a collection of cards (102)
  List<Card> _buildGridCards(BuildContext context, Category category) {
    final themeData = Theme.of(context);
    final NumberFormat formater = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final products = ProductsRepository.loadProducts(category);
    return products
        .map((p) => Card(
              elevation: 0.0,
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 18.0 / 11.0,
                    child: Image.asset(
                      p.assetName,
                      package: p.assetPackage,
                      fit: BoxFit.fitWidth,
                      //filterQuality: FilterQuality.high,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            p.name,
                            style: themeData.textTheme.bodyLarge,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            formater.format(p.price),
                            style: themeData.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      // TODO: Add app bar (102)
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () => {print('Menu Button')},
        ),
        title: const Text('SHRINE'),
        actions: [
          IconButton(
              onPressed: () {
                print('Search Button');
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                print('Tune Button');
              },
              icon: const Icon(Icons.tune)),
        ],
      ),
      // TODO: Add a grid view (102)
      // body: GridView.count(
      //   crossAxisCount: 2,
      //   padding: const EdgeInsets.all(16),
      //   childAspectRatio: 8.0 / 9.0,
      //   children: _buildGridCards(context, Category.all),
      // ),
      body: AsymmetricView(
        products: ProductsRepository.loadProducts(Category.all),
      ),
      // TODO: Set resizeToAvoidBottomInset (101)
      resizeToAvoidBottomInset: false,
    );
  }
}
