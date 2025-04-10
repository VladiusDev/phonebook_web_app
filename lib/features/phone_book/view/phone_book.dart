import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_book/features/phone_book/bloc/phone_list_bloc.dart';
import 'package:phone_book/main.dart';
import 'package:phone_book/model/employee.dart';
import 'package:phone_book/strings.dart';
import 'package:phone_book/themes/theme.dart';

class PhoneBook extends StatefulWidget {
  const PhoneBook({super.key});

  @override
  State<PhoneBook> createState() => _PhoneBookState();
}

class _PhoneBookState extends State<PhoneBook> {
  late PhoneListBloc _phoneListBloc;

  @override
  void initState() {
    _phoneListBloc = PhoneListBloc();
    _loadPhoneBook();
    super.initState();
  }

  @override
  void dispose() {
    _phoneListBloc.close();

    super.dispose();
  }

  void _perfomSearch(String query) {
    _loadPhoneBook(query: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser!.email.toString();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.greenAccent[100],
        title: Text(appTitle, style: mainTheme.textTheme.headlineMedium),
        actions: [Text(user), Padding(padding: EdgeInsets.all(15))],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: null,
              onChanged: _perfomSearch,
              decoration: InputDecoration(
                hintText: searchText,
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
              child: BlocProvider(
            create: (context) => _phoneListBloc,
            child: BlocBuilder<PhoneListBloc, PhoneListState>(
              builder: (context, state) {
                if (state is PhoneListLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PhoneListLoaded) {
                  return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.black12,
                            endIndent: 7,
                            indent: 7,
                          ),
                      itemCount: state.phoneList.length,
                      itemBuilder: (context, index) {
                        Employee employee = state.phoneList[index];

                        return ListTile(
                          title: Text(employee.name,
                              style: mainTheme.textTheme.headlineMedium),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                employee.phone,
                                style: mainTheme.textTheme.headlineSmall,
                              ),
                              Text(
                                employee.organization,
                                style: mainTheme.textTheme.headlineSmall,
                              )
                            ],
                          ),
                        );
                      });
                } else if (state is PhoneListLoadingError) {
                  return Center(child: Text('$error ${state.error}'));
                } else {
                  return Center(child: Text(refreshText));
                }
              },
            ),
          ))
        ],
      ),
    );
  }

  Future<void> _loadPhoneBook({String query = ''}) async {
    if (query.isNotEmpty) {
      _phoneListBloc.add(LoadPhoneBook(query));
    } else {
      _phoneListBloc.add(LoadPhoneBook());
    }
  }
}
