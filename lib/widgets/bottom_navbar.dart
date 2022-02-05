import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/store.dart';
import '../constant.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        if (index == 1) Navigator.pushNamed(context, '/cart');
      });
    }

    var store = Provider.of<Store>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Stack(children: [
            const Icon(Icons.card_giftcard),
            store.cart.isNotEmpty ? Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6)),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  store.getCartQuantity().toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
            ) : Positioned(
              top: 0,
              right: 0,
              child: Container(),
            ),
          ]),
          label: 'Boks',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: primaryColor,
      onTap: _onItemTapped,
    );
  }
}
