import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class ManageProductScreen extends StatefulWidget {
  static final routeName = '/manage_product_screen';

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  // Focus nodes for forms
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  // Controller for image to consume before submitting and preview image
  final _imgUrlController = TextEditingController();
  // Form key to interact with _saveForm
  final _form = GlobalKey<FormState>();
  // Stores product data
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.00,
    imgUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '0.00',
    'imgUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findProductById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imgUrl': ''
        };

        _imgUrlController.text = _editedProduct.imgUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlController.dispose();
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    // Saves form state
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    } else {
      _form.currentState.save();
      if (_editedProduct.id != null) {
        Provider.of<Products>(context, listen: false)
            .updateProductById(_editedProduct.id, _editedProduct);
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.save), onPressed: () => _saveForm())
              ],
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: _imgUrlController.text.isEmpty
                          ? Center(
                              child: Text(
                                'Opps! No image found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.grey),
                              ),
                            )
                          : Image.network(
                              _imgUrlController.text,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.4),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 12, color: Colors.black12)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kDefaultRadius * 1.5),
                          topRight: Radius.circular(kDefaultRadius * 1.5),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      margin: EdgeInsets.only(top: size.height * 0.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(bottom: kDefaultPadding),
                            child: Text(
                              'Edit product',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Form(
                            autovalidate: true,
                            key: _form,
                            child: Expanded(
                              child: ListView(
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: _initValues['title'],
                                    decoration:
                                        InputDecoration(labelText: 'Title'),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context)
                                            .requestFocus(_priceFocusNode),
                                    onSaved: (newValue) => _editedProduct =
                                        Product(
                                            isFavourite:
                                                _editedProduct.isFavourite,
                                            id: _editedProduct.id,
                                            title: newValue,
                                            description:
                                                _editedProduct.description,
                                            price: _editedProduct.price,
                                            imgUrl: _editedProduct.imgUrl),
                                    validator: (value) => value.isEmpty
                                        ? 'Please enter value'
                                        : null,
                                  ),
                                  SizedBox(
                                    height: kDefaultMargin,
                                  ),
                                  TextFormField(
                                      initialValue: _initValues['price'],
                                      decoration:
                                          InputDecoration(labelText: 'Price'),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      focusNode: _priceFocusNode,
                                      onFieldSubmitted: (_) => FocusScope.of(
                                              context)
                                          .requestFocus(_descriptionFocusNode),
                                      onSaved: (newValue) => _editedProduct =
                                          Product(
                                              isFavourite:
                                                  _editedProduct.isFavourite,
                                              id: _editedProduct.id,
                                              title: _editedProduct.title,
                                              description:
                                                  _editedProduct.description,
                                              price: double.parse(newValue),
                                              imgUrl: _editedProduct.imgUrl),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter value';
                                        }
                                        if (double.tryParse(value) == null) {
                                          return 'Please enter valid number';
                                        }
                                        if (double.parse(value) <= 0) {
                                          return 'Please return number greater than 0';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: kDefaultMargin,
                                  ),
                                  TextFormField(
                                      initialValue: _initValues['description'],
                                      decoration: InputDecoration(
                                          labelText: 'Description'),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      focusNode: _descriptionFocusNode,
                                      onSaved: (newValue) => _editedProduct =
                                          Product(
                                              isFavourite:
                                                  _editedProduct.isFavourite,
                                              id: _editedProduct.id,
                                              title: _editedProduct.title,
                                              description: newValue,
                                              price: _editedProduct.price,
                                              imgUrl: _editedProduct.imgUrl),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter value';
                                        }

                                        return null;
                                      }),
                                  SizedBox(
                                    height: kDefaultMargin,
                                  ),
                                  TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Image URL'),
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.url,
                                      controller: _imgUrlController,
                                      focusNode: _imgUrlFocusNode,
                                      onSaved: (newValue) => _editedProduct =
                                          Product(
                                              isFavourite:
                                                  _editedProduct.isFavourite,
                                              id: _editedProduct.id,
                                              title: _editedProduct.title,
                                              description:
                                                  _editedProduct.description,
                                              price: _editedProduct.price,
                                              imgUrl: newValue),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter value';
                                        }
                                        if (!value.startsWith('http')) {
                                          return 'Please enter valid URL';
                                        }
                                        return null;
                                      })
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
