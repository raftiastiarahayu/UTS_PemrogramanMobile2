import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/order_cubit.dart';
import 'blocs/category_cubit.dart';
import 'pages/order_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(create: (_) => OrderCubit()),
        BlocProvider<CategoryCubit>(create: (_) => CategoryCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kasir Warung - UTS',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
        home: const OrderHomePage(),
      ),
    );
  }
}
