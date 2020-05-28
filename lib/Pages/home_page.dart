import 'package:bookingapartment/models/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:bookingapartment/core/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = ApartmentModel.list;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
            color: Colors.black,
          ),
          title: Text(
            "Find Your Dream Flat",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Colors.black,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.stylecolor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Home"),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "55 result in your area",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            data: data[index],
                          ),
                        ),
                      );
                    },
                    child: _buildItems(context, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 250,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                image: DecorationImage(
                  image:
                      ExactAssetImage('assets/${data[index].images.first}.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 7, spreadRadius: 1, color: Colors.black26)
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                        left: 40,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * .25,
                            child: Text(
                              '${data[index].name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Icon(
                              Icons.directions,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDesc(context, index),
        ],
      ),
    );
  }

  Widget _buildDesc(context, index) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * .5,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 7, spreadRadius: 1, color: Colors.black12)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.euro_symbol,
                  size: 18,
                ),
                Text(
                  "${data[index].price.toInt()}/",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "months",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              "${data[index].sizeDesc}",
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            Row(
              children: <Widget>[
                RatingBar(
                  onRatingUpdate: (v) {},
                  initialRating: data[index].review,
                  itemSize: 12,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  "${data[index].reviewCount.toInt()} reviews",
                  style: TextStyle(color: Colors.black87, fontSize: 10),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                ...data[index].personImages.map((img) {
                  return Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/'+img+'.jpg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  );
                }),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Center(
                    child: Text(
                      '23+',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              children: <Widget>[
                ...data[index].features.map((feature) {
                  return Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(
                      bottom: 6,
                      right: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      color: AppColors.stylecolor,
                    ),
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
