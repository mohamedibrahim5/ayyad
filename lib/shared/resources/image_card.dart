import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/assets_manager.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.imageUrl,this.height,this.width,this.boxFit,this.size,this.radius});
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit ;
  final double? size;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius:radius == null ?  BorderRadius.circular(10.r): BorderRadius.only(
                bottomLeft: Radius.circular(radius!),
                bottomRight: Radius.circular(radius!),
              ),
                child: Image(image: imageProvider,fit:boxFit ??  BoxFit.fill,matchTextDirection: true,width:width ?? 89.w ,height: height ?? 113.h,)),
            imageUrl: imageUrl ?? "",
            placeholder: (context, url) =>  Center(
              child:
            //
                ShimmerList(
                  height: height ?? 113,
                  width: width ?? 89,
                ),
              // LoadingIndicatorWidget(
              //   isCircular: true,
              //   size: size ?? 40,
              // ),
            ),
            errorWidget: (context, url, error) => const CustomImageError())
        : const CustomImageError();
  }
}

class CustomImageError extends StatelessWidget {
  const CustomImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: SvgPicture.asset(fit: BoxFit.fill,
        AssetsManager.personIcon,
        height: 50.h,
        width: 50.w,
      ),
    );
  }
}


class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key,required this.height,required this.width});
  final double height ;
  final double width ;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: height.h,
        width: width.w,
        child: ListView.builder(
          itemCount: 5, // Adjust the count based on your needs
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                height: height.h,
                width: height.w,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}