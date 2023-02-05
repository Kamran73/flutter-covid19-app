import 'package:flutter/material.dart';

class DataAsPerCountry extends StatefulWidget {
  const DataAsPerCountry({Key? key, required this.country}) : super(key: key);

  final country;

  @override
  State<DataAsPerCountry> createState() => _DataAsPerCountryState();
}

class _DataAsPerCountryState extends State<DataAsPerCountry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country['country']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children:  [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Card(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 40,),
                      reusableRow(title: 'Total', value: widget.country['cases']),
                      reusableRow(title: 'Deaths', value: widget.country['deaths']),
                      reusableRow(title: 'Recovered', value: widget.country['recovered']),
                      reusableRow(title: 'Active', value: widget.country['active']),
                      reusableRow(title: 'Critical', value: widget.country['critical']),
                      reusableRow(title: 'Today Deaths', value: widget.country['todayDeaths']),
                      reusableRow(title: 'Today Recovered', value: widget.country['todayRecovered']),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('${widget.country['countryInfo']['flag']}', ),
              ),

            ],
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