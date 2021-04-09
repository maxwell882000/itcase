class Pivot{
  int priceFrom,
      priceTo,
      pricePerHour;


  Pivot.fromJson(Map json){
    priceFrom = json['price_from'];
    priceTo  = json['price_to'];
    pricePerHour =  json['price_per_hour'];
  }
}