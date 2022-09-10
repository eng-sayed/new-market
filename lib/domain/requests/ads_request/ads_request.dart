class AdsRequest {
  int filterStatuse;
  int? filterSubCategory;
  int? city;
  String? priceStart;
  String? priceEnd;
  AdsRequest({
    this.filterStatuse = 0,
    this.filterSubCategory,
    this.city,
    this.priceStart,
    this.priceEnd,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'filter_status': filterStatuse});
    if (filterSubCategory != null) {
      result.addAll({'subcategory': filterSubCategory});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (priceStart != null) {
      result.addAll({'price_range_start': priceStart});
    }
    if (priceEnd != null) {
      result.addAll({'price_range_end': priceEnd});
    }
    result["per_page"] = 1;

    return result;
  }
}
