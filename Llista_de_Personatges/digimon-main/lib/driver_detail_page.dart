import 'package:flutter/material.dart';
import 'driver_model.dart';

class DriverDetailPage extends StatefulWidget {
  final Driver driver;
  const DriverDetailPage(this.driver, {super.key});

  @override
  _DriverDetailPageState createState() => _DriverDetailPageState();
}

class _DriverDetailPageState extends State<DriverDetailPage> with SingleTickerProviderStateMixin {
  late double _sliderValue;
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(begin: const Offset(0, -0.6), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _sliderValue = widget.driver.rating.toDouble();

    if (widget.driver.teamId == null || widget.driver.number == null) 
    {
      widget.driver.getDriverData().then((_) {

        if (mounted) 
        {
          setState(() {});
        }

      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void submitRating() {
    setState(() {
      widget.driver.rating = _sliderValue;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Updated Rating')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logo = widget.driver.teamLogo;
    return Scaffold(
      appBar: AppBar(title: Text(widget.driver.name)),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 180,
                    height: 180,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: logo != null
                        ? Image.network(
                            logo,
                            width: 180,
                            height: 180,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.flag, size: 64),
                          )
                        : const Icon(Icons.flag, size: 64),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(widget.driver.name,
                    style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(height: 8),
              Center(child: Text("Team: ${widget.driver.teamPrincName}")),
              const SizedBox(height: 4),
              Center(child: Text("Number: ${widget.driver.number ?? '-'}")),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              const Text("Rate this driver", style: TextStyle(fontSize: 18)),
              Slider(
                min: 0,
                max: 10,
                divisions: 20,
                value: _sliderValue,
                onChanged: (v) => setState(() => _sliderValue = v),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Value: ${_sliderValue.toStringAsFixed(1)}"),
                  ElevatedButton(
                    onPressed: submitRating,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}