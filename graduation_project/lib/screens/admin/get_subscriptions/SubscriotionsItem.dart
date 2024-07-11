import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_project/models/PlanModel.dart';
import 'package:graduation_project/models/SubscribtionsModel.dart';

import '../../../models/UserModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../all_users/UserDetailsScreen.dart';
import '../get_plans/PlanItem.dart';
import 'get_plan_details.dart';

class SubscribtionsItem extends StatefulWidget {
  final SubscriptionModel sub;

  SubscribtionsItem(this.sub, {super.key});

  @override
  _SubscribtionsItemState createState() => _SubscribtionsItemState();
}

class _SubscribtionsItemState extends State<SubscribtionsItem> {
  Result? user;
  Plans? plan;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchPlanData();
  }

  Future<void> fetchUserData() async {
    try {
      user = await ApiManager().fetchUserData("user/${widget.sub.userId}");
      setState(() {}); // Update the state to refresh the UI
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchPlanData() async {
    try {
      plan = await ApiManager.fetchPlanData("/subscription/getPlan/${widget.sub.planId}");
      setState(() {}); // Update the state to refresh the UI
    } catch (e) {
      print('Error fetching plan data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name =user?.name ?? 'Loading...';
    return Card(
      color: Color.fromRGBO(14, 46, 92, 1),
      elevation: 12,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.transparent)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) async {
                try {
                  if (plan != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanDetails(plan: plan!),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              spacing: 15,
              backgroundColor: Colors.grey,
              icon: Icons.assignment_sharp,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (BuildContext context) async {
                try {
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(user: user!),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              spacing: 15,
              backgroundColor: Colors.blueGrey,
              icon: Icons.person_2_sharp,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Row(
              children: [
                Container(
                    height: 60,
                    width: 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white),
                    )),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Name : ${name}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Plan ID : ${widget.sub.planId}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Start Date : ${widget.sub.startDate}",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
