import 'dart:async';
import 'dart:convert';
import 'cocktail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Cocktail> _getData() async {
  final response = await http
      .get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'));

  var jsonData = jsonDecode(response.body);
  var cocktailData = jsonData['drinks'][0];

  if (response.statusCode == 200) {
    return Cocktail.fromJson(cocktailData);
  } else {
    throw Exception('Fallo');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Cocktail> futureCocktail;

  @override
  void initState() {
    super.initState();
    futureCocktail = _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail Api',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cocktail Api'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<Cocktail>(
                future: futureCocktail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshot.data!.strDrink,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Image.network(snapshot.data!.strDrinkThumb),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      futureCocktail = _getData();
                    });
                  },
                  child: const Text('Actualizar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
