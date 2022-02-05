import 'package:flutter/material.dart';
import '../firebase/firestore.dart';
import '../models/product.dart';
// import 'package:lipsum/lipsum.dart' as lipsum;

class Store extends ChangeNotifier {
  List<Product> _products = [];
  // ignore: prefer_final_fields
  List<Product> _cart = [];
  Product? _active;
  Product? _active2;

  Store() {
    _products = [
      Product(1, "Beras Padi", 55, 2, "product/beras",
          'Beras padi per 5 kg', []), //lipsum.createParagraph()),
      Product(2, "Jagung", 25, 2, "product/jagung",
          'Jagung per 5 kg', []), //lipsum.createParagraph()),
      Product(3, "Kedelai", 65, 2, "product/kedelai",
          'Kedelai per 5 kg', []), //lipsum.createParagraph()),
      Product(4, "Beras Sorgum", 15, 1, "product/sorgum",
          'Beras sorgum per 5 kg', []), //lipsum.createParagraph()),
      Product(5, "Tepung Jagung", 30, 1, "product/tepung-jagung",
          'Tepung jagung per 5 kg', []), //lipsum.createParagraph()),
    ];
    setProductQuantity();
  }

  List<Product> get products => _products;
  List<Product> get cart => _cart;
  Product? get activeProduct => _active;
  Product? get activeCart => _active2;

  setActiveProduct(Product product) {
    _active = product;
    Product? found = _cart.firstWhere((p) => p.id == product.id,
        orElse: () => Product(0, "null", 0, 0, "null", 'null', []));
    _active2 = found;
  }

  clearCart() {
    _active2 = Product(0, "null", 0, 0, "null", 'null', []);
    _cart.clear();
    notifyListeners();
  }

  Product getActiveCart() {
    Product? found = _cart.firstWhere((p) => p.id == _active!.id,
        orElse: () => Product(0, "null", 0, 0, "null", 'null', []));
    return found;
  }

  addItemToCart(context, Product product) {
    Product? found = _cart.firstWhere((p) => p.id == product.id,
        orElse: () => Product(0, "null", 0, 0, "null", 'null', []));
    if (found.id != 0) {
      if (found.cart < product.quantity) {
        found.cart += 1;
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Stok habis!')),
          );
      }
    } else {
      Product p = Product(product.id, product.name, (product.price * product.promo).round(), product.quantity,
          product.image, product.description, product.tag);
      p.setCart(1);
      _cart.add(p);
    }

    notifyListeners();
  }

  removeItemFromCart(Product product) {
    Product found = _cart.firstWhere((p) => p.id == product.id,
        orElse: () => Product(0, "null", 0, 0, "null", 'null', []));
    if (found.id != 0 && found.cart == 1) {
      _active2 = Product(0, "null", 0, 0, "null", 'null', []);
      _cart.removeWhere((p) => p.id == product.id);
    }
    if (found.id != 0 && found.cart > 1) {
      found.cart -= 1;
    }
    notifyListeners();
  }

  removeItemsFromCart(Product product) {
    Product found = _cart.firstWhere((p) => p.id == product.id,
        orElse: () => Product(0, "null", 0, 0, "null", 'null', []));
    if (found.id != 0) {
      _cart.remove(product);
    }
    notifyListeners();
  }

  setProductQuantity() async {
    Map<String, dynamic>? map = await FirestoreService.fetchQuantity();
    List<dynamic> l = map!['popular'];
    List<dynamic> l2 = map['promo'];
    Map<String, dynamic> l3 = map['promoPercent'];
    for (int i = 0; i < _products.length; i++) {
      _products[i].quantity = map[_products[i].id.toString()] ?? 0;
      if (l.contains(_products[i].id.toString())) {
        _products[i].tag.add('popular');
      }
      if (l2.contains(_products[i].id.toString())) {
        _products[i].tag.add('promo');
        _products[i].promo = l3[_products[i].id.toString()];
      }
    }
    notifyListeners();
  }

  int getCartQuantity() {
    int total = 0;
    for (Product p in _cart) {
      total += p.cart;
    }
    return total;
  }

  int getCartTotal() {
    int price = 0;
    for (Product p in _cart) {
      price += (p.price * p.cart);
    }
    return price;
  }
}
