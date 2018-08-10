import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  ProductEditPage({this.addProduct, this.updateProduct, this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  // popup modal from bottom
  _modalShowCase(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("save"),
          // sliding modal from bottom
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Center(child: Text("This is Modal!"));
                });
          }),
    );
  } //end modal func

  _setTitle(String value) {
    this._formData['title'] = value;
  }

  _setDescription(String value) {
    this._formData['description'] = value;
  }

  _setPrice(String value) {
    this._formData['price'] = double.tryParse(value);
  }

  String _validateString(String value) {
    if (value.isEmpty) {
      return "Required";
    } else {
      return null;
    }
  }

  String _validateNumber(String value) {
    if (double.tryParse(value) == null) {
      return "Required and must be a number";
    } else {
      return null;
    }
  }

  // textfield
  Widget _buildTextFormField(String title, int numOfLines, TextInputType type,
      Function setter, Function validator) {
    return TextFormField(
        keyboardType: type,
        maxLines: numOfLines,
        decoration: InputDecoration(labelText: title),
        validator: validator,
        // autovalidate: true,
        onSaved: (String value) {
          // setState(() {
          setter(value);
          // });
        });
  } //end build

  // subtmit map form
  void _submitForm() {
    // when all form is okay
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    // save to the map
    print("---ADDING---");
    print("Title: " + this._formData['title']);
    print("Description: " + this._formData['description']);
    print("price: " + this._formData['price'].toString());
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          // IMPORTANT: gesture to put keyboard down when clicked
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(15.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  // title
                  _buildTextFormField("Product Title", 1, TextInputType.text,
                      _setTitle, _validateString),
                  // description
                  _buildTextFormField("Product Description", 4,
                      TextInputType.text, _setDescription, _validateString),
                  // price
                  _buildTextFormField("Product Price", 1, TextInputType.number,
                      _setPrice, _validateNumber),
                  // save button
                  Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                          textColor: Colors.white,
                          color: Theme.of(context).accentColor,
                          child: Text("Save"),
                          onPressed: _submitForm)),
                ]))));
  }
}
