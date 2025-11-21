import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../models/menu_model.dart';
import '../blocs/order_cubit.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;
  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final original = currency.format(menu.price);
    final discounted = currency.format(menu.getDiscountedPrice());
    final hasDiscount = menu.discount > 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        title: Text(
          menu.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            if (hasDiscount) ...[
              Text(
                original,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                discounted,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else
              Text(
                original,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            context.read<OrderCubit>().addToOrder(menu);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ditambahkan: ${menu.name}')),
            );
          },
          child: const Text('Add'),
        ),
      ),
    );
  }
}
