import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'requires_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Virtusa';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  RequiresModel model = RequiresModel();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    apiCallRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello ReqRes users!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),),
              SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: model.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        model.data![index].firstName ?? "N/A",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      SizedBox(height: 20,),
                      Text(model.data![index].email ?? "N/A", style: TextStyle(color: Colors.black, fontSize: 18),),
                      SizedBox(height: 20,),
                      Image.network(model.data![index].avatar ?? "N/A"),
                    ],
                  ),
                );
              },
            ),)],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  apiCallRequest() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get("https://reqres.in/api/users?page=1");
      if (response.statusCode == 200) {
        setState(() {
          model = RequiresModel.fromJson(response.data);
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
