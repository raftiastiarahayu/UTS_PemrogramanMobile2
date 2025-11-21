import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';
import '../blocs/order_cubit.dart';
import '../blocs/category_cubit.dart';
import 'order_summary_page.dart';
import 'category_stack_page.dart';

class OrderHomePage extends StatelessWidget {
  const OrderHomePage({super.key});

  // contoh data menu; di project nyata ini biasanya dari repository/api
  List<MenuModel> sampleMenus() {
    return const [
      MenuModel(
        id: 'm1',
        name: 'Nasi Goreng',
        price: 30000,
        category: 'Makanan',
        discount: 0.1,
      ),
      MenuModel(
        id: 'm2',
        name: 'Mie Ayam',
        price: 25000,
        category: 'Makanan',
        discount: 0.0,
      ),
      MenuModel(
        id: 'm3',
        name: 'Es Teh',
        price: 8000,
        category: 'Minuman',
        discount: 0.0,
      ),
      MenuModel(
        id: 'm4',
        name: 'Jus Jeruk',
        price: 15000,
        category: 'Minuman',
        discount: 0.05,
      ),
      MenuModel(
        id: 'm5',
        name: 'Sate Ayam',
        price: 35000,
        category: 'Makanan',
        discount: 0.15,
      ),
      MenuModel(
        id: 'm6',
        name: 'Pisang Goreng',
        price: 12000,
        category: 'Dessert',
        discount: 0.0,
      ),
    ];
  }

  List<String> categories(List<MenuModel> menus) {
    final set = <String>{};
    for (final m in menus) set.add(m.category);
    return set.toList();
  }

  @override
  Widget build(BuildContext context) {
    final menus = sampleMenus();
    final cats = categories(menus);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir Warung'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrderSummaryPage()),
            ),
            icon: const Icon(Icons.receipt_long),
            tooltip: 'Ringkasan Order',
          ),
        ],
      ),
      body: Column(
        children: [
          // Stack kategori
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: CategoryStackPage(categories: cats),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<CategoryCubit, String>(
              builder: (context, selectedCategory) {
                final visible = selectedCategory.isEmpty
                    ? menus
                    : menus
                          .where((m) => m.category == selectedCategory)
                          .toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: visible.length,
                  itemBuilder: (context, index) {
                    final menu = visible[index];
                    return MenuCard(menu: menu);
                  },
                );
              },
            ),
          ),
          // footer total singkat
          BlocBuilder<OrderCubit, List<dynamic>>(
            builder: (context, order) {
              final total = context.read<OrderCubit>().totalPrice;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.grey.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: Rp ${total}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderSummaryPage(),
                        ),
                      ),
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
