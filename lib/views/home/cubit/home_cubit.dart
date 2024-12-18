import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnelbarh/model/requests/get_product_request.dart';
import 'package:ibnelbarh/views/home/cubit/order_status_cubit.dart';
import '../../../model/responses/get_home_response.dart';
import '../../../model/responses/get_product_model_response.dart';
import '../../../model/responses/get_profile_response.dart';
import '../../../repository/repository.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';
import '../../socket/socket_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Repository repository;
  HomeCubit({required this.repository}) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  GetProfileResponse? getProfileResponse ;

  List<String> categoriesTitle = [
    // 'Popular',
  ];
  List<String> categoriesImage = [
    // 'assets/images/popular.png',
  ];
  String categoryTitle = '';


  HomeModel? homeModel;
  List<AdsModel>? adsModel ;
  List<Categories>? categories ;
  List<CartItemModel> cartItemModel = [];
  List<CartItemModel> cartItemModelSearch = [];

  List<CartItemModel>? productNewest ;
  List<CartItemModel>? productBestSeller ;
  List<CartItemModel>? productNonPopular ;
  List<CartItemModel>? productSearch ;
  bool loadingNewest = false;
  bool loadingBestSeller = false;
  bool loadingNonPopular = false;
  bool loadingSearch = false;
  int pageNewest = 1 ;
  int pageBestSeller = 1 ;
  int pageNonPopular = 1 ;
  int pageSearch = 1 ;


  getProfile() async {
    emit(HomeLoadingState());
    final getHomeSuccessFailure = await repository.getProfile();
    getHomeSuccessFailure.fold(
            (success) {
          getProfileResponse = success;
          emit(HomeGetProfile());
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }

  patchProfile({required String fullName,required String email})async{
    emit(HomeLoadingUpdateState());
    final getHomeSuccessFailure = await repository.patchProfile(fullName: fullName, email: email);
    getHomeSuccessFailure.fold(
            (success) {
          getProfileResponse = success;
          emit(HomeUpdateProfile());
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }



  void getHomeData()async{
    emit(HomeLoadingState());
    final getHomeSuccessFailure = await repository.getHomeData();
    getHomeSuccessFailure.fold(
            (success) {
          homeModel = success;
          // isChecked = List<bool>.filled(categoriesTitle.length, false);
          // isChecked[0] = true;
          // categoriesTitle = [
          //    'Popular',
          //  ];
          //  categoryTitle = 'Popular';
          //  isChecked = [true];
          //  for (int i = 0; i < success.categories!.length; i++) {
          //    categoriesTitle.add(success.categories![i].title!);
          //    isChecked.add(false);
          //  }
          emit(HomeSuccess(homeModel: success));
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }


  void getAdsAndCategory()async{
    emit(HomeLoadingState());
    final getHomeSuccessFailure = await repository.getHomeData();
    getHomeSuccessFailure.fold(
            (success) {
          adsModel = success.ads!;
          categories = success.categories!;
          homeModel = success;
          // isChecked = List<bool>.filled(categoriesTitle.length, false);
          // isChecked[0] = true;

          // categoriesTitle = [
          //   'Popular',
          // ];
          // categoryTitle = 'Popular';
          // isChecked = [true];

          for (int i = 0; i < success.categories!.length; i++) {
            categoriesTitle.add(success.categories![i].title!);
          }
          emit(HomeSuccessAds());
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }



  void getHomeCategoryData({required String categoryTitle,required String search})async{
    emit(HomeLoadingState());
    final getHomeSuccessFailure = await repository.getHomeDataCategory(categoryTitle: categoryTitle,search: search);
    getHomeSuccessFailure.fold(
            (success) {
          cartItemModel = success;
          emit(HomeCategorySuccess(cartItemModel: success));
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }


  void getHomeCategoryDataSearch({required String categoryTitle,required String search})async{
    emit(HomeLoadingState());
    final getHomeSuccessFailure = await repository.getHomeDataCategory(categoryTitle: categoryTitle,search: search);
    getHomeSuccessFailure.fold(
            (success) {
          cartItemModelSearch = success;
          emit(HomeCategorySuccess(cartItemModel: success));
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }

  getAds()async{
    emit(GetAdsLoadingState());
    final getAdsSuccessFailure = await repository.getAds();
    getAdsSuccessFailure.fold(
            (success) {
              adsModel = success;
          emit(GetAdsSuccessState(
            adsModel: success
          ));
        },
            (failure) => emit(GetAdsErrorState(
              message: failure.message
            ))
    );
  }

  getCategory()async{
    emit(GetCategoryLoadingState());
    final getHomeSuccessFailure = await repository.getCategory();
    getHomeSuccessFailure.fold(
            (success) {
          categoriesTitle = [];
          categoriesImage = [];
          for (int i = 0; i < success.length; i++) {
            categoriesTitle.add(success[i].title!);
          }
          for (int i = 0; i < success.length; i++) {
            categoriesImage.add(success[i].image!);
          }
          categories = success;
          emit(GetCategorySuccessState(
            categories: success
          ));
        },
            (failure) => emit(GetCategoryErrorState(
              message: failure.message
            ))
    );
  }

  getProductNewest({required int page, bool firstTime = true })async{
    emit(GetProductLoadingNewestState());
    final getHomeSuccessFailure = await repository.getProduct(
      getProductRequest:GetProductRequest(page: page,isNewest: true)
    );
    getHomeSuccessFailure.fold(
            (success) {
              if(firstTime){
                productNewest = [];
                // productBestSeller = [];
              }


              for (var element in success.cartItemModel!) {
                    productNewest!.add(element);
              }
              if(success.next == null){
                loadingNewest = true;
              }

          emit(GetProductSuccessNewestState(
            cartItemModel: success
          ));
        },
            (failure) => emit(GetProductErrorNewestState(
              message: failure.message
            ))
    );
  }


  getProductBestSeller({required int page, bool firstTime = true})async{
    emit(GetProductLoadingBestSellerState());
    final getHomeSuccessFailure = await repository.getProduct(
        getProductRequest:GetProductRequest(page: page,isBestSeller: true)
    );
    getHomeSuccessFailure.fold(
            (success) {
              if(firstTime){
                // productNewest = [];
                productBestSeller = [];
              }


          for (var element in success.cartItemModel!) {
            productBestSeller!.add(element);
          }
          if(success.next == null){
            loadingBestSeller = true;
          }

          emit(GetProductSuccessBestSellerState(
              cartItemModel: success
          ));
        },
            (failure) => emit(GetProductErrorBestSellerState(
            message: failure.message
        ))
    );
  }


  getNonPopularProduct({required int page, bool firstTime = true,required String categoryTitle })async{
    emit(GetProductLoadingNonPopularState());
    final getHomeSuccessFailure = await repository.getProduct(
        getProductRequest:GetProductRequest(page: page,categoryTitle: categoryTitle)
    );
    getHomeSuccessFailure.fold(
            (success) {
          if(firstTime){
            productNonPopular = [];
          }


          for (var element in success.cartItemModel!) {
            productNonPopular!.add(element);
          }
          if(success.next == null){
            loadingNonPopular = true;
          }

          emit(GetProductSuccessNonPopularState(
              cartItemModel: success
          ));
        },
            (failure) => emit(GetProductErrorNonPopularState(
            message: failure.message
        ))
    );
  }

  getSearchProduct({required int page, bool firstTime = true,required String searchTitle,required String categoryTitle })async{
    emit(GetProductLoadingNonPopularSearchState());
    final getHomeSuccessFailure = await repository.getProduct(
        getProductRequest:GetProductRequest(page: page,search: searchTitle,categoryTitle: categoryTitle)
    );
    getHomeSuccessFailure.fold(
            (success) {
          if(firstTime){
            productSearch = [];
          }


          for (var element in success.cartItemModel!) {
            productSearch!.add(element);
          }
          if(success.next == null){
            loadingSearch = true;
          }

          emit(GetProductSuccessNonPopularSearchState(
              cartItemModel: success
          ));
        },
            (failure) => emit(GetProductErrorNonPopularSearchState(
            message: failure.message
        ))
    );
  }


  addSession()async{
    emit(HomeLoadingAddSessionState());
    final getHomeSuccessFailure = await repository.addSession();
    getHomeSuccessFailure.fold(
            (success) {
              sl<PrefsHelper>().setSession2(success.session ?? '');
              late final SocketCubit socketCubit ;
              socketCubit = sl<SocketCubit>();
              socketCubit.init();
              sl<OrderStatusCubit>().listen(socketCubit);
              // if(sl<PrefsHelper>().getToken2().isEmpty){
              //   sl<PrefsHelper>().setSession2(success.sessionKey ?? '');
              // }else {
              //   sl<PrefsHelper>().setSession2('');
              // }
          emit(HomeSuccessAddSessionState());
        },
            (failure) => emit(HomeErrorState(message: failure.message))
    );
  }




}
