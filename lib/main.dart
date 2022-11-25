import 'package:demo_product/resources/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:demo_product/model/Product1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp(products: fetchProducts()));
}

class MyApp extends StatelessWidget {
  Future<List<Product1>> products;

  MyApp({Key? key, required this.products}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Product Navigation demo home page',
        products: products,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;
  Future<List<Product1>> products;

  MyHomePage({Key? key, required this.title, required this.products})
      : super(key: key);

  // final items = Product.getProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Danh sách sản phâm",
                textAlign: TextAlign.center)),
        body: Center(
          child: FutureBuilder<List<Product1>>(
            future: products,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ProductBoxList(items: snapshot.data as List<Product1>)
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

class ProductBoxList extends StatelessWidget {
  final List<Product1> items;

  const ProductBoxList({Key? key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ProductBox(item: items[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(item: items[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key, required this.item}) : super(key: key);
  final Product1 item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chi tiết sản phẩm"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(item.imglink),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.product_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("Price: ${item.price}"),
                            inputWidget(
                                label: "Name",
                                hintText: "Input Name",
                                controller: null)
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({Key? key, required this.item}) : super(key: key);
  final Product1 item;

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(item.imglink),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.product_name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("Price: ${item.price}"),
                            Text("Sale_Price : ${item.sale_price}"),
                          ],
                        )))
              ]),
        ));
  }
}

List<Product1> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product1>((json) => Product1.fromMap(json)).toList();
}

Future<List<Product1>> fetchProducts() async {
  Uri uri = Uri.http("172.17.0.103:8080", "/WSLibrary/api/product/all");
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
