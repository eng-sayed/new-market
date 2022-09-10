abstract class OrdersStates {}

class OrdersInitial extends OrdersStates {}

// get Orders

class OrdersGetDataLoading extends OrdersStates {}

class OrdersGetDataSuccess extends OrdersStates {}

class OrdersGetDataError extends OrdersStates {}
