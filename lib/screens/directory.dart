import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart';
class DirectoryScreen extends StatefulWidget { const DirectoryScreen({super.key}); @override State<DirectoryScreen> createState()=>_D(); }
class _D extends State<DirectoryScreen> { String q='';
  @override Widget build(BuildContext context){ final s=context.watch<AppStore>();
    final list=s.employees.where((e)=>e.name.contains(q)||e.department.contains(q)).toList();
    return Scaffold(appBar:AppBar(title:const Text('دليل الموظفين')),body:Column(children:[
      Padding(padding:const EdgeInsets.all(12),child:TextField(decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'بحث بالاسم أو القسم',border:OutlineInputBorder()),onChanged:(v)=>setState(()=>q=v))),
      Expanded(child:ListView(children:list.map((e)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.person)),title:Text(e.name),subtitle:Text('${e.position} • ${e.department}\n${e.phone}'),isThreeLine:true,trailing:IconButton(icon:const Icon(Icons.call),onPressed:(){})))).toList())),
    ]));
  }
}
