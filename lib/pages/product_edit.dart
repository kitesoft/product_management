import 'package:flutter/material.dart';
// import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  //------------------------------------------
  // setter functions
  //------------------------------------------

  _setTitle(String value) {
    this._formData['title'] = value;
  }

  _setDescription(String value) {
    this._formData['description'] = value;
  }

  _setPrice(String value) {
    this._formData['price'] = double.tryParse(value);
  }

  //------------------------------------------
  // validator functions
  //------------------------------------------

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

  //------------------------------------------
  // widget functions
  //------------------------------------------

  // popup modal from bottom
  Widget _modalShowCase(BuildContext context) {
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

  // textfield
  Widget _buildTextFormField(
      {@required String title,
      @required String data,
      int numOfLines = 1,
      TextInputType inputType = TextInputType.text,
      @required Function setter,
      @required Function validator,
      TextEditingController controller}) {
    return TextFormField(
        controller: controller,
        // initialValue: data,
        keyboardType: inputType,
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

  Widget _buildSubmitButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      // return widget
      return Container(
          padding: EdgeInsets.only(top: 15.0),
          child: RaisedButton(
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              child: Text("Save"),
              onPressed: () => _submitForm(model.addProduct, model, context)));
    } //end model
        );
  } //end build submit button func

  // submit map form
  void _submitForm(Function addProduct, MainModel model, BuildContext context) {
    // when all form is okay
    if (!_formKey.currentState.validate()) return;
    // save the current data on field
    _formKey.currentState.save();

    // check if updating the data or adding a new one
    if (model.selectedProductIndex == null) {
      // save to the map
      print("---ADDING---");
      print("Title: " + _formData['title']);
      print("Description: " + _formData['description']);
      print("price: " + _formData['price'].toString());
      model.addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      );
    } else {
      print("---UPDATING PRODUCT---");
      model.updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      );
    }

    // action button for dialog
    Widget actionButtonForDiablog(String text, bool isItCloseButton) {
      return FlatButton(
        child: Text(text),
        onPressed: () {
          // set the text empty
          _titleController.text = "";
          _descriptionController.text = "";
          _priceController.text = "";
          // exit the alert
          if (isItCloseButton == true) {
            Navigator.pop(context);
            // model.selectProduct(null);
          } else {
            Navigator.pop(context);
            Navigator
                .pushReplacementNamed(context, '/products')
                .then((_) => model.selectProduct(null));
          }
        },
      );
    }

    // show a saved alert
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Feedback"),
              content: Text("The product has been saved."),
              actions: <Widget>[
                actionButtonForDiablog("Go to home", false),
                actionButtonForDiablog("Stay here", true),
              ],
            ));
  } //end submit form func

  Widget _buildPageContent(BuildContext context, Product product) {
    // error check
    Product tempProduct = Product(
      title: "",
      description: "",
      price: 0.0,
      image: "",
      userId: "",
      userEmail: "",
    );
    var tempPrice = '';
    // check if edit page or create
    // if not null, it is edit page
    if (product != null) {
      tempProduct = product;
      _titleController.text = product.title;
      _descriptionController.text = product.description;
      _priceController.text = product.price.toString();
      tempPrice = product.price.toString();
    } //end if

    // return the page
    return GestureDetector(
        onTap: () {
          // IMPORTANT: gesture to put keyboard down when clicked
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  // title
                  _buildTextFormField(
                      title: "Product Title",
                      data: tempProduct.title,
                      setter: _setTitle,
                      validator: _validateString,
                      controller: _titleController),
                  // description
                  _buildTextFormField(
                      title: "Product Description",
                      data: tempProduct.description,
                      numOfLines: 4,
                      setter: _setDescription,
                      validator: _validateString,
                      controller: _descriptionController),
                  // price
                  _buildTextFormField(
                      title: "Product Price",
                      data: tempPrice,
                      inputType: TextInputType.number,
                      setter: _setPrice,
                      validator: _validateNumber,
                      controller: _priceController),
                  // save button
                  _buildSubmitButton(context),
                ])))));
  } //end build content func

  _buildEditPageVersion(BuildContext context, Widget content) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return the page
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final Widget pageContent =
          _buildPageContent(context, model.selectedProduct);
      return model.selectedProductIndex == null
          ? pageContent
          : _buildEditPageVersion(context, pageContent);
    });
  }
}
