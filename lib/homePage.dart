/////////////////////////////////////////////////////
//////////////////Shavin Perera//////////////////////
/////////////////////////////////////////////////////

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project1/favouriteCollection.dart';
import 'package:project1/loginPage.dart';
import 'package:project1/popularMovies.dart';
import 'package:project1/topRatedMovies.dart';
import 'package:project1/trendingMovies.dart';
import 'package:project1/upcomingMovies.dart';
import 'package:tmdb_api/tmdb_api.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  //api key
  final String apikey = '9b668f392738c30a76933292793fe3a2';
  //read accesstoken
  final String readAccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjY2OGYzOTI3MzhjMzBhNzY5MzMyOTI3OTNmZTNhMiIsInN1YiI6IjYzZTdkOWNiOTUxMmUxMDBhOTdkMzc3NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lRtyYCZo1j9MoRBZSG_4PPXfcHzTOPIKWjjTEo-d1mw';
  //lists to store movie results
  List popularMovies = [];
  List upcomingMovies = [];
  List topRatedMovie = [];
  List trendingmovies = [];
  List allMovies = [];
  //bool to understand whether results are loaded
  //this stops 404 error
  bool loaded = true;

  @override
  void initState() {
    super.initState();
    //load movies
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readAccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    //get popular movies from TMDB
    Map popularresult = await tmdbWithCustomLogs.v3.movies.getPopular();
    //get upcomming movies from TMDB
    Map upcomingresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    //get top rated movies from TMDB
    Map topRatedMovieresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    //get trending movies from TMDB
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    //print((topRatedMovieresult));

    setState(
      () {
        //update state
        popularMovies = popularresult['results'];
        upcomingMovies = upcomingresult['results'];
        topRatedMovie = topRatedMovieresult['results'];
        trendingmovies = trendingresult['results'];
        //add all movies to one list in order to function CarouselSlider
        allMovies.addAll(popularMovies);
        allMovies.addAll(upcomingMovies);
        allMovies.addAll(topRatedMovie);
        allMovies.addAll(trendingmovies);
        //every thing is loaded
        loaded = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  //background image
                  image: AssetImage("images/blackimg.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 47,
                      margin: EdgeInsets.fromLTRB(12, 35, 100, 0),
                      child: Text(
                        //app name
                        'FlickTIP',
                        style: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                            fontFamily: 'BebasNeue',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                //refresh the screen
                                Icons.refresh_outlined,
                                color: Color.fromRGBO(173, 162, 243, 1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homeScreen()),
                                );
                              },
                            ),
                            //Go to favourites screen
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.favorite_outline,
                                color: Color.fromRGBO(173, 162, 243, 1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => favouritesScreen()),
                                );
                              },
                            ),
                            //Go to log in page
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.logout,
                                color: Color.fromRGBO(173, 162, 243, 1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),

                //CarouselSlider
                //loop through all available movies
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.decelerate,
                    enlargeFactor: 0.2,
                  ),
                  items: allMovies.map(
                    (index) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: InkWell(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  //check whether the image is null
                                  index['backdrop_path'] != null
                                      ? Image.network(
                                          'https://image.tmdb.org/t/p/w500${index['backdrop_path']}',
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          color:
                                              Color.fromRGBO(204, 198, 246, 1),
                                          child: Center(
                                            child: Text(
                                              //if nul/ this will appear
                                              "Image not available",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    //check whether title is null
                                    child: index['title'] != null
                                        ? Text(
                                            index['title'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontFamily: 'BebasNeue'),
                                          )
                                        : Text(
                                            //if null show this
                                            "Title not available",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontFamily: 'BebasNeue'),
                                          ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),

                //popular movies tab
                Container(
                  height: 458,
                  width: 330,
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: ListView(
                    children: [
                      ///////////////////////////////////
                      /////////Popular movies////////////
                      ///////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 3, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Container(
                                height: 24,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              popularScreen()),
                                    );
                                  },
                                  //text button
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: Text('Popular movies',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromRGBO(173, 162, 243, 1),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //here
                      Container(
                        height: 141,
                        width: 327,
                        decoration: BoxDecoration(),
                        //if movie results are still loading show CircularProgressIndicator
                        child: loaded
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                //horizontal scroll
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 101,
                                    height: 141,
                                    decoration: BoxDecoration(
                                      //color: Colors.amber,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          //from popular movies grab movie number poster url
                                          'https://image.tmdb.org/t/p/w500${popularMovies[index]['poster_path']}',
                                        ),
                                        //cover the container
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //leave a 12 pixel gap to right
                                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  );
                                },
                              ),
                      ),
                      ///////////////////////////////////
                      /////////Upcoming movies///////////
                      ///////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 22, 3, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => upcomingScreen(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: Text('Upcoming movies',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Color.fromRGBO(173, 162, 243, 1),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 141,
                        width: 327,
                        decoration: BoxDecoration(
                            //color: Color.fromRGBO(108, 92, 213, 1),
                            ),
                        child: loaded
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 101,
                                    height: 141,
                                    decoration: BoxDecoration(
                                      // color: Colors.amber,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${upcomingMovies[index]['poster_path']}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  );
                                },
                              ),
                        //click for more
                      ),
                      ///////////////////////////////////
                      /////////Trending movies///////////
                      ///////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 22, 3, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              child: TextButton(
                                onPressed: () {
                                  //trending here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => trendingScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: Text(' Trending movies',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Color.fromRGBO(173, 162, 243, 1),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 141,
                        width: 327,
                        decoration: BoxDecoration(
                            //color: Color.fromRGBO(108, 92, 213, 1),
                            ),
                        child: loaded
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 101,
                                    height: 141,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${trendingmovies[index]['poster_path']}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  );
                                },
                              ),
                      ),
                      ///////////////////////////////////
                      /////////Top-rated movies//////////
                      ///////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 22, 3, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              child: TextButton(
                                onPressed: () {
                                  //trending here
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => topRatedScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero),
                                child: Text(' Top rated movies',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Color.fromRGBO(173, 162, 243, 1),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 141,
                        width: 327,
                        decoration: BoxDecoration(),
                        child: loaded
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 101,
                                    height: 141,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${topRatedMovie[index]['poster_path']}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
