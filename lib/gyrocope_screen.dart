import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeScreen extends StatelessWidget {

  const GyroscopeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double x = 0, y = 0, z = 0;

    double xRad = 0, yRad = 0, zRad = 0;

    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: gyroscopeEvents,
          builder: (context, snapshot) {

            if (snapshot.hasData && snapshot.data != null) {
              x = double.parse(snapshot.data!.x.toStringAsFixed(1));
              y = double.parse(snapshot.data!.y.toStringAsFixed(1));
              z = double.parse(snapshot.data!.z.toStringAsFixed(1));

              xRad += x / 5;
              yRad += y / 5;
              zRad += z / 5;
            }
            
            return Container(
              color: const Color.fromARGB(255, 20, 20, 20),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ShowDegreeInfo(title: "Eje x", radPerSecond: x, rad: xRad, rotation: zRad,),
                    ShowDegreeInfo(title: "Eje y", radPerSecond: y, rad: yRad, rotation: zRad,),
                    ShowDegreeInfo(title: "Eje z", radPerSecond: z, rad: zRad, rotation: zRad,),

                  ],
                )
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          xRad = 0;
          yRad = 0;
          zRad = 0;
        }, 
        child: const Icon( Icons.adjust_outlined ),
      
      ),
    );
  }
}

class ShowDegreeInfo extends StatelessWidget {
  const ShowDegreeInfo({
    super.key,
    required this.title,
    required this.radPerSecond,
    required this.rad,
    required this.rotation,
  });

  final String title;
  final double radPerSecond;
  final double rad;
  final double rotation;
  static const double toDegree = 57.295779513;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width * 0.45,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: Theme.of(context).focusColor
      ),

      child: Transform.rotate(
        angle: rotation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 17),),
      
            const SizedBox(height: 5,),
      
            Text('${(rad * toDegree).toStringAsPrecision(3)}°', style: const TextStyle(fontSize: 30),),
      
            const SizedBox(height: 5,),
      
            Text('$radPerSecond rad/s'),
          ],
        ),
      ),
    );
  }
}

