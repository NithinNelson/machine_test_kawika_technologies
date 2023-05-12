import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:machine_test_kawika_technologies/services/common_widget.dart';
import 'package:machine_test_kawika_technologies/sqfLite/users.dart';
import 'package:machine_test_kawika_technologies/sqfLite/users_data.dart';

List<Users> userData = [];
List<Map> userList = [];

Future<void> getRapi(context) async {
  await refreshData();
  try {
    print('---------1-----------');
    var response = await http.get(
        Uri.parse(
          "https://api.github.com/users",
        ),
        headers: {'Authorization': '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'});
    print('---------2-----------${response.body}');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('-----------data--------------$data');
      if (data.isNotEmpty) {
        for (int i = 0; i < data.length; i++) {
          bool dbUser = false;
          for (int j = 0; j < userList.length; j++) {
            // print('------------------${userList[j]['userName']}');
            // print('------------------${data[i]['login']}');
            if (userList[j]['userName'] != data[i]['login']) {
              dbUser = true;
              print('------------------${userList[j]['userName']}');
              print('------------------${data[i]['login']}');
              break;
            } else {
              dbUser = false;
            }
          }
          if (dbUser == false) {
            String userName = data[i]['login'];
            await getUserData(userName, context);
          }
        }
      }
    }
  } on SocketException catch (e) {
    snackBar(context, "Connection Problem");
  } catch (e) {
    // snackBar(context, e.toString());
    print('------e------${e.toString()}');
  }
  refreshData();
}

Future<void> getUserData(userName, context) async {
  try {
    var response = await http.get(
        Uri.parse(
          "https://api.github.com/users/$userName",
        ),
        headers: {'Authorization': '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'});
    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      print('-----------userData--------------$userData');
      if (userData != null &&
          userData['id'] != null) {
        final users = Users(
            userName: userData['name'],
            userImage: userData['avatar_url'],
            noOfRepos: userData['public_repos'],
            location: userData['location'],
            blog: userData['blog'],
            followers: userData['followers'],
            following: userData['following']);
        await UserDatabase.instance.create(users);
      }
    }
  } on SocketException catch (e) {
    snackBar(context, "Connection Problem");
  } catch (e) {
    // snackBar(context, e.toString());
    print('------er------${e.toString()}');
  }
}

Future<void> refreshData() async {
  userList.clear();
  userData = await UserDatabase.instance.readAllItemData();
  userData.forEach((element) {
    userList.insert(0, {
      "userName": element.userName,
      "userImage": element.userImage,
      "noOfRepos": element.noOfRepos,
      "location": element.location,
      "blog": element.blog,
      "followers": element.followers,
      "following": element.following,
    });
  });
  print('-------------trbw-----------------$userList');
  print('-------------trbw-----------------${userList.length}');
}
