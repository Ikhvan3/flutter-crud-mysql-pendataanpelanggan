import 'dart:convert';

import 'package:cruddatapelanggan/form_editpelanggan.dart';
import 'package:cruddatapelanggan/form_inputpelanggan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(
    home: tampildata_pelanggan(),
  ));
}

class tampildata_pelanggan extends StatefulWidget {
  const tampildata_pelanggan({super.key});

  @override
  State<tampildata_pelanggan> createState() => _tampildata_pelangganState();
}

class _tampildata_pelangganState extends State<tampildata_pelanggan> {
  List pelanggandata = [];
  Future<void> baca_datapel() async {
    String uri = "http://192.168.1.20/koneksipel.php";
    try {
      final respon = await http.get(Uri.parse(uri));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        print(data);
        setState(() {
          pelanggandata = data;
        });
        pelanggandata = data;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> hapus_datapelanggan(String xkode_pel) async {
    String url = "http://192.168.1.20/hapus_pel.php";
    try {
      final respon = await http.post(
        Uri.parse(url),
        body: {"xkode_pel": xkode_pel},
      );

      if (respon.statusCode == 200) {
        print('berhasil.........!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    baca_datapel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Listview data Pelanggan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 66, 66, 66),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 184, 184, 184),
      ),
      body: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 400,
                width: double.infinity,
                color: Color.fromARGB(255, 184, 184, 184),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => form_editpelanggan(
                                  pelanggandata,
                                  pelangganListData: {
                                    "xkode_pel": pelanggandata[index]
                                        ['kode_pel'],
                                    "xnama_pel": pelanggandata[index]
                                        ['nama_pel'],
                                    "xalamat": pelanggandata[index]['alamat'],
                                    "xkota": pelanggandata[index]['kota'],
                                  },
                                  listPelangganData: {},
                                ),
                              ));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${pelanggandata[index]['kode_pel']}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "--",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${pelanggandata[index]['nama_pel']}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\Alamat : ${pelanggandata[index]['alamat']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                            ),
                            Text(
                              "\Kota : ${pelanggandata[index]['kota']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 66, 66),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            hapus_datapelanggan(
                                pelanggandata[index]['kode_pel']);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: pelanggandata.length),
                // child: ListView.builder(
                //   itemCount: mhsdata.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       tileColor: Color.fromARGB(255, 88, 88, 88),
                //       title: Text(
                //         mhsdata[index]['nim'] +
                //             " -- " +
                //             mhsdata[index]['nama_mhs'],
                //         style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Color.fromARGB(255, 0, 0, 0)),
                //       ),
                //       subtitle: Text(
                //         mhsdata[index]['jurusan'],
                //         style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Color.fromARGB(255, 0, 0, 0)),
                //       ),
                //       trailing: IconButton(
                //         onPressed: () {
                //           hapus_datamhs(mhsdata[index]['nim']);
                //         },
                //         icon: Icon(
                //           Icons.delete,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => entry_pelanggan(),
                    ),
                  );
                },
                child: Text(
                  "INPUT",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 66, 66, 66),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
