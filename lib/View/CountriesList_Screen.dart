import 'package:coivd_19/Services/state_services.dart';
import 'package:coivd_19/View/detail_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1aa268),
        title: const Text("countries List"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: StateServices().countiresListAPi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                                width: 80,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
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
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => detailScreen(
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          totalCase: snapshot.data![index]
                                              ['cases'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecoverd: snapshot.data![index]
                                              ['todayRecovered'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                        )));
                              },
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: (() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => detailScreen(
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          totalCase: snapshot.data![index]
                                              ['cases'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecoverd: snapshot.data![index]
                                              ['todayRecovered'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                        )));
                              }),
                              child: ListTile(
                                leading: Image(
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      )),
    );
  }
}
