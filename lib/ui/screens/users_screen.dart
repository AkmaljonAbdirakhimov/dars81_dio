import 'package:dars81_dio/bloc/users/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            onPressed: () {
              String name = "Valijon";
              String job = "O'qituvchi";

              context.read<UsersBloc>().add(AddUserEvent(name, job));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        bloc: context.read<UsersBloc>()..add(GetUsersEvent()),
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Qo'shildi")),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorUsersState) {
            return Center(
              child: Text(state.message),
            );
          }

          List<User> users = [];

          if (state is LoadedUsersState) {
            users = state.users;
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                ),
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
