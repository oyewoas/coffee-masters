import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/datamodel.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
        future: dataManager.getMenu(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // EACH CATEGORY STARTS HERE
                  var category = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 8.0, left: 8.0),
                        child: Text(
                          category.name,
                          style: TextStyle(color: Colors.brown.shade400),
                        ),
                      ),
                      if (screenSize.width < 500)
                        // EACH MENU ITEM, Mobile Viewport
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: category.products.length,
                          itemBuilder: (context, index) {
                            return MenuItem(
                              product: category.products[index],
                              onAdd: (p) => dataManager.cartAdd(p),
                            );
                          },
                        )
                      else
                        // EACH MENU ITEM, Large Viewport
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              for (var product in category.products)
                                SizedBox(
                                  width: 350,
                                  child: MenuItem(
                                    product: product,
                                    onAdd: (p) => dataManager.cartAdd(p),
                                  ),
                                )
                            ],
                          ),
                        )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        }));
  }
}

class MenuItem extends StatelessWidget {
  final Product product;
  final Function onAdd;

  const MenuItem({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              Image.network(product.imageUrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("\$${product.price}"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        onAdd(product);
                      },
                      child: const Text("Add"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
