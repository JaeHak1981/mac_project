import 'package:chool_check/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

/*
위도
35.805566
경도
127.120111
*/


/*
* ChoolCheck class
* IconButton => 근처에 있으면 blue, 아니면 red 지정하기
* 출근하기 버튼 => 근처에 있으면 보여주기, 아니면 안 보여주기
*
* onChoolChcekPressed : 출근하기 버튼 실행하기
* showDialog 사용하기, async 사용
* retun AlertDialog 사용하기 : title, content, actions 사용하기
* actions => 취소, 출근 버튼 생성하기
*
* Navigator.of.pop(false or true)
* 상태관리하기
* 취소를 누르면 현 상태 유지
* 출근 누르면 출근 한것 처음 상태 변경하기
* if( result ) setState(){ choolCheckDone = true}
*
* 출근하기가 되면
* 아이콘 버튼은 green 변경
* 지도에서도 원이 green으로 변경
* 출근하기 버튼은 사라지게 한다
*
* */