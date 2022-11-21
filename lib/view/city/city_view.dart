import 'package:amitie_voyage/view/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../models/city_model.dart';
import '/view/city/widgets/activity_list.dart';
import '/view/city/widgets/trip_overview.dart';
import '../../models/activity_model.dart';
import '../../models/trip_model.dart';
import 'widgets/trip_activity_list.dart';

class CityView extends StatefulWidget {
  static const String routeName = '/city';

  final City city;
  final Function addTrip;
  const CityView({super.key, required this.city, required this.addTrip});

  List<Activity> get activities {
    return city.activities;
  }

  showContext({BuildContext? context, List<Widget>? children}) {
    final orientation = MediaQuery.of(context!).orientation;

    if (orientation == Orientation.landscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children!,
      );
    } else {
      return Column(
        children: children!,
      );
    }
  }

  @override
  State<CityView> createState() => _CityViewState();
}

class _CityViewState extends State<CityView> {
  late Trip mytrip;
  late int index;
  @override
  void initState() {
    index = 0;
    mytrip = Trip(city: "Paris", activities: [], date: null);
    super.initState();
  }

  List<Activity> get tripActivities {
    return widget.activities.where((activity) {
      return mytrip.activities.contains(activity.id);
    }).toList();
  }

  double get amount {
    return mytrip.activities.fold(0.0, (previo, element) {
      var activity =
          widget.activities.firstWhere((activity) => activity.id == element);
      return previo + activity.price;
    });
  }

  void deleteTripActivity(String id) {
    setState(() {
      mytrip.activities.remove(id);
    });
  }

  void toggleActivity(String id) {
    setState(() {
      mytrip.activities.contains(id)
          ? mytrip.activities.remove(id)
          : mytrip.activities.add(id);
    });
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(
        const Duration(days: 1),
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          mytrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void saveTrip() async {
    final result = await showDialog(
      context: context,
      builder: ((context) {
        return SimpleDialog(
          title: const Text("Voulez vous sauvegarder ?"),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'cancel');
                  },
                  child: const Text("Annuler"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, "save");
                  },
                  child: const Text("Sauvegarder"),
                ),
              ],
            ),
          ],
        );
      }),
    );

    if (result == 'save') {
      // ignore: use_build_context_synchronously
      widget.addTrip(mytrip);
      Navigator.pushNamed(context, HomeView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organisation de voyage"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: widget.showContext(
        context: context,
        children: [
          TripOverview(
            mytrip: mytrip,
            setDate: setDate,
            cityName: widget.city.name,
            amount: amount,
          ),
          Expanded(
            child: index == 0
                ? ActivityList(
                    activities: widget.activities,
                    selectedActivities: mytrip.activities,
                    toggleActivity: toggleActivity,
                  )
                : TripActivityList(
                    activities: tripActivities,
                    deleteTripActivity: deleteTripActivity,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: saveTrip, child: const Icon(Icons.forward)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Découverte",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: "Activités",
          ),
        ],
        onTap: switchIndex,
      ),
    );
  }
}
