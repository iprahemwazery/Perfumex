import 'package:flutter/material.dart';
import 'package:perfumex/page/cart_page.dart';
import 'package:perfumex/page/favorite_page.dart';
import 'package:perfumex/page/progict_filter.dart';

class Drawerd extends StatelessWidget {
  const Drawerd({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.brown),
            child: Column(
              children: [
                Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/images/Untitled.jpeg",
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "hema@wazery.net",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: const Icon(
                Icons.filter_list,
                color: Colors.black,
                size: 36,
              ),
              title: const Text('Filter', style: TextStyle(fontSize: 24)),
              onTap: () {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.male),
            title: const Text('Man'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const ProductsPage(
                        categoryId: 15,
                        title: "Men's Products",
                      ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.woman_outlined),
            title: const Text('Woman'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
