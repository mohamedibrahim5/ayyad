import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';

import '../../../model/responses/create_address_model_respose.dart';

class MyAddressWidget extends StatelessWidget {
  const MyAddressWidget({super.key,
    // required this.addNewAddressRequest,
    required this.createAddressModelResponse});
  // final AddNewAddressRequest addNewAddressRequest;
  final CreateAddressModelResponse createAddressModelResponse;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: ColorsManager.greyTextScreen3,
          width: 1
        ),
      ),
      child: Padding(
        padding:  REdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(
                    AssetsManager.location,
                    height: 14.sp,
                    width: 14.sp,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          createAddressModelResponse.label ?? '',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp
                          ),
                        ),
                        SizedBox(
                          width: 4.h,
                        ),
                        Text(
                          createAddressModelResponse.locationName ?? '',
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              AssetsManager.arrowRight2,
              // height: 24.sp,
              // width: 24.sp,
            ),

          ],
        ),
      ),
    );
  }
}
