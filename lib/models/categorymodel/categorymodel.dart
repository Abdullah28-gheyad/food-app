class CategoryModel
{
  String name ;
  String image ;
  CategoryModel({this.image,this.name}) ;
  CategoryModel.FromJson(Map<String,dynamic>json)
  {
    name=json['categoryType'];
    image=json['productImage'];
  }
  Map<String,dynamic>toMap()
  {
    return {
      'categoryType':name,
      'productImage':image,
    };
  }
}