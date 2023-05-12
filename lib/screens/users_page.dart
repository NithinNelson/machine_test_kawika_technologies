import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:machine_test_kawika_technologies/screens/resultPage.dart';
import 'package:machine_test_kawika_technologies/services/api.dart';
import 'package:machine_test_kawika_technologies/services/common_widget.dart';
import 'package:machine_test_kawika_technologies/sqfLite/users.dart';
import 'package:machine_test_kawika_technologies/sqfLite/users_data.dart';

class UsersPage extends StatefulWidget {
  final String title;
  const UsersPage({Key? key, required this.title}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  TextEditingController controller = TextEditingController();
  bool loader = false;
  List<Users> userData = [];
  List<Users> newResult = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _getData() async {
    setState(() {
      loader = true;
    });
    await getRapi(context).then((value) {
      setState(() {
        loader = false;
      });
    });
    userData = await UserDatabase.instance.readAllItemData();
    if (userData.isEmpty) {
      setState(() {
        loader = true;
      });
    } else {
      print('---------w------------$userData');
      setState(() {
        newResult = userData;
        loader = false;
      });
      print('---------new------------$newResult');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Search User',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 10, 10, 10),
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: controller.text.isNotEmpty
                              ? const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                )
                              : Container(),
                          onPressed: () {
                            setState(() {
                              controller.clear();
                              newResult = userData;
                            });
                          },
                        ),
                        counterText: ""),
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                    maxLength: 15,
                    onChanged: (value) {
                      setState(() {
                        newResult = userData
                            .where((element) => element.userName
                                .toString()
                                .toUpperCase()
                                .contains(value.toUpperCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
              loader
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.yellow,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _getData,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 150),
                            itemCount: newResult.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ResultPage(
                                        title: newResult[index].userName,
                                        image: newResult[index].userImage,
                                        noOfRepo: newResult[index].noOfRepos,
                                        location: newResult[index].location,
                                        following: newResult[index].following,
                                        blog: newResult[index].blog,
                                        followers: newResult[index].followers,
                                      );
                                    }));
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    child: Card(
                                      color: Colors.grey[200],
                                      elevation: 5,
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: CircleAvatar(
                                              radius: 30,
                                              child: ClipOval(
                                                child: Image.network(
                                                    newResult[index].userImage,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder:
                                                        imageLoading),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    newResult[index].userName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.brown,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    "Location : ${newResult[index].location}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.brown,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
