abstract class CkeckoutStates {}

class CkeckoutInitial extends CkeckoutStates {}

// get Ckeckout Data

class CkeckoutPageGetAdsLoadingState extends CkeckoutStates {}

class CkeckoutPageGetAdsErrorState extends CkeckoutStates {}

class CkeckoutPageGetAdsSuccessState extends CkeckoutStates {}

class GetCustomerDataLoadingState extends CkeckoutStates {}

class GetCustomerDataSuccessState extends CkeckoutStates {}

class GetCustomerDataErrorState extends CkeckoutStates {}

class GetShippingMethodeSuccessState extends CkeckoutStates {}

class GetShippingMethodeErrorState extends CkeckoutStates {}

class SendOrderLoadingState extends CkeckoutStates {}

class SendOrderSuccessState extends CkeckoutStates {}

class SendOrderErrorState extends CkeckoutStates {}
