class GetProductRequest{
  final String? categoryTitle;
  final String? search;
  final bool? isNewest;
  final bool? isBestSeller;
  final int page ;

  GetProductRequest({ this.categoryTitle, this.search, this.isNewest, this.isBestSeller,required this.page});


  Map<String,dynamic> toJson(){
    return{
      if(categoryTitle != null) 'category_title':categoryTitle,
      if(search != null) 'title':search,
      if(isNewest != null) 'is_newest':isNewest,
      if(isBestSeller != null) 'is_best_seller':isBestSeller,
      'page':page
    };

  }



}