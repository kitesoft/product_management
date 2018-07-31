import "package:flutter/material.dart";
import "../drawers.dart";
import "./product_create.dart";
import "./product_list.dart";

class ProductAdminPage extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2, // number of tabs
        child: Scaffold(
          drawer: MenuDrawer(),

          appBar: AppBar(
            title: Text("Admin Page"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Create Product", icon: Icon(Icons.create)),
                Tab(text: "My Product", icon: Icon(Icons.list)),
              ]
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(),
              ProductListPage(),
            ],
          ),
        )
      );
    }
}