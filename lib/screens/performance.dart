import 'package:flutter/material.dart';
class PerformanceScreen extends StatelessWidget { const PerformanceScreen({super.key});
  @override Widget build(BuildContext context){
    return Scaffold(appBar:AppBar(title:const Text('تقييم الأداء')),body:ListView(padding:const EdgeInsets.all(12),children:const [
      Card(child:ListTile(title:Text('هدف 1: إغلاق 90% من التذاكر في الأجل'),subtitle:Text('التقدم: 75%'),trailing:Text('2026'))),
      Card(child:ListTile(title:Text('هدف 2: تكوين Flutter لفريقين'),subtitle:Text('التقدم: 40%'),trailing:Text('2026'))),
      Card(child:ListTile(leading:Icon(Icons.star,color:Colors.amber),title:Text('التقييم الدوري الأخير: 4.2/5'),subtitle:Text('ملاحظة المدير: أداء قوي في الانضباط — حسّن التوثيق'))),
    ]));
  }
}
