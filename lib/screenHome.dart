import 'package:flutter/material.dart';
import 'package:loginproject/screenLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> filmnames = [
      "Romanjam",
      "Home",
      "Premam",
      "Saghavu",
      "Kalki",
      "Virus",
      "Trance",
      "Aamen"
    ];
    List<String> filmicons = [
      "https://m.media-amazon.com/images/M/MV5BZjFkMmZkNmYtMDAyNC00OTc5LTliNDgtNGI0MDI4ODIwOGNmXkEyXkFqcGdeQXVyMjkxNzQ1NDI@._V1_.jpg",
      "https://upload.wikimedia.org/wikipedia/en/3/36/Home_%282021_film%29.jpg",
      "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/2baee529323171.55edda9493f77.jpg",
      "https://nettv4u.com/imagine/12-04-2017/sakhavu-malayalam-movie-posters-and-stills-5.jpg",
      "https://i.pinimg.com/736x/09/28/12/0928129b912122cf98c28eb561fa1359.jpg",
      "https://www.nairtejas.com/wp-content/uploads/2019/12/Virus-Malayalam-film-poster-by-Popkon-702x1024-501x731.jpg",
      "https://wallpapercave.com/wp/wp7610895.jpg",
      "https://i.pinimg.com/originals/75/22/f5/7522f5d215d3c3ef32b4ee778a2a54df.jpg"
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Book Cinemas",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset('assets/images/romanjam.jpg')),
            ),
            Text(
              "Malayalam Films",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(filmnames[index]),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.event_available)),
                        subtitle: Text("Malayalam Film"),
                        leading: index % 3 == 0
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(filmicons[index]),
                                radius: 30,
                              )
                            : Container(
                                height: 55,
                                width: 55,
                                child: Image.network(filmicons[index]),
                              ));
                  },
                  itemCount: filmicons.length),
            )
          ],
        ),
      ),
    );
  }

  void signout(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: Text("Signout"),
            content: Text("Do you want to Logout?"),
            actions: [
              TextButton(
                  onPressed: () {
                    SignYes(ctx1);
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx1).pop();
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  Future<void> SignYes(BuildContext ctx) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isLoggedin', false);
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => ScreenLogin()), (route) => false);
  }
}
