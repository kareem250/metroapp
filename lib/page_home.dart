import 'package:app_v2/image_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _TestPageState();
}

//line 1 in metro
var line_1 = [
  'helwan',
  'ain helwan',
  'helwan university',
  'wadi hof',
  'hadayek helwan',
  'el-maasara',
  'tora el-asmant',
  'kozzika',
  'tora el-balad',
  'sakanat el-maadi',
  'maadi',
  'hadayek el-maadi',
  'dar el-salam',
  'el-zahraa',
  'mar girgis',
  'el-malek el-saleh',
  'el-sayeda zeinab',
  'saad zaghloul',
  'sadat',
  'nasser',
  'orabi',
  'al-shohadaa',
  'ghamra',
  'el-demerdash',
  'manshiet el-sadr',
  'kobri el-qobba',
  'hammamat el-qobba',
  'saray el-qobba',
  'hadayek el-zaitoun',
  'helmeyet el-zaitoun',
  'el-matareyya',
  'ain shams',
  'ezbet el-nakhl',
  'el-marg',
  'new el-marg'
];

//line 2 in metro
var line_2 = [
  'shubra el-kheima',
  'kolleyet el-zeraa',
  'mezallat',
  'khalafawy',
  'st. teresa',
  'rod el-farag',
  'masarra',
  'al-shohadaa',
  'attaba',
  'mohamed naguib',
  'sadat',
  'dokki',
  'opera',
  'bohooth',
  'cairo university',
  'faisal',
  'giza',
  'om el-masryeen',
  'sakiat mekky',
  'el-mounib'
];

//line 3 in metro
var line_3 = [
  'adly mansour',
  'el-haykestep',
  'omar ibn el-khattab',
  'qobaa',
  'hesham barakat',
  'el-nozha',
  'nadi el-shams',
  'alf maskan',
  'heliopolis',
  'haroun',
  'al-ahram',
  'kolleyet el-banat',
  'stadium',
  'fair zone',
  'abbassiya',
  'abdou pasha',
  'el-geish',
  'bab el-shaaria',
  'attaba',
  'nasser',
  'maspero',
  'zamalek',
  'kit kat'
];

//this place in right of end line 3 ,you can look in the map and you will find it
var right_3 = [
  'al-sodan',
  'embaba',
  'al-bohe',
  'ah-kwmia',
  'al-daary road',
  'rod al-farag'
];

//this place in right of end line 3 ,you can look in the map and you will find it
var left_3 = [
  'al-twfikia',
  'wady al-nil',
  'al-dwal unevrsty',
  'bolak',
  'cairo university'
];
//first station
final cont = TextEditingController();

//second station
final cont2 = TextEditingController();

//index the first station in list for sublist
var sub_st = 0;

//index the second station in list for sublist
var sub_end = 0;

//the count is result and the road for user
var count = <String>[].obs;

//direction like el-moneb or shobra el-khema
var dir = ''.obs;

//time for the user's trip
var time_s = ''.obs;

//price for the ticket
var ticket = 0.obs;

//it's a line i will sub from him if i have one line in my road
//or if i have multiple lines it's the first line you will sub from it
//how can i decide this line ? you can search about first station in each line
var line_start = <String>[];

//if i have multiple lines it's the end line you will sub from him
//how can i decide this line ? you can search about second station in each line
var line_end = <String>[];
//it's the station concat between two lines
var sta2 = '';
var sta = <String>[];

//the count is result and the road for user if i have multiple lines
var count2 = <String>[].obs;

//this variable for DropdownMenu
var line_All = <String>[];

// location variable
Position? p;
//p!.latitude
var pt = 0.0;
//p!.longitude
var pg = 0.0;
GetStorage? file;

class _TestPageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
    if (p == null) {
      return;
    }
    pt = p!.latitude;
    pg = p!.longitude;
    print('${pt} ${pg}');
  }

  @override
  Widget build(BuildContext context) {
    line_All = line_1 + line_2 + line_3 + right_3 + left_3;
    Set<String> line_s = line_All.toSet();
    count.value = [];
    count2.value = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('metro app'),
        backgroundColor: Color(0xFF42A5F5),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 30,
          ),
          DropdownMenu(
            dropdownMenuEntries: [
              for (var value in line_s)
                DropdownMenuEntry(value: value, label: value),
            ],
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            )),
            label: Text(
              'from',
            ),
            width: 350,
            helperText: 'enter start station',
            enableSearch: true,
            enableFilter: true,
            requestFocusOnTap: true,
            controller: cont,
          ),
          IconButton(
              onPressed: () {
                sta2 = cont.text;
                cont.text = cont2.text;
                cont2.text = sta2;
              },
              icon: Image.asset(
                'assets/images/switch2.png',
                width: 20,
                height: 20,
              )),
          SizedBox(
            height: 10,
          ),
          DropdownMenu(
            dropdownMenuEntries: [
              for (var value in line_s)
                DropdownMenuEntry(value: value, label: value),
            ],
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            )),
            label: Text('to'),
            width: 350,
            helperText: 'enter end station',
            enableSearch: true,
            enableFilter: true,
            requestFocusOnTap: true,
            controller: cont2,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            label: Text('culclate'),
            onPressed: () {
              dir.value = '';
              time_s.value = '';
              count.value = [];
              count2.value = [];
              ticket.value = 0;
              line_All = line_1 + line_2 + line_3 + left_3 + right_3;

              //this block for avoid the exception
              if (cont.text == '' || cont2.text == '') {
                time_s.value = 'enter stations';
                return;
              } else if (!line_All.contains(cont.text)) {
                time_s.value = 'start station is wrong';
                return;
              } else if (!line_All.contains(cont2.text)) {
                time_s.value = 'end station is wrong';
                return;
              } else if (cont.text == cont2.text) {
                time_s.value = 'it is a same station';
                return;
              }
              //decide the line
              if (line_1.contains(cont.text)) {
                line_start = line_1;
              } else if (line_2.contains(cont.text)) {
                line_start = line_2;
              } else if (line_3.contains(cont.text)) {
                line_start = line_3;
              } else if (left_3.contains(cont.text)) {
                line_start = line_3;
              } else if (right_3.contains(cont.text)) {
                line_start = line_3;
              }
              if (line_1.contains(cont.text) && line_2.contains(cont.text)) {
                if (line_1.contains(cont2.text)) {
                  line_start = line_1;
                } else if (line_2.contains(cont2.text)) {
                  line_start = line_2;
                }
              } else if (line_2.contains(cont.text) &&
                  line_3.contains(cont.text)) {
                if (line_2.contains(cont2.text)) {
                  line_start = line_2;
                } else if (line_3.contains(cont2.text)) {
                  line_start = line_3;
                }
              } else if (line_1.contains(cont.text) &&
                  line_3.contains(cont.text)) {
                if (line_1.contains(cont2.text)) {
                  line_start = line_1;
                } else if (line_3.contains(cont2.text)) {
                  line_start = line_3;
                }
              }
              line_All = line_3 + right_3 + left_3;
              if (line_All.contains(cont.text) &&
                  line_All.contains(cont2.text)) {
                if (line_3.contains(cont.text) &&
                    right_3.contains(cont2.text)) {
                  line_start = line_3 + right_3;
                } else if (line_3.contains(cont2.text) &&
                    right_3.contains(cont.text)) {
                  right_3 = right_3.reversed.toList();
                  line_start = line_3 + right_3;
                } else if ((line_3.contains(cont2.text) &&
                        line_3.contains(cont.text)) ||
                    (line_3.contains(cont.text) &&
                        left_3.contains(cont2.text))) {
                  line_start = line_3 + left_3;
                } else if (left_3.contains(cont.text) &&
                    right_3.contains(cont2.text)) {
                  left_3 = left_3.reversed.toList();
                  if (!right_3.contains('kit kat') &&
                      !left_3.contains('kit kat')) {
                    left_3.add('kit kat');
                  }
                  line_start = line_3 + left_3 + right_3;
                } else if (right_3.contains(cont.text) &&
                    left_3.contains(cont2.text)) {
                  right_3 = right_3.reversed.toList();
                  if (!right_3.contains('kit kat') &&
                      !left_3.contains('kit kat')) {
                    right_3.add('kit kat');
                  }
                  line_start = line_3 + right_3 + left_3;
                }
              } else if (line_All.contains(cont.text)) {
                if (left_3.contains(cont.text)) {
                  if (!right_3.contains('kit kat') &&
                      !left_3.contains('kit kat')) {
                    left_3.add('kit kat');
                  }
                  line_start = line_3 + left_3 + right_3;
                } else if (right_3.contains(cont.text)) {
                  if (!right_3.contains('kit kat') &&
                      !left_3.contains('kit kat')) {
                    right_3.add('kit kat');
                  }
                  line_start = line_3 + right_3 + left_3;
                }
                if (left_3.contains(cont.text) && left_3.contains(cont2.text)) {
                  line_start = left_3;
                } else if (left_3.contains(cont.text) &&
                    left_3.contains(cont2.text)) {
                  line_start = right_3;
                }
              }
              //this block for sub the list and Generat the road
              if (line_start.contains(cont.text) &&
                  line_start.contains(cont2.text)) {
                sub_st = line_start.indexOf(cont.text);
                sub_end = line_start.indexOf(cont2.text);
                if (sub_st < sub_end) {
                  count.value = line_start.sublist(sub_st, sub_end + 1);
                  dir.value = line_start[line_start.length - 1];
                } else {
                  count.value = line_start.sublist(sub_end, sub_st + 1);
                  count.value = count.reversed.toList();
                  dir.value = 'dir = ${line_start[0]}';
                }
              } else {
                if (line_1.contains(cont2.text)) {
                  line_end = line_1;
                } else if (line_2.contains(cont2.text)) {
                  line_end = line_2;
                } else {
                  line_end = line_3;
                }
                sta = [
                  'sadat',
                  'cairo university',
                  'attaba',
                  'al-shohadaa',
                  'nasser'
                ];
                sta.shuffle();
                for (int i = 0; i < sta.length; i++) {
                  if (line_start.contains(sta[i]) &&
                      line_end.contains(sta[i])) {
                    sta2 = sta[i];
                    sta[i] = '';
                    break;
                  } else {
                    sta2 = '';
                  }
                }
                if (right_3.contains(cont2.text)) {
                  left_3 = left_3.reversed.toList();
                  line_end = line_3 + left_3 + right_3;
                } else if (right_3.contains(sta2) &&
                    left_3.contains(cont2.text)) {
                  line_end = line_3 + right_3 + left_3;
                }
                sub_st = line_start.indexOf(cont.text);
                sub_end = line_start.indexOf(sta2);
                if (sub_st < sub_end) {
                  count.value = line_start.sublist(sub_st, sub_end);
                  sub_st = line_end.indexOf(sta2);
                  sub_end = line_end.indexOf(cont2.text);
                  if (sub_end > sub_st) {
                    count2.value = line_end.sublist(sub_st, sub_end + 1);
                    dir.value = line_end[line_end.length - 1];
                  } else {
                    count2.value = line_end.sublist(sub_end, sub_st);
                    count2.value = count2.reversed.toList();
                    dir.value = line_end[0];
                  }
                } else {
                  count.value = line_start.sublist(sub_end, sub_st + 1);
                  count.value = count.reversed.toList();
                  sub_st = line_end.indexOf(sta2);
                  sub_end = line_end.indexOf(cont2.text);
                  if (sub_end > sub_st) {
                    count2.value = line_end.sublist(sub_st, sub_end);
                    dir.value = line_end[line_end.length - 1];
                  } else {
                    count2.value = line_end.sublist(sub_end, sub_st + 1);
                    count2.value = count2.reversed.toList();
                    dir.value = line_end[0];
                  }
                }
              }
              if (count.isNotEmpty) {
                sub_st = count.length + count2.length;
                sub_st = sub_st;
                if (sub_st * 2 >= 60) {
                  time_s.value = ' 1 hour ${sub_st * 2 - 60}';
                } else {
                  time_s.value = 'time = ${sub_st * 2} min';
                }
                if (sub_st <= 9) {
                  ticket.value = 8;
                } else if (sub_st <= 17) {
                  ticket.value = 10;
                } else {
                  ticket.value = 15;
                }
              }
            },
            icon: Icon(Icons.search),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() {
            if (count.isEmpty) {
              return Text(
                '$time_s',
                style: TextStyle(
                  color: Colors.red,
                ),
              );
            } else {
              return SizedBox();
            }
          }),
          Row(children: [
            SizedBox(
              width: 50,
            ),
            Column(children: [
              Obx(() {
                if (count.isNotEmpty) {
                  return Text('count = ${sub_st}');
                } else {
                  return SizedBox();
                }
              }),
              Obx(() {
                if (count.isNotEmpty) {
                  return Text('$time_s');
                } else {
                  return SizedBox();
                }
              }),
            ]),
            SizedBox(
              width: 50,
            ),
            Column(children: [
              Obx(() {
                if (count.isNotEmpty) {
                  return Text('dir = $dir');
                } else {
                  return SizedBox();
                }
              }),
              Obx(() {
                if (count.isNotEmpty) {
                  return Text('ticket = $ticket');
                } else {
                  return SizedBox();
                }
              }),
            ]),
          ]),
          Expanded(
            child: Row(children: [
              Expanded(child: Obx(() {
                if (count.isNotEmpty) {
                  return SizedBox(
                    width: 100,
                    child: ListView(
                      children: [for (var value in count) Text('$value \n')],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              })),
              Expanded(child: Obx(() {
                if (count.isNotEmpty) {
                  return SizedBox(
                    width: 100,
                    child: ListView(
                      children: [
                        for (var value in count2)
                          Text(
                            '$value \n',
                          )
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              })),
            ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {
                Get.to(Images());
              },
              icon: Icon(Icons.map),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ]),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.snackbar('error', 'Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Get.snackbar('error', 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.snackbar('error',
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    p = await Geolocator.getCurrentPosition();
  }
}
