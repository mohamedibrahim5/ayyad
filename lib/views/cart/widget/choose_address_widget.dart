import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';

import '../../../model/responses/create_address_model_respose.dart';

class ChooseAddressWidget extends StatelessWidget {
  const ChooseAddressWidget({super.key,required this.addNewAddressRequest,required this.isSelected,required this.isHome});
  final CreateAddressModelResponse addNewAddressRequest;
  final bool isSelected ;
  final bool isHome ;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
            color:isSelected ? ColorsManager.primaryColor : ColorsManager.greyTextScreen3,
            width: 1
        ),
      ),
      child: Padding(
        padding:  REdgeInsets.all(8.0),
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
                    colorFilter: isSelected ? const ColorFilter.mode(ColorsManager.primaryColor, BlendMode.srcIn) : null,
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
                          addNewAddressRequest.label ?? '',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 10.sp
                          ),
                        ),
                        // SizedBox(
                        //   width: 4.h,
                        // ),
                        isHome ?
                        Text(
                            addNewAddressRequest.locationName ?? '',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ):
                        Expanded(
                          child: Text(
                            addNewAddressRequest.locationName ?? '',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(isSelected)
              SvgPicture.asset(
                AssetsManager.arrowCircle,
                colorFilter: const ColorFilter.mode(ColorsManager.primaryColor, BlendMode.srcIn),
                // height: 24.sp,
                // width: 24.sp,
              ),

          ],
        ),
      ),
    );
  }
}
