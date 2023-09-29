import 'package:flutter/material.dart';
import 'package:manage/home_page.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({ Key? key }) : super(key: key);

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E3192),
        title: Text(
          'Pengaturan',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                      title: Text('Tigor Imam'),
                      subtitle: Text('tigor@gmail.com'),
                      trailing: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/KTM-2.png'),
                      ),
                    ),
                ]
              ),
            ),
            const SizedBox(height: 430),
            Container(
              child: Column(
                children: [
                  Text('Aplikasi ini dibuat oleh :'),
                  Text('Tigor Imam Hamdani'),
                  Text('NIM : 2141764058'),
                  Text('Kelas : SIB 4A'),
                  Text('D IV Sistem Informasi Bisnis'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildKembaliButton(),
          ],
        ),
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


