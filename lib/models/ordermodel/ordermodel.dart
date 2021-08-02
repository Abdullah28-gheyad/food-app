
class OrderModel
{
  String address ;
  String datetime ;
  String amount ;
  OrderModel({this.datetime,this.address,this.amount}) ;
  OrderModel.FromJson(Map<String,dynamic>json)
  {
    address = json['address'];
    datetime = json['datetime'];
    amount = json['amount'];
  }
  Map <String,dynamic> topMap()
  {

    return{
      'address':address,
      'datetime':datetime,
      'amount':amount,
    };
  }
}