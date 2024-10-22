import 'package:calculator_flutter/bloc/menu/menu_bloc.dart';
import 'package:calculator_flutter/bloc/menu/menu_event.dart';
import 'package:calculator_flutter/bloc/menu/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.headset_mic),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    BlocProvider.of<MenuBloc>(context).add(ProfileTapped());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icons/person.png'),
                          radius: 30,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ID:103423434543',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'User-c45gr',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Regular',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                    indent: 0.0,
                    endIndent: 0.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.wallet),
                              onPressed: () {},
                            ),
                            const Text('Wallet'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () {},
                            ),
                            const Text('Deposit'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.autorenew),
                              onPressed: () {},
                            ),
                            const Text('Convert'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.person_add),
                              onPressed: () {},
                            ),
                            const Text('Referral'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.manage_accounts),
                              onPressed: () {},
                            ),
                            const Text('Rewards Hub'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.help),
                              onPressed: () {},
                            ),
                            const Text('Support'),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.groups),
                              onPressed: () {},
                            ),
                            const Text('Traders'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey, width: 0.4),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BINANCE Pro',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is ProfileTappedState) {
                  return const Center(child: Text('Profile tapped!'));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
