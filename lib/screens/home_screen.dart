import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            )
          ],
        ),
      ),
    );
  }

  void onHeartPressed() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Align( // 정렬을 지정하는 위젯
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
                onDateTimeChanged: (value) {
                  setState(() {
                    firstDay = value;
                  });
                },
              ),
            ),
          );
        },
        barrierDismissible: true, // 외부 탭할 경우 다이얼로그 닫기
        );
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  const _DDay({
    required this.onHeartPressed,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16.0,),
        Text("U&I", style: textTheme.headline1,),

        const SizedBox(height: 16.0,),
        Text("우리 처음 만난 날", style: textTheme.bodyText1),

        Text('${firstDay.year}.${firstDay.month}.${firstDay.day}', style: textTheme.bodyText2),
        const SizedBox(height: 16.0,),

        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          )
        ),
        const SizedBox(height: 16.0,),
        // Dday 계산하기
        Text('D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}', style: textTheme.headline2)
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
      Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          // Expanded가 우선순위를 갖게 되어 무시됩니다.
          height: MediaQuery.of(context).size.height/2,
        ),
      )
    );
  }
}
