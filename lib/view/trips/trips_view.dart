import 'package:amitie_voyage/view/trips/widgets/trip_list.dart';
import 'package:flutter/material.dart';

import '/view/widgets/drawer.dart';
import '../../models/trip_model.dart';

class TripsView extends StatefulWidget {
  static const String routeName = "/trips";
  final List<Trip> trips;
  const TripsView({super.key, required this.trips});

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mes Voyages"),
          bottom: const TabBar(tabs: [
            Tab(
              text: "A venir",
            ),
            Tab(
              text: "Passés",
            )
          ]),
          centerTitle: true,
        ),
        drawer: const AmitieDrawer(),
        body: TabBarView(
          children: [
            TripList(
              trips: widget.trips
                  .where((trip) => DateTime.now().isBefore(trip.date!))
                  .toList(),
            ),
            TripList(
              trips: widget.trips
                  .where((trip) => DateTime.now().isAfter(trip.date!))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
