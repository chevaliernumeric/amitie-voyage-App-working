import 'package:amitie_voyage/view/city/widgets/trip_activity_card.dart';
import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

class TripActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function deleteTripActivity;
  const TripActivityList(
      {super.key, required this.activities, required this.deleteTripActivity});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        var activity = activities[index];
        return TripActivityCard(
          key: ValueKey(activity.id),
          activity: activity,
          deleteTripActivity: deleteTripActivity,
        );
      }),
      itemCount: activities.length,
    );
  }
}
