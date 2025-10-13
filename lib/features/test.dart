import 'dart:async';
import 'dart:ui' as ui;

import 'package:charm/features/resource_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class SubView extends StatelessWidget {
  const SubView({super.key});

  Future<ui.Image> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return await decodeImageFromList(data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ResourceBloc, ResourceState>(
                builder: (context, state) => Text(
                  'shapes: ${state.shapes.length}\nbgs: ${state.backgrounds.length}\nitems: ${state.items.length}',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("back"),
              ),
              _box(
                2,
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/dark_noise.jpg"),
                ),
              ),
              _box(
                1,
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/dark_noise.jpg"),
                ),
              ),
              _box(
                0.5,
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/dark_noise.jpg"),
                ),
              ),
              _box(
                0.001,
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/dark_noise.jpg"),
                ),
              ),
              // Container(width: 50, height: 750, color: Colors.red),
              // Container(width: 50, height: 50, color: Colors.blue),
              // Container(width: 50, height: 750, color: Colors.red),
              // Container(
              //   width: 500,
              //   height: 500,
              //   color: Colors.red,
              //   child: Image.asset(
              //     "assets/images/dark_noise.jpg",
              //     colorBlendMode: BlendMode.screen,
              //     color: Colors.blue,
              //     repeat: ImageRepeat.repeat,
              //   ),
              // ),

              // Container(width: 250, height: 250, decoration: BoxDecoration(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _box(double density, Widget child) {
    return FutureBuilder(
      future: loadImage("assets/images/dark_noise.jpg"),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return ImageShader(
                asyncSnapshot.data!,
                TileMode.repeated,
                TileMode.repeated,
                (Matrix4.identity() * density).storage,
              );
            },
            blendMode: BlendMode.screen,
            child: child,
          );
        } else {
          return SizedBox(width: 200, child: Text('loading'));
        }
      },
    );
  }
}

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  double scale = 1;

  final StreamController<TiltStreamModel> tiltStreamController =
      StreamController<TiltStreamModel>.broadcast();

  @override
  void initState() {
    super.initState();
    tiltStreamController.add(TiltStreamModel(position: Offset(0, 0)));
  }

  final List<Offset> _stars = [];

  void _addStar(TapDownDetails details) async {
    setState(() {
      _stars.add(details.localPosition); // position where user tapped
    });
    // Remove star after delay (so it doesn’t stay forever)
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (_stars.isNotEmpty) _stars.removeAt(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTapDown: (details) {
            _addStar(details);
          },
          onTap: () {
            print("tap");
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  child: Image.network('https://picsum.photos/200', fit: BoxFit.fill),
                ),
              ),
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15), // blur strength
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.white.withOpacity(0.2), // translucent layer
                      child: Center(
                        child: Text("Foggy", style: TextStyle(color: Colors.white, fontSize: 24)),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        // behavior: HitTestBehavior.opaque,
                        onVerticalDragStart: (details) {
                          print('start drag v');
                          setState(() {
                            scale = 2;
                          });
                        },
                        onVerticalDragEnd: (details) {
                          print('end drag v');
                          setState(() {
                            scale = 1;
                          });
                        },
                        // onVerticalDragUpdate: (details) {
                        //   print('drag update');
                        // },
                        child: AnimatedScale(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          scale: scale,
                          child: tiltItem(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ..._stars.map((e) {
                return Positioned(
                  top: e.dy,
                  left: e.dx,
                  child: Icon(Icons.star, color: Colors.white),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget tiltItem() {
    return Tilt(
      // onGestureMove: (tiltDataModel, gesturesType) {
      //   setState(() {
      //     scale = 1;
      //   });
      // },
      // onGestureLeave: (tiltDataModel, gesturesType) {
      //   setState(() {
      //     scale = 1;
      //   });
      // },
      tiltStreamController: tiltStreamController,
      tiltConfig: TiltConfig(
        // enableRevert: false,
        // enableSensorRevert: false,
        enableGestureSensors: false,
      ),
      childLayout: ChildLayout(
        outer: [1.0, 2.0, 3.0, 4.0, 5.0].map((value) {
          final pos = (value) * 10;
          return Positioned(
            child: TiltParallax(
              size: Offset(pos, pos),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15), // blur strength
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.white.withOpacity(0.2), // translucent layer
                    child: Center(
                      child: Text("Foggy", style: TextStyle(color: Colors.white, fontSize: 24)),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),

        // [
        //   /// Parallax here
        //   Positioned(
        //     child: TiltParallax(size: Offset(0.0, 0.0), child: Text('Parallax')),
        //   ),

        //   /// Parallax here
        //   Positioned(
        //     // top: 20.0,
        //     // left: 20.0,
        //     child: TiltParallax(size: Offset(10.0, 10.0), child: Text('Tilt1')),
        //   ),
        //   Positioned(
        //     // top: 20.0,
        //     // left: 20.0,
        //     child: TiltParallax(size: Offset(20, 20), child: Text('Tilt2')),
        //   ),
        //   // Positioned(
        //   //   child: TiltParallax(
        //   //     size: Offset(-20, -20),
        //   //     child: Container(
        //   //       width: 150.0,
        //   //       height: 300.0,
        //   //       color: Colors.red.withAlpha((0.5 * 255).toInt()),
        //   //     ),
        //   //   ),
        //   // ),
        // ],
      ),
      child: Container(
        width: 150.0,
        height: 150.0,
        color: Colors.grey.withAlpha((0.9 * 255).toInt()),
      ),
    );
  }
}
