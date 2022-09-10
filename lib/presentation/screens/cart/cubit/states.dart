abstract class CartStates {}

class CartInitial extends CartStates {}

// get Cart

class CartGetDataLoading extends CartStates {}

class CartGetDataSuccess extends CartStates {}

class CartGetDataError extends CartStates {}

class CartAddToCartSuccess extends CartStates {}

class CartRemoveFromCartSuccess extends CartStates {}

class CartRemoveFromCartLoading extends CartStates {}

class UploadCartGetLoading extends CartStates {}

class UploadCartGetSuccess extends CartStates {}
