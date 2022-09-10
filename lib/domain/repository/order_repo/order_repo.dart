import '../../../core/utils/utils.dart';
import '../../../data/sources/api/dio.dart';
import '../../endpoints/endpoint.dart';
import '../../models/order/wooorder.dart';
import '../../models/order/wooorder_payload.dart';
import '../../models/zones/shippingzone.dart';
import '../../models/zones/zone_model.dart';

class OrderRepo {
  static createOrder(context, {required WooOrderPayload orderPayload}) async {
    final response = await DioHelper.postData(context,
        url: EndPoins.DEFAULT_WC_API_PATH + 'orders',
        query: {
          "consumer_key": "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32",
          "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce"
        },
        loading: true,
        body: orderPayload.toJson());
    if (response != null) {
      return true;
    }
  }

  static Future<List<WooOrder>?> getOrders(context) async {
    final response = await DioHelper.getData(context,
        url: EndPoins.DEFAULT_WC_API_PATH + 'orders',
        query: {
          "page": 1,
          "perPage": 100,
          "customer": Utiles.UserId,
          "consumer_key": "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32",
          "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce"
        });
    if (response != null) {
      List<WooOrder> list = [];
      for (var o in response.data) {
        var order = WooOrder.fromJson(o);
        list.add(order);
      }
      return list;
    }
  }

  static Future<List<WooZonesModel>?> getZones(context) async {
    final response = await DioHelper.getData(context,
        url: '/wp-json/mo/v1/Zones', token: Utiles.token);
    if (response != null) {
      List<WooZonesModel> zones = [];
      for (var o in response.data) {
        var order = WooZonesModel.fromJson(o);
        zones.add(order);
      }
      return zones;
    }
  }

  static Future<List<WooShippingZoneMethod>?> getShippingforZone(
      context, int id) async {
    final response = await DioHelper.getData(
      context,
      loading: true,
      url: EndPoins.DEFAULT_WC_API_PATH +
          'shipping/zones/' +
          id.toString() +
          '/methods',
      query: {
        "consumer_key": "ck_d5f8649bb3448e0c9361b9decff736ca82f33c32",
        "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce"
      },
    );
    if (response != null) {
      List<WooShippingZoneMethod> zones = [];
      for (var o in response.data) {
        var order = WooShippingZoneMethod.fromJson(o);
        zones.add(order);
      }
      return zones;
    }
  }
}
