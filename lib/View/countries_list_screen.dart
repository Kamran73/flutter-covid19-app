import 'package:covid19_app/View/data_as_per_country.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../services/countries_list.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  CountriesList countriesList = CountriesList();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                onChanged: (String value){
                  setState(() {

                  });
                },
                controller: _controller,
                cursorHeight: 20.0,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  )
                ),
              ),
              const SizedBox(height: 15,),
              Expanded(
                child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(itemBuilder: (context, index){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        direction: ShimmerDirection.ltr,
                        child: Column(
                          children:   [
                             ListTile(
                              leading: Container(
                                color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              title: Container(color:Colors.white,height: 10, width: 89,),
                              subtitle: Container(color: Colors.white,height: 10, width: 89,),
                            ),
                          ],
                        ),
                      );
                    }, itemCount: 4,);
                  }
                  else{
                    return ListView.builder(itemBuilder: (context, index){

                      String name = '${snapshot.data![index]['country']}';



                      if(_controller.text.isEmpty){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return DataAsPerCountry(country: snapshot.data![index]);
                            }));
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            leading: Image.network('${snapshot.data![index]['countryInfo']['flag']}',height: 50,width: 50,fit: BoxFit.cover,),
                            title: Text('${snapshot.data![index]['country']}'),
                            subtitle: Text('${snapshot.data![index]['cases']}'),
                          ),
                        );
                      }
                      else if(name.toLowerCase().contains(_controller.text.toLowerCase())){
                        return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return DataAsPerCountry(country: snapshot.data![index]);
                              }));
                            },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            leading: Image.network('${snapshot.data![index]['countryInfo']['flag']}',height: 50,width: 50,fit: BoxFit.cover,),
                            title: Text('${snapshot.data![index]['country']}'),
                            subtitle: Text('${snapshot.data![index]['cases']}'),
                          ),
                        );
                      }
                      else{
                        return Container();
                      }

                    }, itemCount: snapshot.data!.length,);
                  }
                },
                  future: countriesList.getCountriesApi(),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
