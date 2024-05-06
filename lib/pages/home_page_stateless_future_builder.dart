import 'package:flutter/material.dart';
import 'package:api/services/user_service.dart';

class HomePageStatelessFutureBuilder extends StatelessWidget {
  const HomePageStatelessFutureBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text(
          'Get API Future Builder',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: FutureBuilder(
          future: UserService.fetchUsers(),
          builder: (context, snapshot) {
            final users = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }

            return ListView.builder(
              itemCount: users!.length,
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
            );
          }),
    );
  }
}