class Product {
  int id;
  String name;
  int price;
  int quantity;
  int cart = 0;
  String image;
  String description;
  List<String> tag;
  double promo = 1;

  Product(this.id, this.name, this.price, this.quantity, this.image,
      this.description, this.tag);
      
  setCart(int val) {
    cart = val;
  }
}
