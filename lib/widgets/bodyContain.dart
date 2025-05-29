import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MybodyContain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [DestinationSection(), ResumSection()]),
      ),
    );
  }
}

class DestinationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column (children: [ 
                    const TextField(
                    decoration: InputDecoration(
                      hintText: 'Votre position',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                  ]
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(255, 122, 222, 233),
                    padding: const EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  child: const Icon(Icons.search, size: 26),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}


class ResumSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 1500, color: Colors.red);
  }
}
