import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/style/button.dart';

class Page1_Premium extends StatelessWidget {
  static const String routName="premium";
  const Page1_Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(14,46,92,1) ,
      body: Column(

        children: [
          Expanded(

          child:  Stack(
              children: [
                Container(
                    height: 300,

                    decoration: BoxDecoration(
                      color: Color.fromRGBO(14,46,92,1),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Adjust the value as needed
                    )
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Add your image path here
                    width: 320,
                    height: 320,
                  ),
                ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Text(
                  'Forcast for more than 7 days!',
                  style: TextStyle(fontSize:18, fontWeight: FontWeight.bold,color: Colors.white),
                ),),
              ],
            ),
          ),SizedBox(height: 40),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'UPGRADE TO PREMIUM',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Color(0xff076092)),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)
    ,
    borderRadius: BorderRadius.circular(18),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Monthly'),
                          Text('\$32'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)
                        ,
                        borderRadius: BorderRadius.circular(18),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Yearly'),
                          Text('\$90'),
                        ],
                      ),
                    ),
                    SizedBox(height: 35),
                    InkWell(

                      onTap: () {
                        //////
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => AddCamera()),
                        // );
                      },
                      child: CustomButton(label: 'Continue', imagePath: 'assets/images/button2.png', c: Colors.white,icon: null),
                    )
                    ,
                  ],
                ),
              ),
            ),),
        ],
      ),
    );
  }
}
