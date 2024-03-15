import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_app/manager/cart_cubit/cart_states.dart';
import 'package:splash_app/models/cart_item_model.dart';

import '../../models/cart_model.dart';

class CartCubit extends Cubit<CartCubitStates> {
  CartCubit() : super(CartInitialState());

  List<CartItemModel> items = [];

  void addItem(CartItemModel item) {
    items.add(item);
    emit(CartAddItemSuccessState());
  }
}
