import 'package:amitie_voyage/view/city/city_view.dart';
import 'package:amitie_voyage/view/trips/trips_view.dart';
import 'package:flutter/material.dart';

import 'models/city_model.dart';
import 'models/trip_model.dart';
import 'view/home/home_view.dart';
import './data/data.dart' as data;

void main() => runApp(AmitieVoyage());

class AmitieVoyage extends StatefulWidget {
  final List<City> cities = data.cities;

  AmitieVoyage({super.key});

  @override
  State<AmitieVoyage> createState() => _AmitieVoyageState();
}

class _AmitieVoyageState extends State<AmitieVoyage> {
  List<Trip> trips = [
    Trip(
      city: "Paris",
      activities: [],
      date: DateTime.now().add(
        const Duration(days: 1),
      ),
    ),
    Trip(
      city: "Lyon",
      activities: [],
      date: DateTime.now().add(
        const Duration(days: 2),
      ),
    ),
    Trip(
      city: "Nice",
      activities: [],
      date: DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
  ];
  void addTrip(Trip trip) {
    setState(() {
      trips.add((trip));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(
              cities: widget.cities,
            ),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CityView.routeName:
            {
              return MaterialPageRoute(
                builder: ((context) {
                  final City city = settings.arguments as City;
                  return CityView(
                    city: city,
                    addTrip: addTrip,
                  );
                }),
              );
            }
          case TripsView.routeName:
            {
              return MaterialPageRoute(builder: ((context) {
                return TripsView(
                  trips: trips,
                );
              }));
            }
        }

        return null;
      },
    );
  }
}
