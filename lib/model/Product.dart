class Product1 {
  final int product_id;
  final String product_name;
  final double price;
  final double sale_price;
  final String imglink;
  final int id;

  Product1(this.product_id, this.product_name, this.price, this.sale_price,
      this.imglink, this.id);

  factory Product1.fromMap(Map<String, dynamic> json) {
    return Product1(json['product_id'], json['product_name'], json['price'],
        json['sale_price'], json['imglink'], json['id']);
  }
}
