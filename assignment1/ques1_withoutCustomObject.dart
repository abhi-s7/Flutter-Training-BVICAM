import 'dart:io';
void main(){

  var customers = addingInMapHardcoded();//this will give the customers Map


  for (MapEntry map in customers.entries) {
    //looping through the map through MapEntry => it gives Key and value into map varible 
    print('Name of customer: ${map.key}');
    var customerInfo = map.value;
    var addresses = customerInfo[0];
    print('Office Addresses are: ${addresses[1]}');
    print('Residential Addresses are: ${addresses[0]}');

    Map<int, List> ordersMap = customerInfo[1];
    int sum = 0;
    ordersMap.forEach((k, v) { //another method to loop through the Map
      //v contains list of products therefore take it and sort it
      v.sort((a,b) => a - b);
      stdout.write('Order ID: $k & Product List: $v');

      sum +=  //this gives collective sum of all the order id
       v.fold(0, (previousValue, current)=> current);// this will give the sum of all the elements present in list of one order it

      print('');

    });//loop ordersMap ends here
    print('Total Product Price: $sum');
    print('');
  }//loop customers map ends here

}

Map addingInMapHardcoded(){
  var customer = Map();

  /************** Customer 1************ */
  customer.putIfAbsent("abhishek",()=> [
    [
      {"B-182", "Rohini"},//res address
      {"Google Mountain View", "Cupertino"}//office address
    ],//list of addresses

    {101: [  19000, 1000, 599, 56000]
      /*
      {"prod_name" : "Mobile", "prod_price" : 1000},
            {"prod_name" : "TV", "prod_price" : 19000},
            {"prod_name" : "Laptop", "prod_price" : 45000},
            {"prod_name" : "Cakes", "prod_price" : 500}
            //it is not object rather a Map = _InternalLinkedHashMap<String, Object>
            //every {} is a Map so sorting function of list won't work on it
            //therefore store only list of prices of products
            //if we want to display all the product information then we should create custom object and then run compareTo() to sort the list
          ]
          */
    , 
    102: [ 7000, 100, 200]
    }//Map of orders
    ]);

  /************** Customer 2************ */
    customer.putIfAbsent("neha",()=> [
    [
      {"G618", "Dwarka"},//res address
      {"Banglore", "Chandigarh"}//office address
    ],//list of addresses
    {
    12: [2999,50000]
    }//Map of orders
    ]);

  /************** Customer 3************ */
    customer.putIfAbsent("mayank",()=> [
    [
      {"Hno 221"},//res address
      {"Sona road Gurugram", "Banglore", "Noida"}//office address
    ],//list of addresses
    {
      1011: [ 2000,3500,20000,3000,3000]//list of product prices
    
    }//Map of orders
    ]);

    /************** Customer 4************ */
    customer.putIfAbsent("Lakshay",()=> [
    [
      {"Sector 7", "Rohini Delhi"},//res address
      {"Chandigarh", "Noida"}//office address
    ],//list of addresses
    {2001: [ 50000,2999
          ]
    , 
    2002: [ 1000, 2000, 599
           ]
    }//Map of orders
    ]);

      /************** Customer 5************ */
    customer.putIfAbsent("Aishwarya",()=> [
    [
      {"Sector 7", "Rohini Delhi"},//res address
      {"Chandigarh", "Noida"}//office address
    ],//list of addresses
    {3001: [ 1000,800,333,1299 ]
    , 
    3002: [8400 ]
    }//Map of orders
    ]);
    return customer;
}

//*************************************************************** */
//another approach of adding the details to the Customers Map
void harcoded2(){
  
  Set<String> resAdd = Set();
  Set<String> offAdd = Set();

  List<Set<String>> address = List();
  List<Object> product = List();

  Map<int, List<Object>> orders = Map();

  List<dynamic> custDetails = List();

  Map<String, List<dynamic>> customer = Map();

  //Start adding details of Customers
  resAdd..add("B-182")..add("Gurugram")..add("Dwarka");
  offAdd..add("Banglore")..add("Gurugram");
  //adding the address
  address..add(resAdd)..add(offAdd);

  //adding in product
  product..add({"prod_name" : "Mobile", "prod_price" : 1000})
         ..add({"prod_name" : "TV", "prod_price" : 19000})
         ..add({"prod_name" : "Laptop", "prod_price" : 45000})
         ..add({"prod_name" : "Cakes", "prod_price" : 500});

  orders.putIfAbsent(101,()=> product);
  product.clear();
  
  product..add({"prod_name" : "Samsung Smartphone", "prod_price" : 1000})
         ..add({"prod_name" : "Stationary", "prod_price" : 700});

  orders.putIfAbsent(102,()=> product);

  custDetails..add(address)..add(orders);
  customer.putIfAbsent("Abhishek", ()=>custDetails);

}