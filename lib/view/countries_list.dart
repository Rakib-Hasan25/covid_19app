import 'package:covid19app/Services/Utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  final searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final statesServices = StatesServices();
    return Scaffold(
        appBar: AppBar(
          elevation: 0
          ,
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
        ),
        body: SafeArea(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: TextFormField(
                      controller: searchController,


                      //searching korar somoi ja change hoice ta show korate state ke set korte
                      onChanged: (value){
                        setState(() {

                        });

                      },
                      decoration: InputDecoration(
                          hintText: "Search with country name",
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          )
                      ),

                    ),
                  ),

                  Expanded(
                      child: FutureBuilder(
                          future: statesServices.countriesListApi(),
                          builder: (context,
                              AsyncSnapshot<List<dynamic>>snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    String name = snapshot.data![index]['country'];

                                    if(searchController.text.isEmpty){
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                                snapshot.data![index]['country']),
                                            subtitle: Text(
                                                snapshot.data![index]['cases']
                                                    .toString()),
                                            leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                snapshot
                                                    .data![index]['countryInfo']['flag'],
                                              ),
                                            ),
                                          )

                                        ],
                                      );
                                    }
                                    else if(name.toLowerCase().contains(searchController.text.toString())){
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                                snapshot.data![index]['country']),
                                            subtitle: Text(
                                                snapshot.data![index]['cases']
                                                    .toString()),
                                            leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(
                                                snapshot
                                                    .data![index]['countryInfo']['flag'],
                                              ),
                                            ),
                                          )

                                        ],
                                      );

                                    }
                                    else{
                                      return Container();

                                    }


                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                              snapshot.data![index]['country']),
                                          subtitle: Text(
                                              snapshot.data![index]['cases']
                                                  .toString()),
                                          leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              snapshot
                                                  .data![index]['countryInfo']['flag'],
                                            ),
                                          ),
                                        )

                                      ],
                                    );
                                  });
                            }
                            else {
                              return ListView.builder(
                                  itemCount: 8,// ekane 4 deyar karon ,ei else block e tow kono data nai tai jekono ekta value diye dilam
                                  itemBuilder: (context, index) {

                                        return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade700,
                                            highlightColor: Colors.grey.shade700,
                                            child:  Column(
                                              children: [
                                                ListTile(
                                                  title:Container(height: 10,width:89,color: Colors.white,),
                                                  subtitle: Container(height: 10,width:89,color: Colors.white,),
                                                  leading: Container(height: 50,width:89,color: Colors.white,),
                                                )

                                              ],
                                            ),

                                        );
                                  }
                              );
                            }
                          }
                      )
                  )
                ]


            )

        )
    );
  }
}