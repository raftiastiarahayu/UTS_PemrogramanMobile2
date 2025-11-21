import 'package:bloc/bloc.dart';

// state = selected category (String). empty string berarti all.
class CategoryCubit extends Cubit<String> {
  CategoryCubit() : super('');

  void selectCategory(String category) => emit(category);

  void clear() => emit('');
}
