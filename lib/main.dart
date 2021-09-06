import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
  //test firebase
  //can use the abreviated call name "pedidos/0001"
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Loja Virtual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BaseScreen());
  }
}
