import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SaldoUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const SaldoUser({
    super.key,
    required this.user,
  });

  @override
  State<SaldoUser> createState() => _SaldoUserState();
}

class _SaldoUserState extends State<SaldoUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  late String nama;
  late String alamat;
  late String telepon;
  late String tglLahir;
  String saldo = '0';

  @override
  void initState() {
    super.initState();
    nama = widget.user['nama'];
    alamat = widget.user['alamat'];
    telepon = widget.user['telepon'];
    tglLahir = widget.user['tgl_lahir'];

    getSaldo();
  }

  void getSaldo() async {
    try {
      final response = await dio.get(
        '$apiUrl/saldo/${widget.user['id']}',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response.data);

      setState(() {
        saldo = response.data['data']['saldo'].toString();
      });
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo User'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    telepon,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    alamat,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    tglLahir,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Sisa saldo : $saldo',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
