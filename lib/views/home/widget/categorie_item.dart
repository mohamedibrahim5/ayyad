import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
        // required this.selected,
        required this.onTap,
        required this.title,
        required this.image,
        required this.index});

  // final bool selected;
  final Function() onTap;
  final String title;

  final String image;

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 12, ),
              child: Text(
                title,
                style:
                // selected
                //     ? Theme.of(context).textTheme.bodySmall!.copyWith(
                //     fontWeight: FontWeight.w500, fontSize: 10.sp)
                //     :
                Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                // cacheKey: 'myUniqueKey_${image}',
                  imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    width: 90.r,
                    height: 90.r,
                    fit: BoxFit.fill,
                  ),
                  imageUrl: image,
                  fadeOutDuration: const Duration(milliseconds: 0),
                  placeholder: (context, url) =>
                      const LoadingIndicatorWidget(
                        isCircular: true,
                        size: 50,
                      ),
                  errorWidget: (context, url, error) => Container(
                    width: 90.w,
                    height: 90.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: SvgPicture.asset(
                      fit: BoxFit.fill,
                      AssetsManager.personIcon,
                      height: 90.h,
                      width: 90.w,
                    ),
                  )),
            ),
          ],
        ));
  }
}
