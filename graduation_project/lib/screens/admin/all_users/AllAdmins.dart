import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/UserModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import 'UserItem.dart';

class AdminListScreen extends StatefulWidget {
  static const String routName = "Admins";
  const AdminListScreen({super.key});

  @override
  _AdminListScreenState createState() => _AdminListScreenState();
}

class _AdminListScreenState extends State<AdminListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Result> _admins = [];
  List<Result> _filteredAdmins = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAdmins();
    _searchController.addListener(_filterAdmins);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchAdmins() async {
    try {
      var response = await ApiManager.getUsers("user/");
      setState(() {
        _admins = response.result?.where((user) => user.isAdmin ?? false).toList() ?? [];
        _filteredAdmins = _admins;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching admins: $error';
        _isLoading = false;
      });
    }
  }

  void _filterAdmins() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAdmins = _admins.where((admin) {
        return (admin.name?.toLowerCase().contains(query) ?? false) ||
            (admin.email?.toLowerCase().contains(query) ?? false) ||
            (admin.address?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHome()),
            );
          },
        ),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
        title: Text('Admins'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: _buildAdminsList(),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }

  Widget _buildAdminsList() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.blue),
      );
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            TextButton(
              onPressed: _fetchAdmins,
              child: const Text("Try again"),
            ),
          ],
        ),
      );
    }
    if (_filteredAdmins.isEmpty) {
      return Center(child: Text('No admins found'));
    }
    return ListView.builder(
      itemCount: _filteredAdmins.length,
      itemBuilder: (context, index) {
        return UserItem(_filteredAdmins[index]);
      },
    );
  }
}
