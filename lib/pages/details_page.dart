import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../constant.dart';
import '../models/product.dart';
import '../store/store.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Store>(context);
    Product? product = store.activeProduct;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF3a3737),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Badge(
              badgeColor: primaryColor,
              showBadge: store.getCartQuantity() > 0,
              position: const BadgePosition(top: 10, end: 10),
              animationType: BadgeAnimationType.scale,
              badgeContent: Text(
                store.getCartQuantity().toString(),
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.card_giftcard,
                  color: Colors.black45,
                ),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Hero(
                    tag: 'thumb${product!.id}',
                    child: Image.asset(
                      'assets/images/' + product.image + ".jpg",
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  elevation: 1,
                  margin: const EdgeInsets.all(5),
                ),
                const SizedBox(
                  height: 10,
                ),
                FoodTitleWidget(
                  product: product,
                ),
                const SizedBox(
                  height: 15,
                ),
                AddToCartMenu(
                  store: store,
                  product: product,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.white24,
                  child: Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        height: 1.50),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FoodTitleWidget extends StatelessWidget {
  final Product product;

  const FoodTitleWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              product.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
            Column(
              children: [
                product.promo != 1
                    ? Text(
                        '${product.price}rb',
                        style: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Container(),
                Text(
                  '${(product.price * product.promo).round()}rb',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  final Product product;
  final Store store;
  const AddToCartMenu({Key? key, required this.product, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: store.getActiveCart().id == 0
          ? InkWell(
              onTap: () => store.addItemToCart(context, product),
              child: Container(
                width: 220.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    'TAMBAH KE BOKS',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => store.removeItemFromCart(product),
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60.0,
                  height: 45.0,
                  child: Center(
                    child: Text(
                      '${store.getActiveCart().id == 0 ? 0 : store.getActiveCart().cart}',
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => store.addItemToCart(context, product),
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}