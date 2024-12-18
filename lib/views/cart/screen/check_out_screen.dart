import 'package:bottom_picker/bottom_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:ibnelbarh/model/requests/check_out_request.dart';
import 'package:ibnelbarh/model/responses/get_cart_model.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/constant.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/base_button_bar/cubit/base_screen_navigation_cubit.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';
import 'package:ibnelbarh/views/cart/widget/choose_address_widget.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';

import '../widget/balance_widget.dart';
import '../widget/choose_pay_with_widget.dart';
import '../widget/full_number_number_checkout_widget.dart';
import '../widget/payment_details_widget.dart';
import '../widget/promo_code_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> with SingleTickerProviderStateMixin{
  // List<String> items = ['Branch 1', 'Branch 2', 'Branch 3', 'Branch 4'];
  late Map args;
  late GetCartModel cartItem;
   double totalPrice = 0 ;
   double deliveryFee = 0 ;
   double deliveryFeesPres = 0 ;
   double totalAmount = 0 ;
  double servesFees= 0 ;
  bool addBalance = false;

  String? selectBranch ;
  int? selectBranchId ;
  // int chooseAddress = -1 ;
  bool isCash = true ;
  Country? phoneNumber ;
  int? promoCodeId;
  // late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    cartItem = args[Constants.cartModel];
    totalPrice = double.parse(cartItem.totalPrice ?? '0') ;
    totalAmount = totalPrice ;
  }

  // DateTime? selectedDate ;
  // TimeOfDay? selectedTime ;
  late TextEditingController _promoCodeController ;
  late TextEditingController _fullNameController ;
  late TextEditingController _phoneController ;
  late TextEditingController _dateController ;
  late TextEditingController _timeController ;
  late TextEditingController _notesController ;
  late FocusNode _phoneFocusNode;
  String errorTextPhone = '';
  String errorTextName = '';
  DateTime? datePerson ;
  DateTime? timePerson ;



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorTextDiscount = '';
  late FocusNode _promoCodeFocusNode;
  bool selectDateColor = false ;
  bool selectTimeColor = false ;
  bool selectBranchColor = false ;
  bool selectName = false ;
  bool selectPhone = false ;
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]*$');


  getDate() {
    BottomPicker.date(
      dismissable: true,
      pickerTextStyle: TextStyle(
          color: ThemeCubit.get(context).isDark
              ? ColorsManager.blackColor2DarkMode
              : ColorsManager.blackColor,
          fontSize: 14.sp),
      closeIconColor:  ColorsManager.primaryColor,
      backgroundColor:ThemeCubit.get(context).isDark ? ColorsManager.backgroundColorDarkMode :  ColorsManager.whiteColor,
      buttonSingleColor: ColorsManager.red,
      pickerTitle: const Text('',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 1,
        color: ColorsManager.primaryColor,
      ),),
      buttonStyle: BoxDecoration(
        color: ColorsManager.primaryColor,
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      buttonContent: Center(
        child: Text(
          StringsManager.ok.tr(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 16.sp,
            // color:  ColorsManager.blackColor,
          ),
        ),
      ),
      onSubmit: (date) {
        setState(() {
           _dateController.text = '${date.toString().split(' ').first.split('-').last}-${date.toString().split(' ').first.split('-')[1]}-${date.toString().split(' ').first.split('-').first}';

          // _dateController.text = "${date.toLocal()}".split(' ')[0];
          datePerson = date;
          selectDateColor = false ;
          formKey.currentState!.validate();
          if(timePerson == null){
            selectTimeColor = true ;
          }
        });
      },
      minDateTime:DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day,0,0,0),
      maxDateTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 2),
      initialDateTime:datePerson ??  DateTime.now(),
    ).show(context);
  }

  getTime() {
    BottomPicker.time(
      dismissable: true,
      pickerTextStyle: TextStyle(
          color: ThemeCubit.get(context).isDark
              ?  ColorsManager.blackColor2DarkMode
              : ColorsManager.blackColor,
          fontSize: 14.sp),
      closeIconColor:  ColorsManager.primaryColor,
      backgroundColor:ThemeCubit.get(context).isDark ? ColorsManager.backgroundColorDarkMode :  ColorsManager.whiteColor,
      buttonSingleColor: ColorsManager.red,
      pickerTitle: const Text('',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 1,
        color: ColorsManager.primaryColor,
      ),),
      buttonStyle: BoxDecoration(
        color: ColorsManager.primaryColor,
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      buttonContent: Center(
        child: Text(
          StringsManager.ok.tr(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 16.sp,
            // color:  ColorsManager.blackColor,
          ),
        ),
      ),
      onSubmit: (time) {
        setState(() {
          _timeController.text = "${time.toString().split(' ').last.split(':').first}:${time.toString().split(' ').last.split(':')[1]}";
          timePerson = time;
          selectTimeColor = false ;
          formKey.currentState!.validate();
          if(datePerson == null){
            selectDateColor = true ;
          }
        });
      },
      initialTime: timePerson == null ?   Time.now():Time(
          hours: timePerson?.hour ?? 0,
        minutes: timePerson?.minute ?? 0,
      ),
      minTime: Time.now(),
    ).show(context);
  }


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is AddCoupanErrorState){
          FocusManager.instance.primaryFocus?.unfocus();
          Utils.showSnackBar(state.message,context);
        }
        if(state is AddCouponSuccess){
          if(state.addCouponResponse.discount != null){
            deliveryFeesPres = state.addCouponResponse.discount?.toDouble() ?? 0 ;
            deliveryFee = totalPrice * deliveryFeesPres / 100 ;
            totalPrice = totalAmount - deliveryFee ;
            promoCodeId = state.addCouponResponse.id;
          }else {
            setState(() {
              _promoCodeFocusNode.requestFocus();
              errorTextDiscount = state.addCouponResponse.coupon ?? '';
              // formKeyPromoCode.currentState!.validate();
              errorTextDiscount = '';
            });

            deliveryFeesPres = 0 ;
            deliveryFee = 0 ;
            totalPrice = totalAmount  ;
          }
        }
        else if (state is RemoveCouponSuccess){
          deliveryFeesPres = 0 ;
          deliveryFee = 0 ;
          totalPrice = totalAmount  ;
          promoCodeId = null;
        }
        else  if (state is CheckOutSuccess){

          BaseScreenNavigationCubit.get(context).reset();

          Utils.showSnackBar(StringsManager.orderConfirmed.tr(),context);
          sl<NavigationService>().navigateReplacementTo(RoutesManager.orderScreen);
          // _tabController.index == 1
          // if(isCash){
          //   Utils.showSnackBar(StringsManager.orderConfirmed.tr(),context);
          //   sl<NavigationService>().navigateReplacementTo(RoutesManager.orderScreen);
          //   // sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
          // }
          // if(state.addCheckOutSuccess.url != null && !isCash){
          //   sl<NavigationService>().navigateReplacementTo(RoutesManager.webViewPaymentScreen,arguments: {
          //     'url': state.addCheckOutSuccess.url
          //   });
          // }



            // BaseScreenNavigationCubit.get(context).reset();
            // sl<NavigationService>().navigateReplacementTo(RoutesManager.orderConfirmedScreen);
          }
        else if (state is CheckOutErrorState){
          Utils.showSnackBar(state.message,context);
          sl<NavigationService>().popup() ;
        }
      },
      builder: (BuildContext context, Object? state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                  padding:  REdgeInsets.all(
                      16
                  ),
                 child: Form(
                   key: formKey,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       ArrowBack(
                         title: StringsManager.checkOut.tr(),
                         onPressed: (){
                           sl<NavigationService>().popup() ;
                         },
                       ),
                       SizedBox(
                         height: 24.h,
                       ),
                       Container(
                         color: Colors.transparent,
                         child: TabBar(
                           // controller: _tabController,
                           indicatorPadding: REdgeInsets.symmetric(
                               horizontal: 24
                           ),
                           labelColor: ColorsManager.primaryColor,
                           indicatorColor: ColorsManager.primaryColor,
                           unselectedLabelColor: ColorsManager.greyText.withOpacity(0.5),
                           dividerColor: ColorsManager.greyText.withOpacity(0.5),
                           physics: const NeverScrollableScrollPhysics(),
                           onTap: (index){
                             if(index == 0){

                             }else{

                             }
                           },
                           unselectedLabelStyle: TextStyle(
                               fontWeight: FontWeight.w500,
                               fontSize: 14.sp
                           ),
                           labelStyle: TextStyle(
                               fontWeight: FontWeight.w500,
                               fontSize: 14.sp
                           ),
                           tabs: [
                             Padding(
                               padding:  REdgeInsets.only(
                                   top: 0,
                                   bottom: 8
                               ),
                               child: Text(StringsManager.pickUp.tr()),
                             ),
                             Padding(
                               padding:  REdgeInsets.only(
                                   top: 0,
                                   bottom: 8
                               ),
                               child: Text(StringsManager.delivery.tr()),
                             ),
                           ],
                         ),
                       ),
                       Expanded(
                         child: TabBarView(

                           physics: const NeverScrollableScrollPhysics(),

                           children: <Widget>[
                             SingleChildScrollView(
                               child: Column(
                                 children: [
                                   FullNumberNumberCheckoutWidget(notesController: _notesController,phoneNumber: phoneNumber,onCountryChanged: (value){setState(() {phoneNumber = value;});},isDelivery: false,fullNameController: _fullNameController, phoneController: _phoneController, phoneFocusNode: _phoneFocusNode, selectName: selectName, selectPhone: selectPhone, errorTextName: errorTextName, errorTextPhone: errorTextPhone,selectBranch: selectBranch, selectBranchColor: selectBranchColor, state: state!, selectDateColor: selectDateColor, datePerson: datePerson, onChange: (value){setState(() {selectName = true ;errorTextName = '';selectBranch = value;selectBranchId = CartCubit.get(context).allBranches.firstWhere((element) => element.name == value).id;});}, onTapDate:  () => getDate(), onTapTime:  () => getTime(), selectTimeColor: selectTimeColor, timeController: _timeController, timePerson: timePerson, dateController: _dateController,),
                                   BalanceWidget(addBalance: addBalance, onChanged: (value){setState(() {addBalance = value ;});}),
                                   PromoCodeWidget(errorTextDiscount: errorTextDiscount, promoCodeController: _promoCodeController,  promoCodeFocusNode: _promoCodeFocusNode,deliveryFees: deliveryFee,),
                                   ChoosePayWithWidget(isCash: isCash, onTapCash: (){setState(() {isCash = true ;});}, onTapCreditCard: (){setState(() {isCash = false ;});},),
                                   PaymentDetailsWidget(deliveryFee: deliveryFee,deliveryFeesPres: deliveryFeesPres,servesFees: servesFees,totalAmount: totalAmount,),
                                   Padding(
                                     padding:  REdgeInsets.symmetric(
                                         horizontal: 28,
                                         vertical: 32
                                     ),
                                     child:state is CheckOutLoadingState ?  const Center(child: LoadingIndicatorWidget()) : MainButton(
                                       title: StringsManager.placeOrder.tr(),
                                       onPressed:() async {

                                         if(selectBranch == null){
                                           setState(() {
                                             selectBranchColor = true ;
                                             Utils.showSnackBar(StringsManager.addBranch.tr(), context);
                                             return ;
                                           });
                                         }else if (_phoneController.text.isEmpty){
                                           setState(() {
                                             // selectPhone = true ;
                                             // errorTextPhone = StringsManager.enterValidPhone.tr();
                                             Utils.showSnackBar(StringsManager.enterValidPhone.tr(), context);
                                             return ;
                                           });
                                         }
                                         else {
                                           if(formKey.currentState!.validate()){
                                             await CartCubit.get(context).checkOut(checkOutRequest:CheckOutRequest(
                                                 date: "${datePerson?.year}-${datePerson?.month}-${datePerson?.day}",
                                                 time: "${timePerson?.hour}:${timePerson?.minute}:00",
                                                 phone: phoneNumber!.dialCode + _phoneController.text,
                                                 fullName:  _fullNameController.text ,
                                                 isUsedPoint: addBalance,
                                                 paymentMethod: isCash ? 'Cash' : 'Card',
                                                 branchId: selectBranchId,
                                                 promoCodeId: promoCodeId,
                                                 type: 'Pickup',
                                               notes: _notesController.text.isEmpty ? null : _notesController.text,
                                             ) );
                                           }
                                         }
                                         if(datePerson == null){
                                           setState(() {
                                             selectDateColor = true ;
                                           });

                                         }
                                         if(timePerson  == null){
                                           setState(() {
                                             selectTimeColor = true ;
                                           });
                                         }
                                         if(_fullNameController.text.isEmpty){
                                           setState(() {
                                             selectName = true ;
                                           });
                                         } else {
                                            setState(() {
                                              selectName = false ;
                                            });
                                         }
                                          // if(_phoneController.text.isEmpty || _phoneController.text.length < 10){
                                          //   setState(() {
                                          //     selectPhone = true ;
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     selectPhone = false ;
                                          //   });
                                          // }

                                         //    if(sl<PrefsHelper>().getToken2().isEmpty){


                                         // }else {
                                         //   // if(selectedDate == null || selectedTime == null){
                                         //   //   Utils.showSnackBar(StringsManager.selectDateAndTime);
                                         //   //   return;
                                         //   // }
                                         //   await CartCubit.get(context).checkOut(checkOutRequest:CheckOutRequest(
                                         //     date: "${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}",
                                         //     time: "${selectedTime?.hour}:${selectedTime?.minute}:00",
                                         //     phone: sl<PrefsHelper>().getToken2().isEmpty ? _phoneController.text : HomeCubit.get(context).getProfileResponse?.phone ?? '',
                                         //     fullName: sl<PrefsHelper>().getToken2().isEmpty ? _fullNameController.text : HomeCubit.get(context).getProfileResponse?.fullName ?? '',
                                         //   ) );
                                         // }

                                       } ,
                                     ),
                                   ),
                                 ],
                               ),
                             ),


                             SingleChildScrollView(
                               child: BlocConsumer<SettingsCubit,SettingsState>(
                                 listener: (BuildContext context, state) {  },
                                 builder: (BuildContext context, Object? state) {
                                   return
                                   Column(
                                     children: [
                                       SettingsCubit.get(context).homeAddressModelResponse == null ?
                                       GestureDetector(
                                         onTap: (){
                                           sl<NavigationService>().navigateTo(RoutesManager.googleMap,arguments: {
                                             "checkOut":true
                                           });
                                         },
                                         child: Padding(
                                           padding:  REdgeInsets.all(16.0),
                                           child: Container(
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
                                                   Row(
                                                     children: [
                                                       SvgPicture.asset(
                                                         AssetsManager.location,
                                                         height: 14.sp,
                                                         width: 14.sp,
                                                       ),
                                                       SizedBox(
                                                         width: 6.w,
                                                       ),
                                                       Text(
                                                         StringsManager.addNewAddress.tr(),
                                                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                             fontSize: 10.sp
                                                         ),
                                                       ),
                                                     ],
                                                   ),


                                                 ],
                                               ),
                                             ),
                                           ),
                                         ) ,
                                       ):
                                       Container(

                                         decoration:!ThemeCubit.get(context).isDark ? BoxDecoration(
                                             color: ColorsManager.backgroundColor,
                                             borderRadius: BorderRadius.circular(10.r),
                                             boxShadow: [
                                               BoxShadow(
                                                 color: ColorsManager.blackColorShadow.withOpacity(0.12),
                                                 spreadRadius: 0,
                                                 blurRadius: 8.r,
                                                 offset: const Offset(0, 1), // changes position of shadow
                                               ),
                                             ]
                                         ):null,
                                         child: Padding(
                                           padding:  REdgeInsets.all(16.0),
                                           child: SizedBox(
                                             height: 48.h,
                                             child:ChooseAddressWidget(
                                               isHome: false,
                                               addNewAddressRequest: SettingsCubit.get(context).homeAddressModelResponse!,
                                               isSelected: true,
                                               // isSelected: CartCubit.get(context).allIndexOfChooseItem[index],
                                             ),
                                           ),
                                         ),
                                       ),
                                       FullNumberNumberCheckoutWidget(notesController: _notesController,phoneNumber: phoneNumber,onCountryChanged: (value){setState(() {phoneNumber = value;});},isDelivery: true,fullNameController: _fullNameController, phoneController: _phoneController, phoneFocusNode: _phoneFocusNode, selectName: selectName, selectPhone: selectPhone, errorTextName: errorTextName, errorTextPhone: errorTextPhone,  selectBranch: selectBranch, selectBranchColor: selectBranchColor, state: state!, selectDateColor: selectDateColor, datePerson: datePerson, onChange: (value){setState(() {selectName = true ;errorTextName = '';});}, onTapDate:  () => getDate(), onTapTime:  () => getTime(), selectTimeColor: selectTimeColor, timeController: _timeController, timePerson: timePerson, dateController: _dateController,),
                                       BalanceWidget(addBalance: addBalance, onChanged: (value){setState(() {addBalance = value ;});}),
                                       PromoCodeWidget(errorTextDiscount: errorTextDiscount, promoCodeController: _promoCodeController,  promoCodeFocusNode: _promoCodeFocusNode,deliveryFees: deliveryFee,),
                                       ChoosePayWithWidget(isCash: isCash, onTapCash: (){setState(() {isCash = true ;});}, onTapCreditCard: (){setState(() {isCash = false ;});},),
                                       PaymentDetailsWidget(deliveryFee: deliveryFee,deliveryFeesPres: deliveryFeesPres,servesFees: servesFees,totalAmount: totalAmount,),
                                       BlocBuilder<CartCubit,CartState>(
                                         builder: (BuildContext context, state) {
                                           return Padding(
                                             padding:  REdgeInsets.symmetric(
                                                 horizontal: 28,
                                                 vertical: 32
                                             ),
                                             child:state is CheckOutLoadingState ?  const Center(child: LoadingIndicatorWidget()) : MainButton(
                                               title: StringsManager.placeOrder.tr(),
                                               onPressed:() async {

                                                 if(_fullNameController.text.isEmpty){
                                                   setState(() {
                                                     selectName = true ;
                                                   });
                                                 } else {
                                                   setState(() {
                                                     selectName = false ;
                                                   });
                                                 }
                                                 if(SettingsCubit.get(context).homeAddressModelResponse == null){
                                                   Utils.showSnackBar(StringsManager.noAddress.tr(), context);
                                                   return ;
                                                 }

                                                 if(_phoneController.text.isEmpty){
                                                   setState(() {
                                                     // selectPhone = true ;
                                                     // errorTextPhone = StringsManager.enterValidPhone.tr();
                                                     Utils.showSnackBar(StringsManager.enterValidPhone.tr(), context);
                                                     return ;
                                                   });
                                                 }

                                                 else {
                                                   if(formKey.currentState!.validate()){
                                                     await CartCubit.get(context).checkOut(checkOutRequest:CheckOutRequest(
                                                       // date: "${datePerson?.year}-${datePerson?.month}-${datePerson?.day}",
                                                       // time: "${timePerson?.hour}:${timePerson?.minute}:00",
                                                       phone: phoneNumber!.dialCode + _phoneController.text,
                                                       fullName:  _fullNameController.text ,
                                                       isUsedPoint: addBalance,
                                                       paymentMethod: isCash ? 'Cash' : 'Card',
                                                       promoCodeId: promoCodeId,
                                                         type: 'Delivery',
                                                       addressId: SettingsCubit.get(context).homeAddressModelResponse?.id,
                                                       notes: _notesController.text.isEmpty ? null : _notesController.text,
                                                       // date: "${2024}-${01}-${01}",
                                                       //  time: "${00}:${00}:00",
                                                     ) );
                                                   }
                                                 }


                                                 // if(chooseAddress == -1){
                                                 //   Utils.showSnackBar(StringsManager.noAddress.tr(), context);
                                                 // }

                                                 // if(selectBranch == null){
                                                 //   setState(() {
                                                 //     selectBranchColor = true ;
                                                 //     Utils.showSnackBar(StringsManager.addBranch.tr(), context);
                                                 //   });
                                                 // }
                                                 // if(datePerson == null){
                                                 //   setState(() {
                                                 //     selectDateColor = true ;
                                                 //   });
                                                 //
                                                 // }
                                                 // if(timePerson  == null){
                                                 //   setState(() {
                                                 //     selectTimeColor = true ;
                                                 //   });
                                                 // }
                                                 // if(_fullNameController.text.isEmpty){
                                                 //   setState(() {
                                                 //     selectName = true ;
                                                 //   });
                                                 // } else {
                                                 //   setState(() {
                                                 //     selectName = false ;
                                                 //   });
                                                 // }
                                                 // if(_phoneController.text.isEmpty || _phoneController.text.length < 10){
                                                 //   setState(() {
                                                 //     selectPhone = true ;
                                                 //   });
                                                 // } else {
                                                 //   setState(() {
                                                 //     selectPhone = false ;
                                                 //   });
                                                 // }

                                                 //    if(sl<PrefsHelper>().getToken2().isEmpty){
                                                 // if(formKey.currentState!.validate()){
                                                 //   await CartCubit.get(context).checkOut(checkOutRequest:CheckOutRequest(
                                                 //     date: "${datePerson?.year}-${datePerson?.month}-${datePerson?.day}",
                                                 //     time: "${timePerson?.hour}:${timePerson?.minute}:00",
                                                 //     phone: '+1${_phoneController.text}',
                                                 //     fullName:  _fullNameController.text ,
                                                 //   ) );
                                                 // }

                                                 // }else {
                                                 //   // if(selectedDate == null || selectedTime == null){
                                                 //   //   Utils.showSnackBar(StringsManager.selectDateAndTime);
                                                 //   //   return;
                                                 //   // }
                                                 //   await CartCubit.get(context).checkOut(checkOutRequest:CheckOutRequest(
                                                 //     date: "${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}",
                                                 //     time: "${selectedTime?.hour}:${selectedTime?.minute}:00",
                                                 //     phone: sl<PrefsHelper>().getToken2().isEmpty ? _phoneController.text : HomeCubit.get(context).getProfileResponse?.phone ?? '',
                                                 //     fullName: sl<PrefsHelper>().getToken2().isEmpty ? _fullNameController.text : HomeCubit.get(context).getProfileResponse?.fullName ?? '',
                                                 //   ) );
                                                 // }

                                               } ,
                                             ),
                                           );
                                         },
                                       ),
                                     ],
                                   );
                                 },
                               ),
                             ),
                           ],
                         ),
                       )
                     ],
                   ),
                 )
              ),
            ),
          ),
        ) ;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _promoCodeController = TextEditingController();
    _fullNameController = TextEditingController(
      // text: HomeCubit.get(context).getProfileResponse?.fullName ?? ''
    );
    _phoneController = TextEditingController(
      // text: HomeCubit.get(context).getProfileResponse?.phone ?? ''
    );
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _promoCodeFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _notesController = TextEditingController();
    // for (var _ in Constants.addNewAddressRequestBox.values) {
    //   CartCubit.get(context).allIndexOfChooseItem.add(false);
    // }
    CartCubit.get(context).getBranches();
    phoneNumber = Constants.selectedCountry;
    // _tabController = TabController(length: 2, vsync: this);
    // _tabController.addListener(_handleTabChange);

    // SettingsCubit.get(context).getAllAddressHome();

  }

  // void _handleTabChange() {
  //   if (_tabController.index == 0) {
  //     print("Tab is at index 0");
  //     // Additional logic for index 0
  //   } else {
  //     print("Tab is NOT at index 0");
  //     // Additional logic for other indices
  //   }
  // }

  @override
  void dispose() {
    _promoCodeController.dispose();
    _promoCodeFocusNode.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
