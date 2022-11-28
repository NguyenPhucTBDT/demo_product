import 'package:demo_product/resources/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:demo_product/model/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';

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
      debugShowCheckedModeBanner: false,
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
          title:
              const Text("Danh sách sản phẩm", textAlign: TextAlign.center)),
      body: Center(
        child: FutureBuilder<List<Product1>>(
          future: products,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ProductBoxList(items: snapshot.data as List<Product1>)
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(5),
          children: [
            DrawerHeader(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      "https://annamaroma.com/wp-content/uploads/2022/08/AnyConv.com__logo-an-annam.webp",
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Trang chủ",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {},
              leading: const Icon(
                Icons.home,
                color: Colors.red,
              ),
            ),
            ListTile(
              title: const Text(
                "Giỏ hàng",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                openDialog(context);
              },
              leading: const Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ),
            ),
            ListTile(
                title: const Text(
                  "Đơn hàng",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {},
                leading: SvgPicture.asset(
                  "assets/images/ic_order.svg",
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
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

openDialog(BuildContext context) {
  // This is the ok button
  Widget ok = TextButton(
    child: const Text("Okay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // show the alert dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("I am Here!"),
        content: const Text("I appeared because you pressed the button!"),
        actions: [
          ok,
        ],
        elevation: 5,
      );
    },
  );
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
                        padding: const EdgeInsets.all(5),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Price : "),
                                Text(
                                  "${item.price}",
                                  style: item.sale_price > 0
                                      ? const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.red)
                                      : const TextStyle(),
                                )
                              ],
                            ),
                            item.sale_price > 0
                                ? Text("Sale_Price : ${item.sale_price}")
                                : const Text(""),
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
