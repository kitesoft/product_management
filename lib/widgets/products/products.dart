import 'package:flutter/material.dart';
import './product_card.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productCards =
        Center(child: Text("No product found, please add some"));
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productCards = Container(
        child: Center(child: Text("List empty", textScaleFactor: 1.3))
      );
    }
    return productCards;
  } //end func

  @override
  Widget build(BuildContext context) {
    print("[product widget] build");
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return _buildProductList(model.displayProducts);
      }
    );
  } //end build
} //end class
