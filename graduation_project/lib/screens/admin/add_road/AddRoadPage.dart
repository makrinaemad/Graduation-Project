import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import '../../../models/RoadModel.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../drawer_screen.dart';
import 'MyAddMap.dart';
import 'RoadsProvider.dart';

class AddRoadPage extends HookWidget {
  static const String routName="AddRoad";
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final roadNameController = useTextEditingController();
    final addressController = useTextEditingController();
    final stPoint = useState<LatLng?>(null);
    final endPoint = useState<LatLng?>(null);
    final loading = useState(false);

    void handleSubmit() async {
      if (formKey.currentState?.validate() ?? false) {
        if (stPoint.value == null || endPoint.value == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please set a start point and end point on the map')),
          );
          return;
        }

        final RoadModel newRoad = RoadModel(
          name: roadNameController.text,
          address: '${addressController.text} ${stPoint.value?.latitude}-${stPoint.value?.longitude} ${endPoint.value?.latitude}-${endPoint.value?.longitude}',
        );

        loading.value = true;

        //await ApiManager().PostRoad(newRoad);
       // await context.read<RoadsProvider>().addNewRoad(newRoad);
     //   ApiManager roadService = ApiManager();
        await ApiManager.PostRoad (newRoad);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
        loading.value = false;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('New Road is Added Successfully')),

        );


      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Road',),
          backgroundColor: Color.fromRGBO(14,46,92,1)
      ),
      body: loading.value
          ? Center(child: CircularProgressIndicator())
          : Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 10,)        ,
            CustomTextFormField(
              textColor:  Color.fromRGBO(14, 46, 92, 1),
              labelText:'Road Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the road name';
                }
                return null;
              },
              controller:roadNameController,
              keyboardType: TextInputType.text,

            ),
            GradientDivider(),
SizedBox(height: 10,)        ,
            CustomTextFormField(
              textColor:  Color.fromRGBO(14, 46, 92, 1),
              labelText:'Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address';
                }
                return null;
              },
              controller:addressController,
              keyboardType: TextInputType.text,

            ),
            GradientDivider(),
            Expanded(
              child: MyAddMap(
                setSTPoint: (point) => stPoint.value = point,
                setENDPoint: (point) => endPoint.value = point,
              ),
            ),
            MaterialButton(
              //padding: EdgeInsets.only(left: 50,right: 50),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),),
              // style: ElevatedButton.styleFrom(
              color: Color.fromRGBO(14,46,92,1),
              // shadowColor:Color.fromRGBO(63,190,218,1) ,

              // borderRadius: BorderRadius.circular(5),// Set the background color here
              //   ),
              onPressed: () {
                handleSubmit();
              },
              child: Text('Add',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      endDrawer: DrawerScreen(),
    );
  }
}
