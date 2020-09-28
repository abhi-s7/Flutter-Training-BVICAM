/*
Q1. Maintain 5 Customer Records and Customer are access by Name.
Each Customer has Address , 
Address can be office, res

Amit —> Address
Office , res
Office address can be N But Unique
Res Address can be N But Unique

Customer also has Orders , Orders are N and Order are access BY Id, Order Contains Product, Product can be N, Product are sorted by Prices.
Product can be Duplicate.
Also Print Summary Report - Total Amount of Product.
*/
import 'dart:io';

class Customer {
  var name;
  var officeAdd; //list
  var resAdd; //list
  Map<int, List>
      orders; //it should be map ==> key:order_id & value: object of products
  Customer(name) {
    this.name = name;
    officeAdd = new Set(); //set because it should be unique
    resAdd = new Set();
    orders = new Map();// orders will contain a map of list and list will further contains the Product object because we want product price and name
  }
}

class Product {
  var name;
  int price;

  Product({this.name, this.price});
}

/*********************************************** Main Method **********************************************************************************************/
void main() {
  Map<String, Customer> customers = new Map(); //this is the main map key: customer name n value: Customer object which will have customer details
  while (true) {
    //looping so a to take details of many customers
    stdout.write('Enter Customer name or -1 to stop adding \n');
    var name = stdin.readLineSync();

    if (name == '-1') break;
    customers.putIfAbsent(name, () => createCustomer(name)); //createCustomer() will get the details of the customer and return Customer as object
  }

//***************** Below code is for printing the Customers data ********************** */
  for (MapEntry map in customers.entries) {
    //looping through the map through MapEntry => it gives Key and value into map varible 
    print('Name of customer: ${map.key}');
    Customer customer = map.value;
    print('Office Addresses are: ${customer.officeAdd}');
    print('Residential Addresses are: ${customer.resAdd}');

    Map<int, List> ordersMap = customer.orders; //this contains another map of orders which will have key: order id and 
                                          // value: list[Product] and Product is an object that contains ProductName and ProductPrice

    int sum = 0;
    ordersMap.forEach((k, v) { //another method to loop through the Map
      stdout.write('Order ID: $k & Product List: [ ');
      v.forEach((product){
        sum+=product.price; //this will give the collective sum of all the orders being placed
        stdout.write('[Name: ${product.name}, Price: ${product.price}] ');
      });
      stdout.write(']');
      print('');

    });//loop ordersMap ends here
    print('Total Product Price $sum');
  }//loop customers map ends here
}
/*******************************************************************************************************************************************************/

/********************************************** Adding the details of the Customer *********************************************************************/

Customer createCustomer(String name) {
  Customer customer = new Customer(name);

  while (true) {//taking the office address. As it can be N so loop unlimited untill -1 entered to stop it
    stdout
        .write('Enter Office address of: $name or enter -1 to stop adding \n');

    String address = stdin.readLineSync();

    if (address == '-1') break;
    customer.officeAdd.add(address);
  }

  while (true) {//taking the residential address and the approach is same as above
    stdout.write(
        'Enter Residential address of: $name or enter -1 to stop adding \n');
    String address = stdin.readLineSync();

    if (address == '-1') break;
    customer.resAdd.add(address);
  }

  //both officeAddress and residentialAddress are part of Customer object

  while (true) {//now time to enter the orders of the customer

    stdout.write("Enter order id or either enter -1 to stop adding \n");
    int orderId = int.parse(stdin.readLineSync());

    if (orderId == -1) break;
    List list = createProduct(); //here a single orderId can contain multiple Products therefore createProduct() methods gives the list of products
    //sorting the list according to price
    list.sort((a,b)=>a.price.compareTo(b.price)); //compareTo used because Product is an object so we have to compare the price of two products

    customer.orders.putIfAbsent(orderId, () => list); //finally adding the list into orders map which further gets added to Customer() object and then into 'customers map'
  }
  
  return customer;
}

/**********************************************************************************************************************************************/

/******************************************* Creating the Product List ************************************************************************/
List createProduct() {
  List<Product> list = new List();

  while(true){
  stdout.write('Enter Product name or -1 to cancel \n');
  var name = stdin.readLineSync();
  if(name == '-1')
    break;
  
  stdout.write('Enter Price of $name \n');
  int price = int.parse(stdin.readLineSync());
  
  list.add(new Product(name: name, price: price));//here Product is an object and thus creating an object of it and adding it into the list and also looping to add multiple Products
  }
  return list;
}

/*************************************************************************************************************************************************/