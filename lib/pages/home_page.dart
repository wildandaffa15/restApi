import 'package:flutter/material.dart';
import 'package:api/models/user.dart';
import 'package:api/services/user_service.dart';

class HomePageStateful extends StatefulWidget {
  const HomePageStateful({super.key});

  @override
  State<HomePageStateful> createState() => _HomePageStatefulState();
}

class _HomePageStatefulState extends State<HomePageStateful> {
  List<User> users = [];
  bool isLoading = true;

  void fetchUser() async {
    isLoading = true;
    final result = await UserService.fetchUsers();
    users = result;
    setState(() {});
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text(
          'Get API Stateful',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  color: Colors.greenAccent,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  ),
                );
              },
            ),
    );
  }
}