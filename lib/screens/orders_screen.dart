import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future _fetchOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  late Future _ordersFuture;

  @override
  void initState() {
    _ordersFuture = _fetchOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Order',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text(
                  'An Error Occured!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, _) => orderData.orders.isEmpty
                    ? const Center(
                        child: Text(
                          "You have no Orders yet,\n"
                          "Start adding some.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (ctx, i) => OrderItem(
                          order: orderData.orders[i],
                        ),
                      ),
              );
            }
          }
        },
      ),
    );
  }
}
