import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project1/favouriteCollection.dart';
import 'package:project1/homePage.dart';
import 'package:project1/moviesDetails.dart';

class topRatedScreen extends StatefulWidget {
  const topRatedScreen({super.key});

  @override
  State<topRatedScreen> createState() => _topRatedScreenState();
}

class _topRatedScreenState extends State<topRatedScreen> {
  bool isGridView = true;
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  fetchMovies() async {
    var url = Uri.parse(
        //call top rated
        "https://api.themoviedb.org/3/movie/top_rated?api_key=9b668f392738c30a76933292793fe3a2&language=en-US&page=1");

    final response = await http.get(url);
    final data = json.decode(response.body);
    final results = data['results'];

    setState(() {
      movies = results;
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
                    // width: 126,
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
                          IconButton(
                            icon: Icon(
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
                            icon: Icon(
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
                          IconButton(
                            icon: Icon(
                              isGridView ? Icons.grid_view : Icons.list,
                              color: Color.fromARGB(255, 239, 239, 239),
                            ),
                            onPressed: () {
                              setState(() {
                                isGridView = !isGridView;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 24, 3, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 24,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          'Top-rated movies',
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
                margin: EdgeInsets.fromLTRB(0, 3, 0, 15),
                height: 602,
                width: 328,
                child: isGridView
                    ? GridView.builder(
                        itemCount: movies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 101 / 138,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 37,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final movie = movies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => movieDetails(
                                    backdropPoster: movies[index]
                                                ['backdrop_path'] !=
                                            null
                                        ? 'https://image.tmdb.org/t/p/w500' +
                                            movies[index]['backdrop_path']
                                        : '',
                                    movieName: movies[index]['title'] != null
                                        ? movies[index]['title']
                                        : '',
                                    movieReview:
                                        movies[index]['overview'] != null
                                            ? movies[index]['overview']
                                            : '',
                                    voteCount: movies[index]['vote_count']
                                                .toString() !=
                                            null
                                        ? movies[index]['vote_count'].toString()
                                        : '',
                                    voteAverage: movies[index]['vote_average']
                                                .toString() !=
                                            null
                                        ? movies[index]['vote_average']
                                            .toString()
                                        : '',
                                    releaseDate: movies[index]['release_date']
                                                .toString() !=
                                            null
                                        ? movies[index]['release_date']
                                            .toString()
                                        : '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 138,
                              width: 101,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          final movie = movies[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => movieDetails(
                                    backdropPoster: movies[index]
                                                ['backdrop_path'] !=
                                            null
                                        ? 'https://image.tmdb.org/t/p/w500' +
                                            movies[index]['backdrop_path']
                                        : '',
                                    movieName: movies[index]['title'] != null
                                        ? movies[index]['title']
                                        : '',
                                    movieReview:
                                        movies[index]['overview'] != null
                                            ? movies[index]['overview']
                                            : '',
                                    voteCount: movies[index]['vote_count']
                                                .toString() !=
                                            null
                                        ? movies[index]['vote_count'].toString()
                                        : '',
                                    voteAverage: movies[index]['vote_average']
                                                .toString() !=
                                            null
                                        ? movies[index]['vote_average']
                                            .toString()
                                        : '',
                                    releaseDate: movies[index]['release_date']
                                                .toString() !=
                                            null
                                        ? movies[index]['release_date']
                                            .toString()
                                        : '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              height: 520,
                              width: 480,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 480, 0, 0),
                                decoration: BoxDecoration(color: Colors.white),
                                child: Center(
                                  child: Text(
                                    movie['title'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
