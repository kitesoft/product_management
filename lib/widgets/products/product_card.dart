import 'package:flutter/material.dart';
import './price_tags.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildIconButton(BuildContext context, MainModel model) {
    return IconButton(
        icon: Icon(Icons.info),
        color: Theme.of(context).accentColor,
        onPressed: () => Navigator.pushNamed<bool>(
            context, '/product/' + model.allProducts[productIndex].id));
  } //end icon button build

  Widget _buildFavIconButton(BuildContext context, MainModel model) {
    // return fav button
    return IconButton(
      icon: Icon(model.allProducts[productIndex].isFavorite
          ? Icons.favorite
          : Icons.favorite_border),
      color: Colors.red,
      onPressed: () {
        model.selectProduct(model.allProducts[productIndex].id);
        model.toggleProductFavoriteStatus();
      },
    );
  } //end icon button build

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        child: Column(
          children: <Widget>[
            // image, change from asets to network
            // because we are using the image from online now
            FadeInImage(
                image: NetworkImage(product.image),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/food.jpg')),
            SizedBox(height: 15.0),

            // food type and price
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              // title
              TitleDefault(product.title),
              // spacing
              SizedBox(width: 10.0),
              // price
              PriceTag(product.price),
            ]),

            // address
            AddressTag("Union Square, San Fransisco"),

            // user email
            SizedBox(height: 5.0),
            Text(product.userEmail),

            // detail button
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                // info button
                _buildIconButton(context, model),
                // fav button
                _buildFavIconButton(context, model),
              ],
            ),
          ],
        ),
      );
    });
  } //end build
}
