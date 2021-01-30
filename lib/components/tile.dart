import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'interface.dart';
import '../pages/gameplay.dart';
import '../classes/notifications.dart';
import '../classes/colorset.dart';
import '../model/settings.dart';

class Tile extends StatefulWidget {
  final key, size, id, textString, touchable;


  Tile(
       this.key, this.size, this.id, this.textString, this.touchable);

  @override
  State createState() => TileState();
}

class TileState extends State<Tile> {
  double endSize;
  double endScale = .9;
  bool onState;
  double tileSize;

  @override
  void initState() {
    super.initState();
    tileSize = widget.size;
    endSize = tileSize * .9;
    onState = false;
    if (widget.touchable) {
      onState= true;
    }
  }

  @override
  Widget build(BuildContext context) {
      Settings mySettings = Settings();
    Colorset introColorSet = mySettings.myColorSet; //new Colorset(0);

    Color insideColor, outsideColor, shadowColor, textColor, textShadowColor;

    if (widget.touchable) {
      onState= true;
    }
    if (onState) {

      insideColor = introColorSet.insideHi;
      outsideColor = introColorSet.outsideHi;
      shadowColor = introColorSet.shadowHi;
      textColor = introColorSet.textHi;
      textShadowColor = introColorSet.textShadowHi;

    } else {

       insideColor = introColorSet.inside;
       outsideColor = introColorSet.outside;
       shadowColor = introColorSet.shadow;
       textColor = introColorSet.text;
       textShadowColor = introColorSet.textShadow;
      
    }

    return Container(
        alignment: Alignment.center,
        width: tileSize,
        height: tileSize,
        child: GestureDetector(
            onTapDown: pressDown,
            onTapUp: pressUp,
            onTapCancel: pressCancel,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: endScale),
                duration: Duration(milliseconds: 150),
                builder: (_, num myScale, __) {
                  return 

                    Transform.scale(
                      alignment: Alignment.center,
                      scale: myScale,
                      child:
                      Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            width: endSize,
                            height: endSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: outsideColor,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColor,
                                    blurRadius: 5,
                                    spreadRadius: 5),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Stack(children: [
                            Container(
                              alignment: Alignment.center,
                              width: endSize * .75,
                              height: endSize * .75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: insideColor,
                              ),
                            ),
                          ]),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: boxText(widget.textString, textColor, textShadowColor))
                      ]
                      //)
                      )
                      );
                })));
  }

  void pressDown(details) {
    // developer.log('press down');
    setState(() {
      // endSize = tileSize * .75;
      endScale = .75;
    });
  }

  void pressCancel() {
    setState(() {
     // endSize = tileSize * .9;
     endScale = .9;
    });
  }

  void pressUp(details) {
   //  developer.log('press up');'
   if (widget.touchable) {
   // developer.log("dispatching touch notification.");
    PlayNotification(id: widget.id)..dispatch(context);

   }
    setState(() {
     // endSize = tileSize * .9;
     endScale = .9;
    });
  }

  void turnOn() {
    setState(() {
      onState = true;
    });
  }

  void turnOff() {
    setState(() {
      onState = false;
    //  developer.log("turning myself off.");
    });
  }

  void toggleMe() {
    setState(() {
      if (widget.touchable) {
      onState = !onState;
    //  developer.log('toggling tile');
      }
    });
  }
}
