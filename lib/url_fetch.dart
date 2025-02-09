import 'package:fetch_url/repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UrlFetch extends StatefulWidget {
  const UrlFetch({super.key});

  @override
  State<UrlFetch> createState() => _UrlFetchState();
}

class _UrlFetchState extends State<UrlFetch> {
  String? data;
  bool isLoading = false;
  bool disabledButton = false;
  List<Repo>? repos;

  // Fetch data from GitHub API
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      disabledButton = true;
    });

    final url = Uri.parse('https://api.github.com/users/umair8ali/repos');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        data = response.body;
        debugPrint(data);
        final List<dynamic> jsonList = json.decode(data!);
        repos = jsonList.map((repo) => Repo.fromJson(repo)).toList();
        setState(() {
          isLoading = false;
          disabledButton = true;
        });
      } else {
        data = 'Error Fetching Data: ${response.statusCode}';

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      data = "Error : $e";
      debugPrint(data);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GIT HUB REPOS',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : repos != null
                    ? ListView.builder(
                        itemCount: repos!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              repos![index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: Icon(
                              Icons.folder,
                              color: Colors.deepPurple,
                            ),
                          );
                        })
                    : SizedBox(),
            // ? Padding(
            //     padding: EdgeInsets.all(16),
            //     child: SingleChildScrollView(
            //       child: Text(data!),
            //     ),
            //   )
            // : SizedBox(),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: !disabledButton
                ? Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      onPressed: fetchData, // Fetch data when pressed
                      child: Text('Fetch Data'),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
