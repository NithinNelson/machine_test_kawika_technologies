import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test_kawika_technologies/services/common_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  final String title;
  final String image;
  final String location;
  final String blog;
  final int noOfRepo;
  final int followers;
  final int following;

  const ResultPage({
    Key? key,
    required this.title,
    required this.image,
    required this.location,
    required this.noOfRepo,
    required this.following,
    required this.blog,
    required this.followers,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.addAll([
      ProfilePage(
        imageUrl: widget.image,
        name: widget.title,
        location: widget.location,
        noOfRepo: widget.noOfRepo,
        blog: widget.blog,
        followers: widget.followers,
        following: widget.following,
      ),
      RepositoryPage(),
    ]);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Repository',
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String location;
  final String blog;
  final int noOfRepo;
  final int followers;
  final int following;

  const ProfilePage(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.location,
      required this.noOfRepo,
      required this.blog,
      required this.followers,
      required this.following})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 100,
            child: ClipOval(
              child: Image.network(imageUrl,
                  fit: BoxFit.cover, loadingBuilder: imageLoading),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        'Followers',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        maxLines: 1,
                      ),
                      Text(
                        '$followers',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Text(
                    '|',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 40),
                    maxLines: 1,
                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        'Following',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        maxLines: 1,
                      ),
                      Text(
                        '$following',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Location : ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      width: 160,
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'No.of Repositories : ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        "$noOfRepo",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepositoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Repository Page'),
    );
  }
}
