import 'package:flutter/material.dart';
import 'driver_model.dart';
import 'driver_card.dart';

class DriverList extends StatelessWidget {
  final List<Driver> drivers;
  const DriverList(this.drivers, {super.key});

  @override
  Widget build(BuildContext context) {
    
    if (drivers.isEmpty) 
    {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: drivers.length,
      itemBuilder: (context, index) => DriverCard(drivers[index]),
    );
  }
}