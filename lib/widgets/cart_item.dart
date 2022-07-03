import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id, title;
  final double price;
  final int quantity;

  const CartItem({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                '₹ $price',
                style: TextStyle(
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color),
              ),
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text('Total: ₹ ${price * quantity}'),
        trailing: Text('$quantity x'),
      ),
    );
  }
}
