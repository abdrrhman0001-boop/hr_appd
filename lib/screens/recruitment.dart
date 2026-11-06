import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';
class RecruitmentScreen extends StatelessWidget { const RecruitmentScreen({super.key});
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    return Scaffold(appBar:AppBar(title:const Text('التوظيف الداخلي')),body:ListView(children:s.jobs.map((j)=>Card(child:ListTile(leading:const Icon(Icons.work),title:Text(j.title),subtitle:Text('${j.dept} • ${j.location} • ${j.type}'),trailing:j.applied?const Chip(label:Text('قدمت')):OutlinedButton(child:const Text('قدّم'),onPressed:(){j.applied=true;s.log('تقديم على ${j.title}');})))).toList()));
  }
}
