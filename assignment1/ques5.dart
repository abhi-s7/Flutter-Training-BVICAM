/*Q5. Find the Anagram String
“silent”
“listen”
*/

/*
A String to be an anagram Strings they must have same characters
eg. eat and tea both have same characters just position are different
*/
void main(){
  String s1 = 'silent';
  String s2 = 'listens';
  var hash = new List(26);//As there are 26 alphaphets in English 

  for(int i = 0; i<s1.length; i++){
    int index = s1.toUpperCase().codeUnitAt(i) - 65; //s1.codeUintAt() will give the Ascii code and by subtracting it wil 65(A's ASCII) we will get the index for the Hash

    if(hash[index] == null)//we have to check for null as by default the elements in List are null if it is empty
      hash[index] = 1;
    else
      hash[index]++;
  }///here we are increasing the index value from null or 0 to +1

  for(int i = 0; i<s2.length; i++){
    int index = s2.toUpperCase().codeUnitAt(i) - 65;

    if(hash[index] == null)
      hash[index] = -1;
    else
      hash[index]--;
  }//here we are decreasing the index value  

  for(int i = 0; i<hash.length; i++){
    if(hash[i]!=null && hash[i] != 0){
      print('Not Anagram Strings');
      return;
    }
  }//and if it cancel out then all the index value will be 0 i.e. Anagram strings otherwise Not Anagram Strings
  print('Anagram Strings ');

}