import 'package:flutter/cupertino.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

Widget noAddressView() {
  return Column(
    children: [
      const SizedBox(height: 68),
      Image.asset('assets/images/address-no-data.png'),
      Text('地址空空如也~',
          style: textSyle700(color: AppColors.text666, fontSize: 15))
    ],
  );
}
