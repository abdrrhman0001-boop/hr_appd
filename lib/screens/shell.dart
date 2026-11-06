// صدفة التطبيق: تنقل سفلي مريح بيد واحدة + درج جانبي + صلاحيات حسب الدور
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/store.dart'; import '../models/models.dart';
import 'home.dart'; import 'leaves.dart'; import 'attendance.dart'; import 'profile.dart'; import 'admin.dart'; import 'more.dart';

class Shell extends StatefulWidget { const Shell({super.key}); @override State<Shell> createState()=>_S(); }
class _S extends State<Shell> {
  int i = 0;
  @override Widget build(BuildContext context){
    final s = context.watch<AppStore>();
    final isAdmin = s.role == UserRole.superAdmin || s.role == UserRole.hr;
    final pages = [const HomeScreen(), const LeavesScreen(), const AttendanceScreen(), const ProfileScreen(), if(isAdmin) const AdminScreen(), const MoreScreen()];
    final items = [const BottomNavigationBarItem(icon: Icon(Icons.home), label:'الرئيسية'), const BottomNavigationBarItem(icon: Icon(Icons.beach_access), label:'الإجازات'), const BottomNavigationBarItem(icon: Icon(Icons.qr_code), label:'الحضور'), const BottomNavigationBarItem(icon: Icon(Icons.person), label:'ملفي'), if(isAdmin) const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label:'المشرف'), const BottomNavigationBarItem(icon: Icon(Icons.grid_view), label:'المزيد')];
    return Scaffold(
      body: pages[i.clamp(0, pages.length-1)],
      bottomNavigationBar: NavigationBar(selectedIndex: i.clamp(0,items.length-1), onDestinationSelected:(v)=>setState(()=>i=v), destinations: items.map((e)=>NavigationDestination(icon:e.icon,label:e.label??'')).toList()),
      drawer: Drawer(child: ListView(children:[
        UserAccountsDrawerHeader(accountName: Text(s.userName), accountEmail: Text('${s.jobNumber} • ${s.role.arName}')),
        ListTile(leading: const Icon(Icons.dark_mode), title: const Text('الوضع الداكن'), trailing: Switch(value: s.dark, onChanged: s.setDark)),
        ListTile(leading: const Icon(Icons.language), title: const Text('اللغة / Langue'), subtitle: Text(s.lang), onTap: ()=>showDialog(context: context, builder: (_)=>SimpleDialog(title: const Text('اللغة'), children:['ar','fr','en'].map((l)=>SimpleDialogOption(child:Text(l),onPressed:(){s.setLang(l);Navigator.pop(context);})).toList()))),
        ListTile(leading: const Icon(Icons.logout), title: const Text('خروج'), onTap: ()=>Navigator.pop(context)),
      ])),
    );
  }
}
