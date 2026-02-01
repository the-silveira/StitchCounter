import 'package:flutter/material.dart';
import 'package:stitchcounter/controller/counterController.dart';
import 'package:stitchcounter/models/project.dart';

import 'package:stitchcounter/widgets/roundCounterWidget.dart';
import 'package:stitchcounter/widgets/stitchCounterWidget.dart';

class MainScreen extends StatefulWidget {
  final Project project;
  
  const MainScreen({super.key, required this.project});
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late CounterController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = CounterController(project: widget.project);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              _controller.project.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.eco,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 24,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _controller.goToProjects(context),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Row(
            children: [
              Expanded(
                child: StitchCounterWidget(
                  counter: _controller.project.stitch,
                  onIncrement:  _controller.incrementStitch,
                  onReset:  _controller.resetStitch,
                  onDecrease: _controller.decreaseStitch,
                ),
              ),
              Container(width: 1, color: Colors.grey[300]),
              Expanded(
                child: RoundCounterWidget(
                  counter: _controller.project.round,
                  onIncrement: _controller.incrementRound,
                  onReset: _controller.resetRound,
                  onDecrease: _controller.decreaseRound,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: 
          FloatingActionButton(
            onPressed: _controller.resetAll,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            foregroundColor: Theme.of(context).colorScheme.primary,
            heroTag: 'reset',
            child: const Icon(Icons.refresh),
          ),
        
      
    );
  }
}