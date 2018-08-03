import 'package:flutter/material.dart';
import './pages/product_admin.dart';
import './pages/product.dart';
import './pages/products.dart';
// import 'package:flutter/rendering.dart';

/// main to run the app
void main(){
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(new MyApp());
}//end main

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _products = [];
  
  void _addProduct(Map<String, String> product){
     setState( () {
      _products.add(product);
    });
  }//end func

  void _deleteProduct(int index){
    setState(() {
      _products.removeAt(index);    
    });
  }//end func

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      // list of routes
      routes: {
        '/': (BuildContext context) => ProductsPage(_products, _addProduct, _deleteProduct),// must comment home:
        '/admin': (BuildContext context) => ProductAdminPage(),
      },

      // create multiple sub route
      onGenerateRoute: (RouteSettings settings){
        final List<String> pathElements = settings.name.split('/');
        if(pathElements[0] != ''){
          return null;
        }
        if(pathElements[1] == 'product'){
          final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'], _products[index]['image']),
          );
        }
        return null;
      },

      // when route doesnt exist go to default
      onUnknownRoute: (RouteSettings setting){ 
        return MaterialPageRoute(builder: (BuildContext context) => 
        ProductsPage(_products, _addProduct, _deleteProduct));
      },

      // theme and setting
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      // home: AuthPage(),

    );
  }//end build
}//end class