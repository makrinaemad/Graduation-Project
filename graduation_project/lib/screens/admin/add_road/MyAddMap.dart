import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../drawer_screen.dart';

class MyAddMap extends StatefulWidget {
  final Function(LatLng) setSTPoint;
  final Function(LatLng) setENDPoint;

  MyAddMap({required this.setSTPoint, required this.setENDPoint});

  @override
  _MyAddMapState createState() => _MyAddMapState();
}

class _MyAddMapState extends State<MyAddMap> {
  LatLng? startPoint;
  LatLng? endPoint;

  List<Polyline> lstPolygone = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(30.0444, 31.2357),
          zoom: 8.0,
          onTap: (_, point) {
            setState(() {
              if (startPoint == null) {
                startPoint = point;
                widget.setSTPoint(point);
              } else if (endPoint == null) {
                endPoint = point;
                widget.setENDPoint(point);

                // Adding the polyline between start and end points
                if (startPoint != null && endPoint != null) {
                  lstPolygone = [
                    Polyline(
                      points: [startPoint!, endPoint!],
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    )
                  ];
                }
              }
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: lstPolygone,
          ),
          // if (startPoint != null)
          //   MarkerLayer(
          //     markers: [
          //       Marker(
          //         point: startPoint!,
          //         width: 5,
          //         height: 5,
          //         child:  Icon(
          //           Icons.location_on,
          //           color: Colors.red,
          //
          //         ),
          //       ),
          //     ],
          //   ),
          // if (endPoint != null)
          //   MarkerLayer(
          //     markers: [
          //       Marker(
          //         point: endPoint!,
          //         width: 5,
          //         height:5,
          //         child: Icon(
          //           Icons.location_on,
          //           color: Colors.green,
          //
          //         ),
          //       ),
         //     ],
         //   ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
