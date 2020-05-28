import 'package:bookingapartment/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomSliderWidget extends StatefulWidget {
  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  var _maxWidth = 0.0;
  var _width = 0.0;
  var _value=0.0;
  var _booked = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraint) {
        _maxWidth = contraint.maxWidth;
        return Container(
          height: 60,
          decoration: BoxDecoration(
              color: _booked ?Colors.green:AppColors.stylecolor,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              border: Border.all(
                color: _booked ?Colors.green:AppColors.stylecolor,
                width: 3,
              )),
          child: Stack(
            children: <Widget>[
              Center(
                child: Shimmer(
                  gradient: LinearGradient(
                    colors: [Colors.blue,Colors.white60],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                  ),
                  child: Text(
                    _booked ? "Booked" :"Slide to book",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                width: _width <= 55 ? 55: _width,
                duration: Duration(milliseconds: 100),
                child: Row(
                  children: <Widget>[
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onVerticalDragUpdate: _drag,
                      onVerticalDragEnd: _dragEnd,
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Icon(
                          _booked?Icons.check:Icons.keyboard_arrow_right,
                          color: AppColors.stylecolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _drag(DragUpdateDetails details) {
    setState(() {
      _value = (details.globalPosition.dx)/_maxWidth;
      _width = _maxWidth * _value;
    });
  }

  void _dragEnd(DragEndDetails details) {
    if(_value > .9){
      _value = 1;
    }else{
      _value = 0;
    }

    setState(() {
      _width = _maxWidth * _value;
      _booked = _value > .9 ?true:false;
    });
  }
}
