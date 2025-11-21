import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/menu_model.dart';

class OrderItem extends Equatable {
  final MenuModel menu;
  final int qty;

  const OrderItem({required this.menu, required this.qty});

  OrderItem copyWith({MenuModel? menu, int? qty}) {
    return OrderItem(menu: menu ?? this.menu, qty: qty ?? this.qty);
  }

  @override
  List<Object?> get props => [menu, qty];
}

// State: List<OrderItem>
class OrderCubit extends Cubit<List<OrderItem>> {
  OrderCubit() : super([]);

  // Tambah satu item (jika sudah ada, qty++)
  void addToOrder(MenuModel menu) {
    final existingIndex = state.indexWhere((e) => e.menu.id == menu.id);
    if (existingIndex >= 0) {
      final newState = List<OrderItem>.from(state);
      final existing = newState[existingIndex];
      newState[existingIndex] = existing.copyWith(qty: existing.qty + 1);
      emit(newState);
    } else {
      emit([...state, OrderItem(menu: menu, qty: 1)]);
    }
  }

  // Hapus item sepenuhnya
  void removeFromOrder(MenuModel menu) {
    emit(state.where((e) => e.menu.id != menu.id).toList());
  }

  // Update quantity (jika qty <= 0 -> hapus)
  void updateQuantity(MenuModel menu, int qty) {
    if (qty <= 0) {
      removeFromOrder(menu);
      return;
    }
    final idx = state.indexWhere((e) => e.menu.id == menu.id);
    if (idx >= 0) {
      final newState = List<OrderItem>.from(state);
      newState[idx] = newState[idx].copyWith(qty: qty);
      emit(newState);
    } else {
      emit([...state, OrderItem(menu: menu, qty: qty)]);
    }
  }

  // Clear order
  void clearOrder() => emit([]);

  //// --- Tambahan Bagian C ---
  // Subtotal tanpa diskon total (hanya diskon item)
  int get rawTotal {
    int total = 0;
    for (final item in state) {
      total += item.menu.getDiscountedPrice() * item.qty;
    }
    return total;
  }

  // Total + diskon 10% jika subtotal > 100.000
  int get totalPrice {
    int subtotal = rawTotal;

    if (subtotal > 100000) {
      subtotal = (subtotal * 0.9).toInt(); // diskon 10%
    }

    return subtotal;
  }

  //// --- END ---
  // ---------------------------
}
