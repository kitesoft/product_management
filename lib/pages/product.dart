import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          print("back button pressed");
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(title: Text("Product Detail")),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // image
              FadeInImage(
                  image: NetworkImage(product.image),
                  height: 300.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/food.jpg')),

              // food label
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: TitleDefault(product.title)),

              // price and location
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Union Square, San Francisco",
                    style: TextStyle(fontFamily: "Oswald", color: Colors.grey),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        " | ",
                        style: TextStyle(color: Colors.grey),
                      )),
                  Text("\$" + product.price.toString()),
                ],
              ),

              // description
              SizedBox(
                height: 15.0,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ));
  } //end build
} //end class
