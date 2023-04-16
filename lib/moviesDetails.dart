import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/favouriteCollection.dart';
import 'package:project1/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class movieDetails extends StatefulWidget {
  final String movieName,
      movieReview,
      voteCount,
      voteAverage,
      releaseDate,
      backdropPoster;
//constructor :these are requrired run
  const movieDetails({
    super.key,
    required this.movieName,
    required this.movieReview,
    required this.voteCount,
    required this.voteAverage,
    required this.releaseDate,
    required this.backdropPoster,
  });

  @override
  State<movieDetails> createState() => _movieDetailsState();
}

class _movieDetailsState extends State<movieDetails> {
  //bool if true add the movie
  bool favouriteMovieAdd = false;

  //dynamic list (list size is not fix)
  List<dynamic> favouriteMovies = [];

  //initializing shared preferences
  late SharedPreferences prefs;

  void loadSharedPreferences(Function callback) async {
    prefs = await SharedPreferences.getInstance();
    //get favourite movie list from shared pref
    var movies = prefs.getStringList('favouriteMovies');
    if (movies != null) {
      setState(() {
        //movies are now feed to the the favMovieslist
        favouriteMovies = movies;
      });
    }
    //call once its filled (loadSharedPreferences)
    callback();
  }

  @override
  void initState() {
    super.initState();
    //load favourite movies from Shared Preferences
    loadSharedPreferences(() {
      setState(() {
        //show whether the movie is on the list or not
        favouriteMovieAdd = favouriteMovies.contains(widget.movieName) &&
            favouriteMovies.contains(widget.backdropPoster);
      });
    });
  }

  Future<void> saveSharedPreferences() async {
    //convert favMovie list to string
    List<String> stringList =
        favouriteMovies.map((movie) => movie.toString()).toList();
    //save the movies
    await prefs.setStringList('favouriteMovies', stringList);
  }

  //add movies
  void addToFavourites() {
    setState(() {
      //if the movie exsist remove the move
      if (favouriteMovieAdd) {
        favouriteMovies.remove(widget.movieName);
        //add
      } else {
        favouriteMovies.add(widget.movieName);
      }
      favouriteMovieAdd = !favouriteMovieAdd;
      //add to prefs
      saveSharedPreferences();
    });
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
                          //
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              //go to home
                              Icons.home,
                              color: Color.fromARGB(255, 239, 239, 239),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homeScreen()),
                              );
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              // go to favourite page
                              Icons.favorite_sharp,
                              color: Color.fromARGB(255, 239, 239, 239),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => favouritesScreen()),
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
                //container to show poster
                margin: EdgeInsets.fromLTRB(0, 17, 0, 10),
                height: 269,
                width: 386,
                //if image is null show the alternate
                child: widget.backdropPoster != ''
                    ? Image.network(
                        widget.backdropPoster,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Color.fromRGBO(204, 198, 246, 1),
                        child: Center(
                          child: Text(
                            'Image is not available',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
              ),
              Container(
                height: 375,
                width: 370,
                margin: EdgeInsets.all(0),
                child: ListView(
                  padding: EdgeInsets.zero, // Set padding to zero
                  children: [
                    Align(
                      child: Container(
                        width: 370,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //if movie name is null show the alternate tect
                            Container(
                              width: 240,
                              child: Text(
                                widget.movieName != '' &&
                                        widget.movieName.isNotEmpty
                                    ? widget.movieName
                                    : "Name is not available",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              width: 110, // Set a fixed width
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.fromLTRB(65, 0, 0, 0),
                                    icon: Icon(Icons.favorite_sharp,
                                        //if bool is true colour is red
                                        //else it is white
                                        color: favouriteMovieAdd
                                            ? Colors.red
                                            : Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        //if bool is false remove the name and
                                        //posterurl if it is not true
                                        if (favouriteMovieAdd) {
                                          favouriteMovies
                                              .remove(widget.movieName);
                                          favouriteMovies
                                              .remove(widget.backdropPoster);
                                        } else {
                                          //add poster url and movie name
                                          favouriteMovies.add(widget.movieName);
                                          favouriteMovies
                                              .add(widget.backdropPoster);
                                        }
                                        //get the current state and make it opposite
                                        favouriteMovieAdd = !favouriteMovieAdd;
                                        saveSharedPreferences();
                                        //test code to see whether movie and url added properly to list
                                        print(favouriteMovies.length);
                                        print(favouriteMovies);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    Container(
                      height: 24,
                      margin: EdgeInsets.fromLTRB(0, 21, 0, 0),
                      child: Text(
                        'Released dates:   ${widget.releaseDate}',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color.fromARGB(255, 196, 96, 213),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    Container(
                      height: 24,
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Text(
                        //show vote count                                    show average votes
                        'Voted by ${widget.voteCount} and average rating is ${widget.voteAverage} ',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color.fromARGB(255, 196, 96, 213),
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: 370,
                      child: Text(
                        //get the movie review if null show alternat
                        widget.movieReview != '' &&
                                widget.movieReview.isNotEmpty
                            ? widget.movieReview
                            : "Review not available",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
