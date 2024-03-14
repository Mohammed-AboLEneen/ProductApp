import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_app/errors/server_failure.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_states.dart';
import 'package:splash_app/manager/products_cubit/products_states.dart';
import 'package:splash_app/models/product_model.dart';

import '../../models/property_model.dart';
import '../../utils/dio_helper.dart';

class ProductItemScreenCubit extends Cubit<ProductItemScreenStates> {
  ProductItemScreenCubit() : super(ProductItemScreenInitial());

  static ProductItemScreenCubit get(context) => BlocProvider.of(context);

  late Product product;
  int selectedVariation = 0;
  List<PropertyModel> properties = [
    PropertyModel(), // size
    PropertyModel(), // color
    PropertyModel(), // material
  ];

  Future<void> getProductItem(id) async {
    emit(GetProductItemLoadingState());

    try {
      var response = await DioHelper.get(endPoint: '$id');

      product = Product.fromJson(response.data);

      product.data?.avaiableProperties?.asMap().forEach((key, value) {
        if (value.property == 'Color') {
          properties[1].isExist = true;
          properties[1].propertyIndex = key;
        } else if (value.property == 'Size') {
          properties[0].isExist = true;
          properties[0].propertyIndex = key;
        } else if (value.property == 'Material') {
          properties[2].isExist = true;
          properties[2].propertyIndex = key;
        }
      });
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
