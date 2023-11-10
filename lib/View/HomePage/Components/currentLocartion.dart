import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class CLocationLayer extends StatelessWidget {
  const CLocationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return CurrentLocationLayer(
      followOnLocationUpdate: FollowOnLocationUpdate.once,
      turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
      style: const LocationMarkerStyle(
        marker: DefaultLocationMarker(
          child: Icon(
            Icons.navigation,
            color: Colors.white,
          ),
        ),
        markerSize: const Size(30, 30),
        markerDirection: MarkerDirection.heading,
      ),
    );
  }
}
