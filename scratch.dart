import 'dart:io';

void main(){
  performTasks();
}

void performTasks() async{
  task1();
  String data = await task2();
  task3(data);
}

void task1(){
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future <String> task2() async {
  Duration threeSecond = Duration(seconds: 3);
  String result;

  await Future.delayed(threeSecond, (){
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;

}

void task3(data2){
  String result = 'task 1 data';
  print('Task 3 complete using $data2');
}