import 'package:flutter/material.dart';

class Products extends StatelessWidget{
  // instances
  final List<String> products;
  // constructor
  Products([this.products = const []]){
    print("[Products Widget] Constructor");
  }//end contructor

  Widget _buildProductItem(BuildContext context, int index){
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/food.jpg'),
          Text(products[index]),
        ],
      ),
    );
  }//end func

  Widget _buildProductList(){
    Widget productCard = Center(child: Text("No product found, please add some"));
    if(products.length > 0){
      productCard = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    }//end if
    return productCard;
  }//end func

  @override
  Widget build(BuildContext context) {
    print("[product widget] build");
    return _buildProductList(); 
  }//end build
}//end class