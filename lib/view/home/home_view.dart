import 'package:amitie_voyage/view/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'widgets/city_card.dart';
import '../../models/city_model.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/';
  final List<City> cities;

   HomeView({super.key,required this.cities});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amitie Voyage'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      drawer: const AmitieDrawer(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...widget.cities.map((city) {
              return CityCard(city: city);
            })
          ],
        ),
      ),
    );
  }
}
