import 'package:covid_tracker_app/screens/detailedscreen.dart';
import 'package:covid_tracker_app/utilities/stateservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class countryhome extends StatefulWidget {
  const countryhome({super.key});

  @override
  State<countryhome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<countryhome> {
  Statesservices statesservices = Statesservices();
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _search,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: "Search the country name",
                hintStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: statesservices.fetchcountrystatesrecord(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (_search.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Detailedscreen(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]['country'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]['cases']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else if (name
                                .toLowerCase()
                                .contains(_search.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Detailedscreen(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]['country'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]['cases']
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          });
                    }
                  })),
        ],
      ),
    );
  }
}
