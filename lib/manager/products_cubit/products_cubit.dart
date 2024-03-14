import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_app/errors/server_failure.dart';
import 'package:splash_app/manager/products_cubit/products_states.dart';
import 'package:splash_app/models/product_model.dart';
import 'package:splash_app/models/product_screen_item_model.dart';

import '../../utils/dio_helper.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsInitialState());

  static ProductsCubit get(context) => BlocProvider.of(context);

  List<ProductScreenItemModel> product = [];

  Future<void> getProducts() async {
    emit(GetProductsLoadingState());

    try {
      var response = await DioHelper.get(query: {'page': 4, 'limit': 20});

      response.data['data'].forEach((element) {
        Map<String, dynamic> data = {
          'data': element,
        };
        product.add(ProductScreenItemModel(
          image: element['ProductVariations'][0]['ProductVarientImages'][0]
              ['image_path'],
          brandImage: element['Brands']['brand_logo_image_path'],
          name: element['name'],
          price: '${element['ProductVariations'][0]['price']}',
          id: '${element['id']}',
        ));
      });

      emit(GetProductsSuccessState());
    } catch (e) {
      if (e is DioException) {
        var error = ServerFailure.dioError(e);
        emit(GetProductsFailureState(error.message));
      }
      emit(GetProductsFailureState(e.toString()));
    }
  }
}
