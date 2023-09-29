import 'package:flutter/material.dart';
import 'package:manage/home_page.dart';
import 'package:manage/db_helper.dart'; 


class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailpageState createState() => _DetailpageState();
}

class ItemPemasukan {
  final String? nominal;
  final String? tanggal;
  final String? ketpemasukan;

  ItemPemasukan({this.nominal, this.tanggal, this.ketpemasukan});
}

class ItemPengeluaran {
  final String? nominal;
  final String? tanggal;
  final String? ketpengeluaran;

  ItemPengeluaran({this.nominal, this.tanggal, this.ketpengeluaran});
}

class _DetailpageState extends State<DetailPage> {
  List<ManageBookPemasukanEntry> databaseEntriesPemasukan = []; 
  List<ManageBookPengeluaranEntry> databaseEntriesPengeluaran = []; 

  @override
  void initState() {
    super.initState();
    _loadDataFromDatabase();
  }

  void _loadDataFromDatabase() async {
    final entriespemasukan = await DatabaseHelper().getPemasukanEntries();
    final entriespengeluaran = await DatabaseHelper().getPengeluaranEntries();
    setState(() {
      databaseEntriesPemasukan = entriespemasukan;
      databaseEntriesPengeluaran = entriespengeluaran;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E3192),
        title: Text(
          'Detail Cash Flow',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: databaseEntriesPemasukan.length + databaseEntriesPengeluaran.length,
              itemBuilder: (context, index) {
                if (index < databaseEntriesPemasukan.length) {
                  final entry = databaseEntriesPemasukan[index];
                  String titleTextpem = "[+] Rp. ${entry.nominalpemasukan}";
                  String subtitleTextpem = "${entry.ketpemasukan} Tanggal ${entry.tanggalpemasukan}";
                  Icon? trailingIconpem = Icon(Icons.arrow_back_ios, color: Colors.green);

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(titleTextpem),
                      subtitle: Text(subtitleTextpem),
                      trailing: trailingIconpem,
                    ),
                  );
                } else {
                  final entry = databaseEntriesPengeluaran[index - databaseEntriesPemasukan.length];
                  String titleTextpeng = "[-] Rp. ${entry.nominalpengeluaran}";
                  String subtitleTextpeng = "${entry.ketpengeluaran} Tanggal ${entry.tanggalpengeluaran}";
                  Icon? trailingIconpeng = Icon(Icons.arrow_forward_ios, color: Colors.red);

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(titleTextpeng),
                      subtitle: Text(subtitleTextpeng),
                      trailing: trailingIconpeng,
                    ),
                  );
                }
              },
            )
          ),

          _buildKembaliButton(),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildKembaliButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HomePage(); 
        }));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        shadowColor: Color(0xFF2E3192),
        minimumSize: const Size.fromHeight(60),
        primary: Color(0xFF2E3192),
      ),
      child: const Text("Kembali"),
    );
  }
}
