import 'package:flutter/material.dart';
import 'package:quran_surah_app/constants.dart';
import 'package:quran_surah_app/get_samApi.dart';

import 'package:quran_surah_app/networking.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<GetSampApi> getSurah() async {
    NetworkHelper networkHelper = NetworkHelper(surahUrl);
    var surahJsonData = await networkHelper.getData();
    GetSampApi surahModel = GetSampApi.fromJson(surahJsonData);
    print(surahModel);
    return surahModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF112095),
            leading: Padding(
              padding: const EdgeInsets.only(left: 13, top: 13.0),
              child: Image(image: AssetImage('images/gg_menu-left.png')),
            ),
            ),
        backgroundColor: background,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF112095),
                  Color.fromARGB(255, 11, 42, 107),
                ],
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(children: [
              Expanded(
                  //Group 1261152914
                  flex: 2,
                  child: Container(
                      child: const Stack(children: [
                    Positioned(
                      bottom: -3,
                      right: 1,
                      left: 1,
                      child: Image(
                        image: AssetImage('images/Group 1261152914.png'),
                      ),
                    ),
                    Positioned(
                      //top: 2,
                      child: Image(
                        image: AssetImage('images/Quran.png'),
                      ),
                    )
                  ]))),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Container(
                      width: double.infinity,
                      height: 0,
                      //color: Colors.blue,
                      decoration: BoxDecoration(
                        color: Color(0xff28398E),
                        border: Border.all(
                          color: Color(0xff65D6FC),
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 17),
                            child: Text(
                              'Search Here',
                              style: TextStyle(
                                  color: Color(0xff65D6FC), fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: 210,
                          ),
                          Icon(
                            Icons.search,
                            color: Color(0xff65D6FC),
                            size: 40,
                          )
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 4,
                  child: FutureBuilder(
                      future: getSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);

                          final surahModel = snapshot.data;
                          print(surahModel);
                          return ListView.builder(
                              itemCount: surahModel!.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Stack(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff65D6FC),
                                              // Set the background color of the circle
                                            ),
                                            child: const Icon(Icons.circle,
                                                color: Color.fromRGBO(
                                                    17,
                                                    32,
                                                    149,
                                                    1)), // Circle icon with white color
                                          ),
                                          Positioned.fill(
                                            child: Center(
                                              child: Text(
                                                (index + 1).toString(),
                                                style: const TextStyle(
                                                  color: Color(0xff65D6FC),
                                                ), // Text color
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                          surahModel.data![index].englishName!,
                                          style: const TextStyle(
                                            color: Color(0xff65D6FC),
                                            fontSize: 20,
                                          )),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                              surahModel
                                                  .data![index].revelationType!
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Color(0xff65D6FC),
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              surahModel
                                                  .data![index].numberOfAyahs!
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color(0xff65D6FC),
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            'VERSES',
                                            style: const TextStyle(
                                              color: Color(0xff65D6FC),
                                            ),
                                          )
                                        ],
                                      ),
                                      trailing:
                                          Text(surahModel.data![index].name!,
                                              style: const TextStyle(
                                                color: Color(0xff65D6FC),
                                                fontSize: 20,
                                              )),
                                    ),
                                    const Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, right: 20.0),
                                      child: const Divider(
                                        thickness:
                                            1.0, // Adjust thickness as needed
                                        color: Color.fromARGB(255, 110, 131,
                                            154), // Change color as needed
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                        if (snapshot.hasError) {
                          return Text('Error');
                        }
                        return Text(
                          'Loading..',
                          style: TextStyle(
                            color: Color(0xff65D6FC),
                          ),
                        );
                      }))
            ]),
          ),
        ),
      ),
    );
  }
}
