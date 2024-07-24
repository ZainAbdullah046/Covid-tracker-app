import 'package:covid_tracker_app/models/worldstatesmodel.dart';
import 'package:covid_tracker_app/screens/countryhome.dart';
import 'package:covid_tracker_app/utilities/stateservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Color> colorList = [
    const Color(0xFF52FF33),
    const Color(0xFF3358FF),
    const Color(0xFFFF3342),
  ];

  @override
  Widget build(BuildContext context) {
    Statesservices statesservices = Statesservices();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                  future: statesservices.fetchworldstatesrecord(),
                  builder: (context, AsyncSnapshot<worldstatesmodel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          controller: _controller,
                          size: 50.0,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            animationDuration: const Duration(seconds: 3),
                            chartType: ChartType.ring,
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                              legendTextStyle: TextStyle(color: Colors.white),
                            ),
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.09),
                            child: Card(
                              color: Colors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Use(
                                    title: "Total",
                                    value: snapshot.data?.cases.toString() ??
                                        'N/A',
                                  ),
                                  Use(
                                    title: "Recovered",
                                    value:
                                        snapshot.data?.recovered.toString() ??
                                            'N/A',
                                  ),
                                  Use(
                                    title: "Deaths",
                                    value: snapshot.data?.deaths.toString() ??
                                        'N/A',
                                  ),
                                  Use(
                                    title: "Active",
                                    value: snapshot.data?.active.toString() ??
                                        'N/A',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => countryhome()));
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                  child: Text(
                                "Track countries",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                            ),
                          )
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Use extends StatelessWidget {
  final String title;
  final String value;

  const Use({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(value.toString()),
    );
  }
}
