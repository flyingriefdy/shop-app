import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/orders_screen.dart';

import 'screens/products_overview_screen.dart';
import 'screens/product_details_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './constants.dart';
import 'screens/user_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultRadius))),
          cardTheme: CardTheme(
            shadowColor: Colors.black26,
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultRadius)),
          ),
          popupMenuTheme: PopupMenuThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultRadius))),
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: 'OleoScript', fontWeight: FontWeight.bold),
              headline5: TextStyle(
                  fontFamily: 'OleoScript', fontWeight: FontWeight.bold)),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(
            color: Colors.black38,
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black38,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            color: Colors.white,
          ),
          splashFactory: InkRipple.splashFactory,
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
        },
      ),
    );
  }
}
