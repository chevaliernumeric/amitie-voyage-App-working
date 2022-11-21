import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

class TripActivityCard extends StatefulWidget {
  final Activity activity;
  final Function deleteTripActivity;
  const TripActivityCard(
      {super.key, required this.activity, required this.deleteTripActivity});

  @override
  State<TripActivityCard> createState() => _TripActivityCardState();
}

class _TripActivityCardState extends State<TripActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(widget.activity.image),
        ),
        title: Text(widget.activity.name),
        subtitle: Text(widget.activity.city),
        trailing: IconButton(
          onPressed: () {
            widget.deleteTripActivity(widget.activity.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Activité supprimer"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
