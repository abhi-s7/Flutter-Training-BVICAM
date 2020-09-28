/*
You are given a list of n-1 integers and these integers are in the range of 1 to n. There are no duplicates in the list. One of the integers is missing in the list. Write an efficient code to find the missing integer.
Input: arr[] = {1, 2, 4, 6, 3, 7, 8}Output: 5
Input: arr[] = {1, 2, 3, 5}Output: 4
*/

void main(){
  /*Approach 1
  1. Since the elements are N natural number so sum of N natural number is => n(n+1)/2
  2. Find the max number and use the above formula
  3. Sum up all the elements of the array and subtract it from above sum
  */
  var array = [1, 8, 4, 6, 3, 7, 2];
  int arraySum = 0;
  int max = 0;

  array.forEach((ele){
    if(ele > max)
      max = ele;
    arraySum += ele;
  });

  double totalSum = max*(max+1)/2;
  print('Missing number is ${ (totalSum - arraySum).round()}');

}



void approach2(){
  /*
  Approach 2: Using XOR Operation
  Algo: 
  1. Firstly XOR every element of array with one another and save it in a variable X
  2. Find the max. element in array
  3. Loop till max element and XOR them and save result in a varible Y
  4. Finally XOR previous varible X and Y i.e. X^Y
  */
  var array = [1, 8, 4, 6, 3, 7, 2];
  int XOR  = 0;
  int max = 0;
  for(int num in array){
      if(num > max)
        max = num;

        XOR = XOR ^ num;
  }
  int XORMax = 0;
  for(int i = 1; i<=max; i++){
    XORMax = XORMax ^ i;
  }
  print('Missing Number is : ${XOR ^ XORMax}');
}