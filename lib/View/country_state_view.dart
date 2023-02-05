import 'package:covid19_app/View/countries_list_screen.dart';
import 'package:covid19_app/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../modals/World_states_model.dart';

class CountryStateView extends StatefulWidget {
  const CountryStateView({Key? key}) : super(key: key);

  @override
  State<CountryStateView> createState() => _CountryStateViewState();
}

class _CountryStateViewState extends State<CountryStateView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void initState(){
    super.initState();

  }

  final color = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                FutureBuilder(builder: (BuildContext context, AsyncSnapshot<WorldStatesModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(child: SpinKitFadingCircle(
                      controller: _controller,
                      color: Colors.white,
                      size: 50,
                    ));
                  }
                  else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap:  {
                            'Total' : snapshot.data!.cases!.toDouble(),
                            'Recovered' : snapshot.data!.recovered!.toDouble(),
                            'Deaths' : snapshot.data!.deaths!.toDouble(),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          colorList: color,
                          chartType: ChartType.ring,

                          animationDuration: const Duration(milliseconds: 1200),
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                          child: Card(
                            child: Column(
                              children:  [
                                reusableRow(title: 'Total', value: snapshot.data!.cases!.toInt()),
                                reusableRow(title: 'Deaths', value: snapshot.data!.deaths!.toInt()),
                                reusableRow(title: 'Recovered', value: snapshot.data!.recovered!.toInt()),
                                reusableRow(title: 'Active', value: snapshot.data!.active!.toInt()),
                                reusableRow(title: 'Critical', value: snapshot.data!.critical!.toInt()),
                                reusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths!.toInt()),
                                reusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered!.toInt()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const CountriesListScreen();
                            }));
                            },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(17),
                            color: const Color(0xff1aa260),
                            child: const Text('Track Countries', textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    );
                  }
                }, future: stateServices.getStatesData()),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget reusableRow({required String title, required int value}){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(),),
        Text(value.toString(), style: TextStyle(),),
      ],
    ),
  );
}
