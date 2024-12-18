class GoogleMapSearchModel {
  String? nextPageToken;
  List<ResultsGoogleMap>? results;
  String? status;

  GoogleMapSearchModel(
      {this.nextPageToken, this.results, this.status});

  GoogleMapSearchModel.fromJson(Map<String, dynamic> json) {
    if (json['html_attributions'] != null) {

    }
    nextPageToken = json['next_page_token'];
    if (json['results'] != null) {
      results = <ResultsGoogleMap>[];
      json['results'].forEach((v) {
        results!.add( ResultsGoogleMap.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class ResultsGoogleMap {
  String? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<Photos>? photos;
  String? placeId;
  dynamic rating;
  String? reference;
  List<String>? types;
  int? userRatingsTotal;
  PlusCode? plusCode;

  ResultsGoogleMap(
      {this.businessStatus,
        this.formattedAddress,
        this.geometry,
        this.icon,
        this.iconBackgroundColor,
        this.iconMaskBaseUri,
        this.name,
        this.openingHours,
        this.photos,
        this.placeId,
        this.rating,
        this.reference,
        this.types,
        this.userRatingsTotal,
        this.plusCode});

  ResultsGoogleMap.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ?  Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ?  OpeningHours.fromJson(json['opening_hours'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add( Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    rating = json['rating'];
    reference = json['reference'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
    plusCode = json['plus_code'] != null
        ?  PlusCode.fromJson(json['plus_code'])
        : null;
  }

}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ?  Viewport.fromJson(json['viewport'])
        : null;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ?  Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ?  Location.fromJson(json['southwest'])
        : null;
  }
}

class OpeningHours {
  bool? openNow;

  OpeningHours({this.openNow});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }

}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }
}