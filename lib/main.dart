import 'package:flutter/material.dart';
import 'package:manage/detail_page.dart';
import 'package:manage/tambah_pemasukan_page.dart';
import 'package:manage/tambah_pengeluaran_page.dart';
import 'package:manage/home_page.dart';
import 'pengaturan_page.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
