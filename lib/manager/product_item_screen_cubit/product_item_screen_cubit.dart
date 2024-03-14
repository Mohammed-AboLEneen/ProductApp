import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_app/errors/server_failure.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_states.dart';
import 'package:splash_app/manager/products_cubit/products_states.dart';
import 'package:splash_app/models/product_model.dart';

import '../../utils/dio_helper.dart';

class ProductItemScreenCubit extends Cubit<ProductItemScreenStates> {
  ProductItemScreenCubit() : super(ProductItemScreenInitial());

  static ProductItemScreenCubit get(context) => BlocProvider.of(context);

  late Product product;
  int selectedVariation = 0;

  Future<void> getProductItem(id) async {
    emit(GetProductItemLoadingState());

    try {
      var response = await DioHelper.get(endPoint: '$id');
      print(id);
      print(response.data['data']['name']);
      product = Product.fromJson(response.data);

      emit(GetProductItemSuccessState());
    } catch (e) {
      if (e is DioException) {
        var error = ServerFailure.dioError(e);
        emit(GetProductItemFailureState(error.message));
      }

      print(e.toString());
      emit(GetProductItemFailureState('SomeThing is Wrong'));
    }
  }
}
