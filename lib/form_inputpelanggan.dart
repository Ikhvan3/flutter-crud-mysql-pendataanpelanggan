import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: entry_pelanggan(),
  ));
}

class entry_pelanggan extends StatefulWidget {
  @override
  State<entry_pelanggan> createState() => _entry_pelangganState();
}

class _entry_pelangganState extends State<entry_pelanggan> {
  TextEditingController xkode_pel = TextEditingController();
  TextEditingController xnama_pel = TextEditingController();
  TextEditingController xalamat = TextEditingController();
  TextEditingController xkota = TextEditingController();

  Future<void> simpan_datapel() async {
    String url = "http://192.168.1.20/simpan_pel.php";
    try {
      final respon = await http.post(Uri.parse(url), body: {
        'xkode_pel': xkode_pel.text,
        'xnama_pel': xnama_pel.text,
        'xalamat': xalamat.text,
        'xkota': xkota.text,
      });
      if (respon.statusCode == 200) {
        print('Simpan Berhasil!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 184, 184, 184),
          title: Text('INPUT DATA PELANGGAN'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xkode_pel,
                decoration: InputDecoration(
                    label: Text('masukkan kode pelanggan'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xnama_pel,
                decoration: InputDecoration(
                    label: Text('masukkan nama pelanggan'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xalamat,
                decoration: InputDecoration(
                    label: Text('masukkan alamat'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xkota,
                decoration: InputDecoration(
                    label: Text('masukkan kota'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  simpan_datapel();
                },
                child: Text(
                  'SIMPAN',
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 66, 66),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
