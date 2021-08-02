class ShopCartModel
{
  String productName ;
  String productPrice ;
  String productQuantity ;
  String productImage;
  String productId;
  ShopCartModel({this.productName,this.productImage,this.productPrice,this.productQuantity,this.productId}) ;
  ShopCartModel.FromJson(Map<String,dynamic>json)
  {
    productName = json['productName'] ;
    productPrice = json['productPrice'] ;
    productQuantity = json['productQuantity'] ;
    productImage = json['productImage'] ;
    productId = json['productId'] ;
  }
  Map<String,dynamic>toMap()
  {
    return {
      'productName':productName ,
      'productPrice':productPrice ,
      'productQuantity':productQuantity ,
      'productImage':productImage ,
      'productId':productId ,
    };
  }
}