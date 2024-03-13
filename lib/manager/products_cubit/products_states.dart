abstract class ProductsStates {}

class ProductsInitialState extends ProductsStates {}
class GetProductsSuccessState extends ProductsStates {}
class GetProductsFailureState extends ProductsStates {

  final String error;
  GetProductsFailureState(this.error);
}
class GetProductsLoadingState extends ProductsStates {}

