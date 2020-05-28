import 'package:bookingapartment/models/apartment_model.dart';
import 'package:bookingapartment/widgets/custom_slider_sidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class DetailPage extends StatefulWidget {
  final ApartmentModel data;

  DetailPage({this.data});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _pageController = PageController();
  var _curentIndex = 0;
  var _maxLines = 3;
  var _fav = true;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _curentIndex = _pageController.page.round();
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _imageSliderWidget(context),
          _sliderIndicatorWidget(context),
          _closeButtonWidget(context),
          _priceWidget(),
          _roomsDesc(context),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .15,
          right: MediaQuery.of(context).size.width * .15,
          bottom: 12,
        ),
        child: CustomSliderWidget(),
      ),
    );
  }

  Widget _roomsDesc(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .5,
      minChildSize: .5,
      maxChildSize: .8,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                ),
                margin: EdgeInsets.only(
                  top: 24,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.drag_handle,
                        color: Colors.black38,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        widget.data.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _roomsSizeWidget(
                            "Living Room",
                            widget.data.sizeLivingRoom,
                          ),
                          Container(
                            width: 1,
                            height: 50,
                            color: Colors.black38,
                          ),
                          _roomsSizeWidget(
                            "Bedroom",
                            widget.data.sizeBedRoom,
                          ),
                          Container(
                            width: 1,
                            height: 50,
                            color: Colors.black38,
                          ),
                          _roomsSizeWidget(
                            "Bathroom",
                            widget.data.sizeBathRoom,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.data.desc,
                        style: TextStyle(
                          height: 1.5,
                        ),
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_maxLines == 3) {
                              _maxLines = 10;
                            } else {
                              _maxLines = 3;
                            }
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              _maxLines > 3 ? "View less" : "View more",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                height: 1.5,
                              ),
                            ),
                            Icon(_maxLines > 3
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 40,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (_fav == true) {
                          _fav = false;
                        } else {
                          _fav = true;
                        }
                      });
                    },
                    child: Icon(
                      _fav == true ? Icons.favorite : Icons.favorite_border,
                      color: _fav == true ? Colors.red : Colors.black12,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _roomsSizeWidget(String name, int size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          size.toString() + " sqft",
          style: TextStyle(height: 1.5, fontSize: 16, color: Colors.black38),
        )
      ],
    );
  }

  Widget _priceWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: 24,
        top: 50,
      ),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.euro_symbol,
            color: Colors.white,
          ),
          Text(
            "${widget.data.price.toInt()}/",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "months",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _sliderIndicatorWidget(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .45,
        ),
        child: SliderIndicator(
          length: widget.data.images.length,
          activeIndex: _curentIndex,
          indicator: Icon(
            Icons.radio_button_unchecked,
            color: Colors.white,
            size: 10,
          ),
          activeIndicator: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 12,
          ),
        ),
      ),
    );
  }

  Widget _closeButtonWidget(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 24, top: 45),
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _imageSliderWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      child: PageView.builder(
          controller: _pageController,
          itemCount: widget.data.images.length,
          itemBuilder: (context, index) {
            return Image.asset(
              "assets/${widget.data.images[index]}.jpg",
              fit: BoxFit.cover,
            );
          }),
    );
  }
}
