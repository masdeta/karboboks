import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/product.dart';
import '../store/store.dart';
import '../widgets/shimmer.dart';

class PromoFoods extends StatefulWidget {
  const PromoFoods({Key? key}) : super(key: key);

  @override
  _PromoFoodsState createState() => _PromoFoodsState();
}

class _PromoFoodsState extends State<PromoFoods> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      width: double.infinity,
      child: Column(
        children: const <Widget>[
          PromoFoodTitle(),
          Expanded(
            child: PromoFoodItems(),
          )
        ],
      ),
    );
  }
}

class PromoFoodTiles extends StatelessWidget {
  final Product product;

  const PromoFoodTiles({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ok = Provider.of<Map<String, dynamic>?>(context);
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: ok == null
            ? const Shimmer()
            : SizedBox(
                width: 170,
                height: 175,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Image.asset(
                          'assets/images/' + product.image + ".jpg",
                          width: 130,
                          height: 140,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Wrap(
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.only(left: 5, top: 5, right: 10),
                          child: Column(
                            children: [
                              product.promo != 1 ? Text(
                                '${product.price}rb',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w600,
                                ),
                              ): Container(),
                              Text(
                                '${(product.price * product.promo).round()}rb',
                                style: const TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class PromoFoodTitle extends StatelessWidget {
  const PromoFoodTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text(
            "Promo",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF3a3a3b),
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "Lihat Semua",
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class PromoFoodItems extends StatelessWidget {
  const PromoFoodItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<Store>(context);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        ...store.products.map((item) {
          return (item.quantity > 0 && item.tag.contains('promo'))
              ? InkWell(
                  onTap: () {
                    store.setActiveProduct(item);
                    Navigator.pushNamed(context, '/detail');
                  },
                  child: PromoFoodTiles(
                    product: item,
                  ),
                )
              : Container();
        }),
      ],
    );
  }
}
