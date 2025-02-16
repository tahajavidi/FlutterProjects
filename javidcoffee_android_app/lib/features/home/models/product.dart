class Product {
  int? id;
  String? created;
  String? title;
  int? price;
  List<dynamic>? image;
  String? desc;
  List<dynamic>? category;

  Product(this.id, this.created, this.title, this.price, this.image, this.desc);

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    created = json["created_at"];
    title = json["title"];
    price = json["price"];
    image = json["image"];
    desc = json["desc"];
    category = json["category"];
  }
}
