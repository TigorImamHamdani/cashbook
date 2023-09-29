import 'package:flutter/material.dart';
import 'package:manage/home_page.dart';
import 'package:manage/register_page.dart';
import 'package:manage/db_helper.dart'; 

class Tambahpemasukanpage extends StatefulWidget {
  const Tambahpemasukanpage({Key? key}) : super(key: key);

  @override
  _TambahpemasukanState createState() => _TambahpemasukanState();
}

class _TambahpemasukanState extends State<Tambahpemasukanpage> {
  late Size mediaSize;
  DateTime selectedDate = DateTime.now();
  TextEditingController datePemasukanController = TextEditingController();
  TextEditingController nominalPemasukanController = TextEditingController();
  TextEditingController keteranganPemasukanController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2E3192),
      ),
      child: Scaffold(
        backgroundColor: Color(0xFF2E3192), 
        body: Stack(children: [
          Positioned(top: 70 ,child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildBottom() {
  return SizedBox(
    width: mediaSize.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }


  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tambah Data Pemasukan",
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 40),
        _buildGreyText("Tanggal"),
        _buildDateField(datePemasukanController),
        const SizedBox(height: 20),
        _buildGreyText("Nominal"),
        _buildInputField(nominalPemasukanController),
        const SizedBox(height: 20),
        _buildGreyText("Keterangan"),
        _buildInputField(keteranganPemasukanController),
        const SizedBox(height: 20),
        _buildSimpanButton(),
        const SizedBox(height: 20),
        _buildResetButton(),
        const SizedBox(height: 20),
        _buildKembaliButton(),
      ],
    );
  }

 Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final formattedDate = "${picked.day}-${picked.month}-${picked.year}";
        datePemasukanController.text = formattedDate;
      });
    }
  }


  Widget _buildDateField(TextEditingController controller) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        _selectDate(context); 
      },
      controller: controller,
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
    );
  }

  Widget _buildSimpanButton() {
    return ElevatedButton(
      onPressed: () {
        _simpanData();
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
      child: const Text("Simpan"),
    );
  }

  Widget _buildResetButton() {
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
      child: const Text("Reset"),
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

  Future<void> _simpanData() async {
    final tanggal = datePemasukanController.text;
    final nominal = nominalPemasukanController.text;
    final keterangan = keteranganPemasukanController.text;
    if (tanggal.isNotEmpty && nominal.isNotEmpty && keterangan.isNotEmpty) {
      final entry = ManageBookPemasukanEntry(
        ketpemasukan: keterangan, 
        nominalpemasukan: int.parse(nominal), 
        tanggalpemasukan: tanggal,
      );

      final dbHelper = DatabaseHelper();
      await dbHelper.createPemasukanEntry(entry);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Pastikan semua data diisi!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
