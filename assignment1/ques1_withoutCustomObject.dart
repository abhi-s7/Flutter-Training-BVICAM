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
      // v.sort((a,b) => a - b);//since it is a map inside the list therefore this won't work
      //v.sort((a,b) => a.price.compareTo(b.price));//this won't work either
      v.sort((a,b) => a['prod_price'].compareTo(b['prod_price']));
      stdout.write('Order ID: $k & Product List: $v');

      v.forEach((ele) {
        //print('Ele is $ele');//ele is a hashmap
        sum += ele['prod_price'];
      });
      // sum +=  //this gives collective sum of all the order id
      //  v.fold(0, (previousValue, current)=> current);// this will give the sum of all the elements present in list of one order it

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

    {101: [
      
      {"prod_name" : "Mobile", "prod_price" : 1000},
            {"prod_name" : "TV", "prod_price" : 19000},
            {"prod_name" : "Laptop", "prod_price" : 45000},
            {"prod_name" : "Cakes", "prod_price" : 500}
            //it is not object rather a Map = _InternalLinkedHashMap<String, Object>
            //if we want to display all the product information then we should create custom object and then run compareTo() to sort the list
          ]
    , 
    102: [ {"prod_name" : "Jeans", "prod_price" : 7000},
             {"prod_name" : "Stationary", "prod_price" : 100}
           ]
    }//Map of orders
    ]);

  /************** Customer 2************ */
    customer.putIfAbsent("neha",()=> [
    [
      {"G618", "Dwarka"},//res address
      {"Banglore", "Chandigarh"}//office address
    ],//list of addresses
    {10: [ {"prod_name" : "Bags", "prod_price" : 29122},
            {"prod_name" : "Shushi", "prod_price" : 1100}
          ]
    , 
    12: [ {"prod_name" : "Jeans", "prod_price" : 7000},
           {"prod_name" : "TV", "prod_price" : 23432},
           {"prod_name" : "Bag", "prod_price" : 12330}
           ]
    }//Map of orders
    ]);

  /************** Customer 3************ */
    customer.putIfAbsent("mayank",()=> [
    [
      {"Hno 221"},//res address
      {"Sona road Gurugram", "Banglore", "Noida"}//office address
    ],//list of addresses
   {1011: [ {"prod_name" : "Samsung Smartphone", "prod_price" : 1000},
            {"prod_name" : "Bravia TV", "prod_price" : 1100},
            {"prod_name" : "Mac book", "prod_price" : 45000},
          ]
    , 
    1022: [ {"prod_name" : "Groceries", "prod_price" : 1000},
             {"prod_name" : "Stationary", "prod_price" : 700}
           ]
    }//Map of orders
    ]);

    /************** Customer 4************ */
    customer.putIfAbsent("Lakshay",()=> [
    [
      {"Sector 7", "Rohini Delhi"},//res address
      {"Chandigarh", "Noida"}//office address
    ],//list of addresses
     {2001: [ {"prod_name" : "Apple iPhone", "prod_price" : 60000},
            {"prod_name" : "Phone Cover", "prod_price" : 999},
          ]
    , 
    2002: [ {"prod_name" : "Thermos", "prod_price" : 850},
             {"prod_name" : "Piano", "prod_price" : 70000},
             {"prod_name" : "Ice cream", "prod_price" : 600}
           ]
    }//Map of orders
    ]);

      /************** Customer 5************ */
    customer.putIfAbsent("Aishwarya",()=> [
    [
      {"Sector 7", "Rohini Delhi"},//res address
      {"Chandigarh", "Noida"}//office address
    ],//list of addresses
    {2001: [ 
            {"prod_name" : "Bags", "prod_price" : 91000},
            {"prod_name" : "Shoes", "prod_price" : 1199},
            {"prod_name" : "Phone", "prod_price" : 60000},
            {"prod_name" : "Chocolates", "prod_price" : 900}
          ]
    , 
    2002: [ {"prod_name" : "Tops", "prod_price" : 8950},
           ]
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
