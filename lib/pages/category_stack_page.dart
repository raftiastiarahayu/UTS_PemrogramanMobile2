import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/category_cubit.dart';

class CategoryStackPage extends StatelessWidget {
  final List<String> categories;
  const CategoryStackPage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<CategoryCubit, String>(
        builder: (context, selected) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < categories.length; i++)
                Positioned(
                  left: i * 28.0,
                  top: i.isEven ? 10 : 30,
                  child: GestureDetector(
                    onTap: () => context.read<CategoryCubit>().selectCategory(
                      categories[i],
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 140,
                      height: 80,
                      decoration: BoxDecoration(
                        color: selected == categories[i]
                            ? Colors.blueAccent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: selected == categories[i]
                              ? Colors.blue
                              : Colors.grey.shade200,
                          width: selected == categories[i] ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[i],
                          style: TextStyle(
                            color: selected == categories[i]
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              // tombol clear / show all
              Positioned(
                right: 0,
                bottom: -10,
                child: TextButton(
                  onPressed: () => context.read<CategoryCubit>().clear(),
                  child: const Text('All'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
