import 'dart:io';

class Employee{
  int _id;
  String name;
  double _salary;

  Employee(id, name, salary){
    this._id = id;
    this.name = name;
    this._salary = salary;
  }

  Map<String , double> otherSalary(){
    double HRA = _salary*0.3;
    double DA = _salary*0.1;
    double TA = _salary*0.2;
    double PF = _salary*0.1;
    double bonus = _salary * 0.05;
    double tax = _calcTax();
    //return [HRA, DA, TA, bonus];
    double grossSalary = _salary + HRA + DA + TA + bonus - PF;
    double netSalary = grossSalary - tax;
    return {"HRA" : HRA, "DA" : DA, "TA": TA, "PF":PF, "Bonus":bonus, "tax": tax,
            "Gross Salary": grossSalary, "Net Salary": netSalary };
  }

  double _calcTax(){
    double tax;
    if(_salary>100000){
      tax = _salary*0.3;
    }else if(_salary > 700000 && _salary<100000){
      tax = _salary*0.2;
    }else if(_salary> 500000 && _salary<700000){
      tax = _salary*0.1;
    }else{
      tax = 0;
    }
    return tax;
  }

}

void main(){
  print("Enter the user id");
  int id = int.parse(stdin.readLineSync());

  print('Enter the Employee name');
  String name = stdin.readLineSync();
  name = getTitleCase(name);//this will format the name

  print('Enter the salary of Employee $name');
  double salary = int.parse(stdin.readLineSync()).toDouble();

  //Two ways to set the details of Employee
  //1. Either pass these values in constructor
  //2. Or use obj.name = 11; to assign the values

  Employee emp = Employee(id, name, salary);
  print('Employee id: ${emp._id}, Name: ${emp.name} and Base Salary: \$ ${emp._salary}');

  Map<String, double> map = emp.otherSalary();
  //  map.forEach((k,v) => print('$k : ${formatSalary(v)}')); //formatSalary is not accessible in fat arrow

  map.forEach((k,v){
    print('$k : ${formatSalary(v)}');
  });
}

String getTitleCase(String name){

  var list = name.trim().split(" ");
  String fullName = "";
  list.forEach((ele){
    //String s = ele.toLowerCase();
    if(ele != ''){
      fullName+= ele.toLowerCase()[0].toUpperCase() + ele.substring(1) + " ";
    }
    
  });
  return fullName;

}

String formatSalary(double sal){
  double num = double.parse((sal).toStringAsFixed(2));//this will give salary upto 2 decimal digits
  return '\$ ' + num.toString();
}