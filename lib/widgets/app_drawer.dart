import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'Hello Friend!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const TitleBuilder(title: 'Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const TitleBuilder(title: 'Orders'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, OrdersScreen.routeName),
            //     Navigator.pushReplacement(
            //   context,
            //   CustomRoute(builder: (context) => const OrdersScreen()),
            // ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const TitleBuilder(title: 'Manage Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const TitleBuilder(title: 'Log Out'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
              Provider.of<Auth>(context, listen: false).logOut();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class TitleBuilder extends StatelessWidget {
  final String title;
  const TitleBuilder({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
