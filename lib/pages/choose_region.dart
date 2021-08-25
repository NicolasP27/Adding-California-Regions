import 'package:flutter/material.dart';
import 'package:skate_guide_cali_mk5/services/weather.dart';

class ChooseRegion extends StatefulWidget {
  @override
  _ChooseRegionState createState() => _ChooseRegionState();
}

class _ChooseRegionState extends State<ChooseRegion> {
  bool isSearching = false;

  List<String> regions = ['A', 'B', 'C'];
  List<String> filteredRegions = [];

  @override
  void initState() {
    print("Region init");
    super.initState();
    filteredRegions = regions;
  }

  void _filterRegions(value) {
    filteredRegions = regions
        .where((String region) =>
            region.toLowerCase().contains(value.toString().toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: !isSearching
            ? const Text('Choose a Region')
            : TextField(
                onChanged: (value) {
                  _filterRegions(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Region Here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        centerTitle: true,
        elevation: 0,
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredRegions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/location',
                      arguments: {'region': filteredRegions[index]});
                },
                title: Text(filteredRegions[index]),
                // leading: CircleAvatar(
                //   backgroundImage: AssetImage(
                //       'assets/${filteredRegions[index].skateparkPicture}'),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
