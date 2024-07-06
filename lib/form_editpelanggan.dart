import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class form_editpelanggan extends StatefulWidget {
  final Map pelangganListData;

  const form_editpelanggan(obatdata,
      {super.key,
      required this.pelangganListData,
      required Map<String, dynamic> listPelangganData});

  @override
  State<form_editpelanggan> createState() => _form_editpelangganState();
}

class _form_editpelangganState extends State<form_editpelanggan> {
  TextEditingController xkode_peledit = TextEditingController();
  TextEditingController xnama_peledit = TextEditingController();
  TextEditingController xalamatedit = TextEditingController();
  TextEditingController xkotaedit = TextEditingController();

  Future<void> update_datapelanggan() async {
    String url = "http://192.168.1.20/update_pel.php";
    try {
      final respon = await http.post(Uri.parse(url), body: {
        'xkode_pel': xkode_peledit.text,
        'xnama_pel': xnama_peledit.text,
        'xalamat': xalamatedit.text,
        'xkota': xkotaedit.text,
      });
      if (respon.statusCode == 200) {
        print('sukses data di update');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    xkode_peledit.text = widget.pelangganListData['xkode_pel'];
    xnama_peledit.text = widget.pelangganListData['xnama_pel'];
    xalamatedit.text = widget.pelangganListData['xalamat'];
    xkotaedit.text = widget.pelangganListData['xkota'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 184, 184, 184),
          title: Text('UPDATE DATA PELANGGAN'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xkode_peledit,
                decoration: InputDecoration(
                    label: Text(
                      'masukkan kode pelanggan',
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xnama_peledit,
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
                controller: xalamatedit,
                decoration: InputDecoration(
                    label: Text('masukkan satuan pelanggan'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(255, 184, 184, 184),
              child: TextField(
                controller: xkotaedit,
                decoration: InputDecoration(
                    label: Text('masukkan jumlah pelanggan'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  update_datapelanggan();
                },
                child: Text(
                  'UPDATE',
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
