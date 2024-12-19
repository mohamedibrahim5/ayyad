import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';

import '../../../shared/resources/image_card.dart';
import '../cubit/home_cubit.dart';

class CustomBannerCarousel extends StatefulWidget {
  const CustomBannerCarousel({super.key});

  @override
  State<CustomBannerCarousel> createState() => _CustomBannerCarouselState();
}

class _CustomBannerCarouselState extends State<CustomBannerCarousel> {
  late int currentPage;
  late  List<Widget> listBannersAds  ;
  @override
  void initState() {
    currentPage = 0;
    listBannersAds = HomeCubit.get(context).adsModel!
        .map((adsImage) => ImageCard(
      imageUrl: adsImage.mobileImage!,
      width: double.infinity,
    )
    )
        .toList();
    super.initState();
  }

  CarouselSliderController carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            controller: carouselController,
            items:listBannersAds ,
            options: CarouselOptions(
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              height: 122,
              aspectRatio: MediaQuery.devicePixelRatioOf(context)  ,
              animateToClosest: false,
              viewportFraction:1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onScrolled: (value) {},
              onPageChanged: (index, reason) {
                setState(() {
                  currentPage = index;
                });
              },
              scrollDirection: Axis.horizontal,
            )

        ),
      ],
    );
  }
}
