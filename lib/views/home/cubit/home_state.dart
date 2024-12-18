part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoadingState extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel homeModel;
  HomeSuccess({required this.homeModel});
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}

class HomeCategorySuccess extends HomeState {
  final List<CartItemModel> cartItemModel;
  HomeCategorySuccess({required this.cartItemModel});
}
class HomeSuccessAds extends HomeState {
  HomeSuccessAds();
}
class HomeGetProfile extends HomeState {
}
class HomeUpdateProfile extends HomeState {
}
class HomeLoadingUpdateState extends HomeState {
}
class GetAdsLoadingState extends HomeState {
}
class GetAdsSuccessState extends HomeState {
  final List<AdsModel> adsModel;
  GetAdsSuccessState({required this.adsModel});
}
class GetAdsErrorState extends HomeState {
  final String message;
  GetAdsErrorState({required this.message});
}
class GetCategoryLoadingState extends HomeState {
}
class GetCategorySuccessState extends HomeState {
  final List<Categories> categories;
  GetCategorySuccessState({required this.categories});
}
class GetCategoryErrorState extends HomeState {
  final String message;
  GetCategoryErrorState({required this.message});
}
class GetProductLoadingNewestState extends HomeState {
}
class GetProductSuccessNewestState extends HomeState {
  final GetProductModelResponse cartItemModel;
  GetProductSuccessNewestState({required this.cartItemModel});
}
class GetProductErrorNewestState extends HomeState {
  final String message;
  GetProductErrorNewestState({required this.message});
}
class GetProductLoadingBestSellerState extends HomeState {
}
class GetProductSuccessBestSellerState extends HomeState {
  final GetProductModelResponse cartItemModel;
  GetProductSuccessBestSellerState({required this.cartItemModel});
}

class GetProductErrorBestSellerState extends HomeState {
  final String message;
  GetProductErrorBestSellerState({required this.message});
}

class GetProductLoadingNonPopularState extends HomeState {
}

class GetProductSuccessNonPopularState extends HomeState {
  final GetProductModelResponse cartItemModel;
  GetProductSuccessNonPopularState({required this.cartItemModel});
}
class GetProductErrorNonPopularState extends HomeState {
  final String message;
  GetProductErrorNonPopularState({required this.message});
}
class HomeLoadingAddSessionState extends HomeState {
}
class HomeSuccessAddSessionState extends HomeState {
}

class GetProductLoadingNonPopularSearchState extends HomeState {
}

class GetProductSuccessNonPopularSearchState extends HomeState {
  final GetProductModelResponse cartItemModel;
  GetProductSuccessNonPopularSearchState({required this.cartItemModel});
}
class GetProductErrorNonPopularSearchState extends HomeState {
  final String message;
  GetProductErrorNonPopularSearchState({required this.message});
}

