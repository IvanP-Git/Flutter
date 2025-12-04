import 'package:flutter/material.dart';
import 'driver_model.dart';
import 'driver_detail_page.dart';

class DriverCard extends StatefulWidget {
  final Driver driver;
  const DriverCard(this.driver, {super.key});

  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _fade = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

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

  @override
  Widget build(BuildContext context) {
    final driver = widget.driver;
    final logoUrl = driver.teamLogo;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: InkWell(
          hoverColor: Colors.green,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DriverDetailPage(driver)),
            );
            if (mounted) 
            {
              setState(() {});
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 72,
                      height: 72,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: logoUrl != null
                          ? Image.network(
                              logoUrl,
                              fit: BoxFit.contain,
                              width: 72,
                              height: 72,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.flag, size: 32),
                            )
                          : const Icon(Icons.flag, size: 32),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(driver.name, style: const TextStyle(fontSize: 18)),
                        Text("Team: ${driver.teamPrincName}"),
                        Text("Number: ${driver.number ?? '-'}"),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16),
                            const SizedBox(width: 6),
                            Text("${driver.rating}/10.0"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}