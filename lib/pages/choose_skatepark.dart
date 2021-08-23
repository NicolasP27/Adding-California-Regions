import 'package:flutter/material.dart';
import 'package:skate_guide_cali_mk5/services/weather.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  bool isSearching = false;

  List<WorldWeather> weatherlocations = [
    WorldWeather(
      city: 'ripon,us',
      skateparkname: 'Curt Pernice Skatepark',
      address: '1250 Hughes Ln Ripon, CA 95366',
      parksize: '30,000 sqft',
      lights: 'no',
      padrequirement: 'helmet required, pads optional',
      skateparkPicture: 'curt_pernice_skatepark.jpg',
      times: 'Monday - Sunday:  Dawn - Dusk',
    ),
    WorldWeather(
      city: 'san+jose,us',
      skateparkname: 'Lake Cunningham Regional Skatepark',
      address: '2305 S White Rd, San Jose CA 95148',
      parksize: '80,000 sqft',
      lights: 'yes',
      padrequirement:
      'helmet required, pads required in certain parts of the park ',
      skateparkPicture: 'lake_cunningham_skatepark.jpg',
      times: 'Monday - Sunday:  8AM - 8PM ',
    ),
    WorldWeather(
      city: 'encinitas,us',
      skateparkname: 'Magdalena Ecke YMCA Skatepark',
      address: '200 Saxony Rd Encinitas, CA 92024',
      parksize: '37,000 sqft',
      lights: 'no',
      padrequirement: 'helmet & pads required',
      skateparkPicture: 'magdalena_ecke_ymca_skatepark.jpg',
      times: 'Monday - Friday:  3PM - 7:30PM\nSaturday - Sunday:  9AM - 5PM ',
    ),

    WorldWeather(city: 'culver+city,us',
        skateparkname: 'Stoner Skatepark',
        address: '1835 Stoner Ave #1801, Los Angeles, CA 90025',
        parksize: '26,500 sqft',
        lights: 'no',
        padrequirement: 'none',
        times: 'Monday - Sunday:  10AM - 7PM',
        skateparkPicture: 'stoner_skatepark.jpg'
    ),
    WorldWeather(
      city: 'sacramento,us',
      skateparkname: 'Tanzanite Skatepark ',
      address: '2220 Tanzanite Avenue, Sacramento, CA 95834',
      parksize: '16,000 sqft',
      lights: 'no',
      padrequirement: 'helmet & pads required',
      skateparkPicture: 'tanzanite_skatepark.jpg',
      times: 'Monday - Sunday:  8AM - 9PM',
    ),
    WorldWeather(
      city: 'santa+monica,us',
      skateparkname: 'The Cove Skatepark',
      address: '1401 Olympic Blvd, Santa Monica, CA 90404',
      parksize: '20,000 sqft',
      lights: 'yes',
      padrequirement: 'helmet & pads required',
      skateparkPicture: 'the_cove_skatepark.jpg',
      times:
      'Monday - Friday:  1PM - 8PM\nSaturday:  12PM - 6PM\nSunday:  12PM - 7PM',
    ),
    WorldWeather(
      city: 'huntington+beach,us',
      skateparkname: 'Vans "Off The Wall" Skatepark',
      address: '7471 Center Ave, Huntington Beach, CA 92647',
      parksize: '35,000 sqft',
      lights: 'yes',
      padrequirement: 'helmet & pads required',
      skateparkPicture: 'vens_off_the_wall_skatepark.jpg',
      times: 'TEMPORARILY CLOSED',
    ),
    WorldWeather(
      city: 'orange+county',
      skateparkname: 'Vans Skatepark',
      address: '20 City Blvd W Suite 2, Orange, CA 92868',
      parksize: '20,000 sqft',
      lights: 'yes',
      padrequirement:
      'helmet & pads required (unless 18 or over, only helmet required)',
      skateparkPicture: 'vans_orange_county_skatepark.jpg',
      times:
      'Monday - Thursday:  11AM - 7PM\nFriday - Saturday:  10AM - 8PM\nSunday:  12PM - 6PM',
    ),
    WorldWeather(
      city: 'venice,us',
      skateparkname: 'Venice Beach Skatepark',
      address: '1800 Ocean Front Walk, Venice CA 90291',
      parksize: '16,000 sqft',
      lights: 'no',
      padrequirement: 'none',
      skateparkPicture: 'venice_beach_skatepark.jpg',
      times: 'Monday - Sunday:  Dawn - Dusk',
    )
  ];
  List<WorldWeather> filteredSkateParks = [];

  void updateWeather(index) async {
    WorldWeather instance = filteredSkateParks[index];
    await instance.getWeather();
    //navigate to home screen
    Navigator.pushReplacementNamed(context, '/home', arguments:  {
      'location': instance.skateparkname,
      'skateparkPicture': instance.skateparkPicture,
      'weather': instance.weather,
      'address': instance.address,
      'parksize': instance.parksize,
      'lights': instance.lights,
      'padrequirement': instance.padrequirement,
      'times': instance.times,
    });
  }

  @override
  void initState() {
    super.initState();
    filteredSkateParks = weatherlocations;
  }

  void _filterSkateParks(value) {
    filteredSkateParks = weatherlocations
        .where((WorldWeather weatherData) =>
        weatherData.skateparkname!.contains(value))
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
            ? const Text('Choose a Skatepark')
            : TextField(
          onChanged: (value) {
            _filterSkateParks(value);
          },
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search Skatepark Here",
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
        itemCount: filteredSkateParks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateWeather(index);
                },
                title: Text(filteredSkateParks[index].skateparkname.toString()),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/${filteredSkateParks[index].skateparkPicture}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


