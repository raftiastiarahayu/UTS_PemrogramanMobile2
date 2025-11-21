import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String id;
  final String name;
  final int price; // dalam rupiah, contoh: 30000
  final String category;
  final double discount; // antara 0..1, contoh 0.1 = 10%

  const MenuModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.discount = 0.0,
  });

  int getDiscountedPrice() {
    return (price - (price * discount)).toInt();
  }

  @override
  List<Object?> get props => [id, name, price, category, discount];
}
