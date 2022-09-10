import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_lampa/core/utils/responsive.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/validation.dart';
import '../../../../domain/models/zones/zone_model.dart';
import '../../../componants/customtext.dart';
import '../../../shared/login_text_failed.dart';
import '../cubit/cubit.dart';

class SelectPaymentMethode extends StatefulWidget {
  SelectPaymentMethode({
    Key? key,
    required this.isShipping,
  }) : super(key: key);
  final bool isShipping;
  @override
  State<SelectPaymentMethode> createState() => _SelectPaymentMethodeState();
}

class _SelectPaymentMethodeState extends State<SelectPaymentMethode> {
  @override
  Widget build(BuildContext context) {
    final cubit = CheckOutCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        CustomText("country".tr(), fontsize: 18.fs),
        DefaultTextField(
          controller: TextEditingController(text: "Egypt"),
          keyboardType: TextInputType.text,
          enable: false,
          validate: Validation().defaultValidation,
        ),
        CustomText("city".tr(), fontsize: 18.fs),
        DropdownSearch<WooZonesModel>(
          validator: (value) {
            if (value == null) {
              return ('emptyfield'.tr());
            } else
              return null;
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.all(4),
          )),
          selectedItem: widget.isShipping
              ? cubit.selectedZoneShipping
              : cubit.selectedZone,
          onChanged: (s) async {
            widget.isShipping
                ? cubit.selectedZoneShipping = s
                : cubit.selectedZone = s;
            cubit.shippingZoneMethod = null;
            await cubit.selectShippingMethode(context, int.parse(s!.zoneId!));
          },
          items: cubit.zones,
          itemAsString: (item) => (item.locationCode ?? "").tr(),
        ),
        SizedBox(
          height: 15,
        ),
        CustomText("shipping".tr(), weight: FontWeight.w500, fontsize: 20.fs),
        SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cubit.methods
              .map((e) => InkWell(
                    onTap: () {
                      widget.isShipping
                          ? cubit.shippingZoneMethod = e
                          : cubit.billingShippingZoneMethod = e;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        CustomText((e.settings?.title?.value ?? "")
                                .toString()
                                .tr() +
                            " " +
                            (e.settings?.cost?.value ?? "") +
                            " "
                                "${(e.settings?.cost?.value?.isNotEmpty ?? false) ? "sr".tr() : ""} "),
                        Spacer(),
                        widget.isShipping
                            ? Icon(
                                cubit.shippingZoneMethod != e
                                    ? Icons.radio_button_off
                                    : Icons.radio_button_checked,
                                color: AppColors.primiry)
                            : Icon(
                                cubit.billingShippingZoneMethod != e
                                    ? Icons.radio_button_off
                                    : Icons.radio_button_checked,
                                color: AppColors.primiry)
                      ],
                    ),
                  ))
              .toList(),
        ),
        Divider(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
