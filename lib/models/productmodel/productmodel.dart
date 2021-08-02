class ProductModel
{
  String categoryType ;
  String discription ;
  String price ;
  String productId ;
  String productImage ;
  String productName ;
  ProductModel({this.productName,this.productImage,this.productId,this.price,this.categoryType,this.discription}) ;
  ProductModel.FromJson(Map<String,dynamic>json)
  {
    categoryType = json['categoryType'];
    discription = json['discription'];
    price = json['price'];
    productId = json['productId'];
    productImage = json['productImage'];
    productName = json['productName'];
  }

  Map<String,dynamic>toMap()
  {
    return{
      'categoryType':categoryType,
      'discription':discription,
      'price':price,
      'productId':productId,
      'productImage':productImage,
      'productName':productName,
    };
  }

}