// import 'package:meta/meta.dart';
// import 'package:intl/intl.dart';
/*
1. Parent Class - Account - 2% ROI
2. Child Class - SavingAccount
  - for saving purpose and based on savings you get
  ROI - 4% annual
  Get ROI per month
  Withdraw with limit
3. Current Account
  - Business Account
  - Transactions are daily based
  - ROI - 5% but you need to pay to the bank anually
  - No withdraw limit
  - OverDraft limit
  - 
4. Fixed Deposit Account
  - ROI - 7%
  - Locking Period e.g. 2years so you cannot withdraw your money 

Features
1. Code Resuabiblity
2. Polymorphishm
*/


abstract class Account{
  //making this class as abstract so that it's object can't be created

  int _id;
  String _name;
  double _balance;
  double _roi;
 
  Account(){//default constructor that will set the default value of the properties
    _id = 0;
    _name = '';
    _balance = 0.0;
    _roi = 0.02;
  }

  //parameterized constructor to take the values from the user
  Account.allInput(int id, String name, double balance, double roi){
    this._id = id;
    this._name = name;
    this._balance = balance;
    this._roi = roi*0.01;
  }

  // void withdraw(double amount);//this becomes an abstract method
  // void withdraw(){} //while this don't 

  //this will be common for all other child accounts
  void withdraw(double amount){
    if(_balance < amount){
      print('Insufficient Funds');
      return;
    }
    _balance -= amount;
    print('Amount of $amount has been successfully deducted');
    print('Current balance is $_balance');
  }

  //this method will be common for all because here ROI is just being 
  //calculated on the bases of rate thus this will be same for all the classes
  //this is polymorphism - creating a class/method once and using it number of times
  void showROI(){

    double annualInterest = _balance*_roi;
    double monthlyInterest = annualInterest/12;
    
    print('Annual ROI is Rs. ${annualInterest.toStringAsFixed(2)}');
    print('Monthly ROI is Rs. ${monthlyInterest.toStringAsFixed(2)}');
  }

  //getter method fo the balance as it cannot be directly get to display 
  //because it is private
  get balance{
    return this._balance;
  }

  display(){
    print('Id is $_id & Name is $_name & Balance is $_balance');
  }

}

class SavingAccount extends Account{
  //hence SavingAccount is child of Account
 
  int _limit;

  // SavingAccount(this.roi, this.limit);
  SavingAccount(int id,String name, double balance,double roi, int limit) 
    : super.allInput(id,name,balance, roi){
    //this will call the parameterized constructor of the parent
    //otherwise it would have called the default constructor but that
    //does not take any values
    this._limit = limit;
  }

  @override//overriding the parent method according to Savings Account as we need to check the limit first before allowing any withdrawal transaction
  void withdraw(double amount) {
    if(amount > _limit){
      print('You cannot withdraw more than the daily limit');
      return;
    }
    
    super.withdraw(amount);
    //this is to call the original withdraw() mehtod of parent 
    //because logic for withdrawing is same in all the Accounts
    //There DRY Principle has been followed i.e. Don't Repeat Yourself
  }

}

class CurrentAccount extends Account{

  double _overdraftLimit;
  double _overdraftLoan = 0.0;

  CurrentAccount(int id, String name, double balance, double roi, double overdraftLimit) : super.allInput(id,name,balance, roi){
    this._overdraftLimit = overdraftLimit;
  }

  //since overdraft limit is there in Current account and no transaction limit therefore logic for wirhdrawal is different

  
  @override
  void withdraw(double amount) {
    
    if(amount>_overdraftLimit){//first checking if the amount requested is greater than the limit if so then return the method and don't allow the transaction
      print('You cannot withdraw more than overdraft Limit');
      return;
    }
    else if(amount > balance && amount < _overdraftLimit)
    {
      //if amount is within the range of balance and overdraft limit then making the balance 0 
      //and anything that bank pays more than balance will become overdraftLoan
      _overdraftLoan = amount - _balance;
      _balance = 0;
      print('Amount of $amount has been successfully detected');
      print('Current balance is $_balance');
      print('Overdraft loan is $overdraftLoan');
    }
    else{
      //otherwise the amount requested is below the balance therefore normal withdrawal logic
      super.withdraw(amount);
    }

  }

  @override
  void showROI(){
    print('You need to pay for balance $_balance');
    //ROI is same for all the Accounts except that in CurrentAccount a person needs to pay to bank rather than receive it from bank
    //therefore  we need to show a message that 'You need to pay to bank'
    //and then the same showROI() logic
    super.showROI();
  }

  get overdraftLoan{
    return _overdraftLoan;
  }

}

class FDAccount extends Account{
  DateTime _date_of_lockingPeriod;

  FDAccount(int id,String name, double balance, double roi, int  lockingPeriod) : super.allInput(id,name,balance, roi){
    /*
    Here the locking period is of 2 years thus a person cannot withdraw before 2 years
    So we need to set the date of locking period
    Current will be the date when the object is being formed
    then current.add() will add the number of days upto which we want to increase the date to be i.e. 2*365 days
    */
    DateTime current = DateTime.now();
    int days = lockingPeriod * 365;

    _date_of_lockingPeriod = current.add(Duration(days: days));

  }
  @override
  void withdraw(double amount) {
    DateTime date_of_withdraw = DateTime.now();//this will be date of withdraw which will be compared with the _date_of_lockingPeriod
    //which has been set in the constructor

    if(date_of_withdraw.compareTo(_date_of_lockingPeriod) > -1){
      //this means the withdrawal date is more than the locking period date because it will give either 0 or 1

      // -1 means date_of_withdraw is smaller than _date_of_lockingPeriod
      //  0 means date_of_withdraw is equal to _date_of_lockingPeriod
      //  1 means date_of_withdraw is greater than _date_of_lockingPeriod

      print('You cannot withdraw before the locking period');
      print('Withdrawal date is $date_of_withdraw');
      print('Locking period date is $_date_of_lockingPeriod');
      return;
    }
    //if date_of_withdraw is smaller than _date_of_lockingPeriod then we can proceed with the normal withdrawal logic
    super.withdraw(amount);
  }

}

void main(){
  print('\n');
  SavingAccount sa = SavingAccount(101, 'Abhishek', 500000, 4, 10000);
                   //SavingAccount(id, name, balance, roi, limit)
  
  sa.display();
  sa.withdraw(9000);
  //print('Balance after withdrawal is ${sa._balance}');
  sa.showROI();

  print('\n******************************************************\n');

  CurrentAccount ca = CurrentAccount(2001, 'Mayank', 280000, 5, 350000);
                    //CurrentAccount(id, name, balance, roi, overdraftLimit)
  ca.display();
  ca.showROI();

  ca.withdraw(290500);
  //print('Balance after withdrawal is ${ca._balance}');
  //print('Overdraft Loan is ${ca.overdraftLoan}');
  
  

  print('\n******************************************************\n');

  FDAccount fda = FDAccount(9811, 'Lakshay', 75000, 7, 2);
                    //FDAccount(id, name, balance, roi, locking period(int yrs))
  fda.display();
  fda.withdraw(6000);
  //print('Balance after withdrawal is ${fda._balance}');
  fda.showROI();
  print('\n');

}