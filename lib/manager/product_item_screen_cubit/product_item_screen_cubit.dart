import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_app/errors/server_failure.dart';
import 'package:splash_app/manager/product_item_screen_cubit/product_item_screen_states.dart';
import 'package:splash_app/manager/products_cubit/products_states.dart';
import 'package:splash_app/models/custom_variation_model.dart';
import 'package:splash_app/models/product_model.dart';

import '../../models/property_model.dart';
import '../../utils/dio_helper.dart';

class ProductItemScreenCubit extends Cubit<ProductItemScreenStates> {
  ProductItemScreenCubit() : super(ProductItemScreenInitial());

  static ProductItemScreenCubit get(context) => BlocProvider.of(context);

  late Product product;
  int selectedVariation = 0;

  List<CustomVariationModel> customVariations = [];

  Future<void> getProductItem(id) async {
    emit(GetProductItemLoadingState());

    try {
      var response = await DioHelper.get(endPoint: '$id');

      product = Product.fromJson(response.data);
      print(product.data?.id);
      //product.data.variations..sort((a, b) => int.parse(a.productPropertiesValues, radix: 16).compareTo(int.parse(b, radix: 16)));
      createCustomVariations();

      print('data: ');
      for (var element in customVariations) {
        print(element.sizes);
        print(element.materials);
        print(element.color);
        print('\n');
      }
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

  void createCustomVariations() {
    product.data?.variations?.asMap().entries.forEach((element) {
      String? variationSize;
      String? variationMaterial;
      String? variationColor;

      element.value.productPropertiesValues?.forEach((e) {
        if (e.property == 'Size') {
          variationSize = e.value;
        } else if (e.property == 'Materials') {
          variationMaterial = e.value;
        } else {
          variationColor = e.value;
        }
      });
      if (customVariations.isEmpty) {
        var tempVariation = CustomVariationModel(
            color: variationColor, price: element.value.price);
        tempVariation.sizes = [variationSize];
        tempVariation.materials = [variationMaterial];
        customVariations.add(tempVariation);
      } else {
        for (int i = customVariations.length - 1; i >= 0; i--) {
          // search for the same color and add to it current variation size and current variation material.
          if (customVariations[i].color == variationColor) {
            if (variationSize != null) {
              customVariations[i].sizes?.add(variationSize);
            }

            if (variationMaterial != null) {
              // to ensure that the same material is not added.
              for (int j = 0; j < customVariations.length; j++) {
                if (customVariations[j].materials![j] == variationMaterial) {
                  break;
                }
                customVariations[i].materials?.add(variationMaterial);
              }
            }
            break;
          }

          // if not found create new variation.
          customVariations.add(CustomVariationModel(
              color: variationColor,
              price: element.value.price,
              materials: [variationMaterial],
              sizes: [variationSize]));
        }
      }
    });
  }

  void changeVariation(int index) {
    selectedVariation = index;
    emit(ChangeVariationState());
  }
}
