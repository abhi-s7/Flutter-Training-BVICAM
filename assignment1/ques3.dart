/*Q3. Find the Leader Element in an Array
Write a program to print all the LEADERS in the array. An element is leader if it is greater than all the elements to its right side. And the rightmost element is always a leader. For example int the array {300,40,60,90,100,12,16, 17, 4, 3, 5, 2}, leaders are 300,100,17, 5 and 2.
*/

void main(){
  //Approach 2: To maintain a max element and compare it every time with the each elements of array
  var arr = [300,40,60,90,100,12,16, 17, 4, 3, 5, 2];
  int max = 0; //max will represent the leader element and it will obviously be the maximum number to it's right
  for(int i = arr.length - 1; i>=0; i--){

    if(arr[i] > max){
      max = arr[i];
      print(max); //we are printing here only if it would be maximum element i.e. the leader element
    }
  }

}

void approach1(){
  //naive approach
  //binary search
  var list = new List();
  var arr = [300,40,60,90,100,12,16, 17, 4, 3, 5, 2];
  list.add(arr[arr.length-1]);

  for(int i = arr.length-2; i>=0; i--){
    int leader = arr[i]; //this is to set every element as leader then we will check in further loop is it true
      for(int j = i; j<arr.length-1; j++){
        if(arr[i]<arr[j]){
          leader = -1; //now when we got to know that this element is actually smaller than the elements to its right thus it is not leader
          break;
        }
      }

      if(leader != -1) //if it would be leader then it will have some value other than -1. Because -1 has been set when arr[i]<arr[j]
        list.add(leader); // we are adding this leader element to the list
  }

  print(list);
}