/////////////////////////////////////////////////////
//////////////////Shavin Perera//////////////////////
/////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class favouritesScreen extends StatefulWidget {
  @override
  State<favouritesScreen> createState() => _favouritesScreenState();
}

class _favouritesScreenState extends State<favouritesScreen> {
  //this is used to add movies to the list
  //if false movie is not added // if true movie is added
  bool favouriteMovieRemove = false;
  //list of favourite movies
  List<String> favouriteMovies = [];

  // Retrieve favourite movies from shared preferences
  Future<void> retrieveFavouriteMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favouriteMovies = prefs.getStringList('favouriteMovies') ?? [];
    });
  }

  // Save favourite movies to shared preferences
  Future<void> saveFavouriteMovies(List<String> movies) async {
    //get a Shared Preferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //favourite movie is the key
    await prefs.setStringList('favouriteMovies', movies);
  }

  @override
  void initState() {
    super.initState();
    //run this once widgets are loaded
    retrieveFavouriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/blackimg.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    //width: 126,
                    height: 47,
                    margin: EdgeInsets.fromLTRB(12, 35, 100, 0),
                    child: Text(
                      'FlickTIP',
                      style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Container(
                height: 4,
                width: 357,
                margin: EdgeInsets.fromLTRB(12, 0, 17, 0),
                decoration: BoxDecoration(
                    // color: Color.fromRGBO(108, 92, 213, 1),
                    ),
              ),
              //here
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 24, 3, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 24,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          'Favourite movies',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 602,
                width: 328,
                margin: EdgeInsets.all(0),
                // color: Colors.amber,
                child: ListView(
                  padding: EdgeInsets.zero, // Set padding to zero
                  children: [
                    Align(
                      child: Container(
                        height: 602,
                        width: 370,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        // color: Colors.purple,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          //favourite movie list get two counts when one movie is added (name and poster path)=2
                          //so to get the actual length to the builder length is divided by 2
                          itemCount: favouriteMovies.length ~/ 2,
                          itemBuilder: (BuildContext context, int index) {
                            //since the poster and name is not in one line
                            //has to calculate to get them
                            //eg:-index=[0,1,2,3,4,5,6]
                            //0*2=0 thats movie name
                            //0*2+1 =1 thats the poser url
                            final movieName = favouriteMovies[index * 2];
                            final posterImage = favouriteMovies[index * 2 + 1];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 60,
                                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        posterImage,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    movieName,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  width: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.delete_outline_outlined,
                                          color: Color.fromARGB(
                                              255, 239, 239, 239),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              //if user click delete icon movie will be deleted from the prefs
                                              if (!favouriteMovieRemove) {
                                                favouriteMovies
                                                    .remove(movieName);
                                                favouriteMovies
                                                    .remove(posterImage);
                                                //call function
                                                saveFavouriteMovies(
                                                    favouriteMovies);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      alignment: Alignment.topCenter,
                      // Align child to top
                    ),
                  ],
                ),
              )

              //////
            ],
          ),
        ),
      ),
    );
  }
}
