import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotePage extends StatefulWidget {
  final Function logoutUser;
  final String userName;

  QuotePage({required this.logoutUser, required this.userName});

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  late Future<List<String>> _quoteFuture;
  List<String> _quotes = [];
  int _quoteIndex = 0;
  List<String> _backgroundImages = [
    "assets/image/bg.jpeg",
    "assets/image/bg1.jpeg",
    "assets/image/bg2.jpeg",
  ];
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _quoteFuture = _getQuotes();
  }

  Future<List<String>> _getQuotes() async {
    final response = await http.get(Uri.parse('https://type.fit/api/quotes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final startIndex = _quoteIndex % data.length;
      final endIndex = startIndex + 10;
      final quotes = data
          .sublist(startIndex, endIndex)
          .map((item) => item['text'].toString())
          .toList();
      _quoteIndex += 10;
      return quotes;
    } else {
      throw Exception('Failed to fetch quotes');
    }
  }

  void _fetchNextQuotes() {
    setState(() {
      _quoteFuture = _getQuotes();
    });
  }

  String _getRandomBackgroundImage() {
    final index = _random.nextInt(_backgroundImages.length);
    return _backgroundImages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              widget.logoutUser();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _quoteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to fetch quotes",
                textAlign: TextAlign.center,
              ),
            );
          } else if (snapshot.hasData) {
            _quotes = snapshot.data!;
            return Stack(
              children: [
                Image.asset(
                  _getRandomBackgroundImage(),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: _quotes.length,
                      itemBuilder: (context, index) {
                        final quote = _quotes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${index + 1}. $quote',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: _fetchNextQuotes,
                    child: Icon(Icons.refresh),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "No data available",
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
