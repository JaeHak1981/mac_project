import 'dart:io';

void main() {
  var inputName ='';
  stdout.write('이름을 입력하세요 : ');
  inputName = stdin.readLineSync()!;
  String myName;
  myName = inputName;
  print(myName);


}
