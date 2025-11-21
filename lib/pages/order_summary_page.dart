import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/order_cubit.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Ringkasan Pesanan')),
      body: BlocBuilder<OrderCubit, List<dynamic>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(child: Text('Belum ada pesanan'));
          }

          final orderCubit = context.read<OrderCubit>();

          // ---------------------------
          //// --- Tambahan Bagian C ---
          final int subtotal = orderCubit.rawTotal;
          final int finalTotal = orderCubit.totalPrice;
          final bool dapatDiskon = subtotal > 100000;
          //// --- END ---
          // ---------------------------

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final item = state[index];
                      final menu = item.menu;
                      final qty = item.qty;
                      final priceEach = menu.getDiscountedPrice();

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(menu.name),
                          subtitle: Text(
                            'Harga/unit: ${currency.format(priceEach)} • Qty: $qty',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    orderCubit.updateQuantity(menu, qty - 1),
                              ),
                              Text('$qty'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    orderCubit.updateQuantity(menu, qty + 1),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    orderCubit.removeFromOrder(menu),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),
                // ---------------------------
                //// --- Tambahan Bagian C ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Subtotal:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currency.format(subtotal),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                if (dapatDiskon)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Diskon Transaksi 10%",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "-10%",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Akhir:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currency.format(finalTotal),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),

                //// --- END ---
                // ---------------------------
                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final total = finalTotal;
                          orderCubit.clearOrder();

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Pembayaran Berhasil'),
                              content: Text(
                                'Total bayar: ${currency.format(total)}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Bayar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () => orderCubit.clearOrder(),
                      child: const Text('Batal'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
