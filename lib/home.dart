import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  String? currentTemperature;

  String? clouds;
  bool expand = false;

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).defaultLocation();
  }

  @override
  Widget build(BuildContext context) {
    List Location = [
      'Kottayam',
      'Ernakulam',
      'Idukki',
      'Alappuzha',
      'Kozhikode',
      'Kannur',
      'Kasaragod',
      'Thrissur',
      'Pathanamthitta',
      'Malappuram',
      'Wayanad',
      'Thiruvananthapuram'
    ];

    return Scaffold(
        appBar: AppBar(

          title: expand? null: const Text('Weather Now',
          style: TextStyle(fontSize: 25, letterSpacing: 4.5)),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(219, 138, 157, 1),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: expand ? MediaQuery.of(context).size.width : 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 100),
                child: expand? TextField(

                  onSubmitted: (newloc) {
                    Provider.of<WeatherProvider>(context, listen: false).updateLocation(newloc);

                    expand = false;
                  },
                  style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 2,
                  color: Colors.white),
                  decoration: InputDecoration(
                  hintText: expand ? 'seach place' : null,
                  hintStyle: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 5,
                  color: Colors.white),
                  border: InputBorder.none)): null,
              ),
            ),
          ),
          actions: [
            Padding(

              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    expand = !expand;
                  });
                },
            icon: Icon(expand ? Icons.close : Icons.search)))
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.fill)
            ),
            child: ListView.builder(
                itemCount: Location.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {   
                    Provider.of<WeatherProvider>(context, listen: false).updateLocation(Location[index]);
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      title: Text(
                      Location[index],
                      style: TextStyle(color: Colors.grey.shade800, fontSize: 18)),
                    )
                  );
                }),
          ),
        ),
        body: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
          String currentTemperature =
          weatherProvider.currentTemperature.toString();
          String currentPlace = weatherProvider.currentPlace.toString();
          String weatherdes = weatherProvider.weatherdes.toString();
          String? iconname = weatherProvider.iconname;
          return Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.fill)),
            ),
            Positioned(
                top: 40,
                left: 20,
                right: 0,
                child: Text(
                  currentTemperature.toString() + String.fromCharCode(0x00B0),
                  style: const TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)
                )),
            Positioned(
                top: 162,
                left: 15,
                child: Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.now()).toString(),
                    style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                )
              ),
            Positioned(
              top: 190,
              left: 18,
              child: Text(currentPlace,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              )
            ),
            Positioned(
                top: 260,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 100,
                  width: 300,
                  child: Text(weatherdes.toUpperCase(),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 25,
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              )
            ]
          );
        }
      )
    );
  }
}
