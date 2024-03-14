abstract class ProductItemScreenStates {}

class ProductItemScreenInitial extends ProductItemScreenStates {}

class GetProductItemLoadingState extends ProductItemScreenStates {}

class GetProductItemFailureState extends ProductItemScreenStates {
  final String error;

  GetProductItemFailureState(this.error);
}

class GetProductItemSuccessState extends ProductItemScreenStates {}

class ChangeVariationState extends ProductItemScreenStates {}
