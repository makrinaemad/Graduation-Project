import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class Map extends StatefulWidget {


 // MyAddMap({required this.setSTPoint, required this.setENDPoint, required this.setcenterPoint});

  @override
  _MyAddMapState createState() => _MyAddMapState();
}

class _MyAddMapState extends State<Map> {
  LatLng? startPoint;
  LatLng? endPoint;
  late MapController mapController;
  List<Polyline> lstPolygone = [];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController;
    });
  //  print("initState: centerPoint = ${widget.setcenterPoint}");
  }

  // @override
  // void didUpdateWidget(covariant Map oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // Update centerPoint when the widget is updated
  //   if (oldWidget.setcenterPoint != widget.setcenterPoint) {
  //     mapController.move(widget.setcenterPoint, mapController.zoom);
  //     print("didUpdateWidget: centerPoint updated to ${widget.setcenterPoint}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center:  LatLng(30.0444, 31.2357),
            zoom: 8.0,
            enableScrollWheel: true,
            initialZoom: 8,
            onTap: (_, point) {
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
          ],
        ),
      ),
     // endDrawer: DrawerScreen(),
    );
  }
}
