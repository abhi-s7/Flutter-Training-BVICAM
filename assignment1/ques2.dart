/* Problem Statement
Q2. (Asked by Amazon) O(N)
A professor went to a party. Being an erudite person, he classified the party into two categories.
He proposed that if all the persons in the party are wearing different colored robes, then that is a girl’s only party.
If we even get one duplicate color, it must be a boy’s party. The colors of the robes are represented by positive integers.

InputThe first line of each test case contains an integer T, denoting the no of test cases. Then T test cases follow.
The first line of each test case contains an integer N denoting the number of people in the party.
In the next line are N space separated values of Ai denoting the color of the robes.

OutputFor each test case, print “BOYS” without quotes if it’s a boy’s party, else print “GIRLS”
*/

void main(){
  //In short and simple language every element of the array must be unique for GIRLS but if any element is repeated then it is BOYS party
  var array = [1 ,2 ,3 ,4 ,7]; //this is GIRLS Party
  //var array = [1 ,3 ,2 ,4 ,5 ,1]; //this is BOYS Party
  var set = new Set();//set will contain unique elements so while adding into set or list or map just check if current element is present already or not
  bool isBoys = false;
  array.forEach(

    (ele) {
    if(set.contains(ele)){
      isBoys = true;// if same value exists then isBoys flag will set true and bingo BOYS rocks otherwise there are GIRLS on the floor
      return;

    }else{
      set.add(ele);
    }
  });

  print(isBoys?'BOYS Party':'GIRLS Party');
  
}