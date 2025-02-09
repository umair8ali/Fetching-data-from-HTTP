import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UrlFetch extends StatefulWidget {
  const UrlFetch({super.key});

  @override
  State<UrlFetch> createState() => _UrlFetchState();
}

class _UrlFetchState extends State<UrlFetch> {
  String data = 'Loading';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://api.github.com/users/umair8ali/repos');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          data = response.body;
        });
      } else {
        setState(() {
          data = 'Error Fetching Data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        data = "Error : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'URL FETCH',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Text(data),
        ),
      ),
    );
  }
}
