import 'package:flutter/material.dart';
import 'package:manage/tambah_pengeluaran_page.dart';
import 'tambah_pemasukan_page.dart';
import 'detail_page.dart';
import 'pengaturan_page.dart';
import 'package:manage/db_helper.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<int> totalPemasukan;
  late Future<int> totalPengeluaran;

  @override
  void initState() {
    super.initState();
    totalPemasukan = DatabaseHelper().getTotalPemasukan();
    totalPengeluaran = DatabaseHelper().getTotalPengeluaran();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: 
          Stack(
            children: <Widget>[
              Container(
                height: size.height * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/header.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Container(
                    height: 30,
                    child: Center(
                      child: Text('Rangkuman Bulan Ini', style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<int>(
                    future: totalPemasukan,
                    builder: (context, pemasukanSnapshot) {
                      if (pemasukanSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (pemasukanSnapshot.hasError) {
                        return Text('Error: ${pemasukanSnapshot.error}');
                      } else {
                        final totalPemasukanValue = pemasukanSnapshot.data ?? 0;
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 50,
                          width: 370,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pemasukan Rp. $totalPemasukanValue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  FutureBuilder<int>(
                    future: totalPengeluaran,
                    builder: (context, pengeluaranSnapshot) {
                      if (pengeluaranSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (pengeluaranSnapshot.hasError) {
                        return Text('Error: ${pengeluaranSnapshot.error}');
                      } else {
                        final totalPengeluaranValue = pengeluaranSnapshot.data ?? 0;
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 50,
                          width: 370,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pengeluaran : Rp.  $totalPengeluaranValue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Tambahpemasukanpage(), 
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.arrow_back_ios, color: Colors.green),
                                  Text(' '),
                                  Text('Pemasukan'),
                                ],
                              ),
                            ),
                          )
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Tambahpengeluaranpage(), 
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.arrow_forward_ios, color: Colors.red),
                                  Text(' '),
                                  Text('Pengeluaran'),
                                ],
                              ),
                            ),
                          )
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(), 
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.format_list_bulleted , color: Colors.green),
                                  Text(' '),
                                  Text('Detail'),
                                ],
                              ),
                            ),
                          )
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PengaturanPage(), 
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.settings, color: Colors.grey),
                                  Text(' '),
                                  Text('Pengaturan'),
                                ],
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
