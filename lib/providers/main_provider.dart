import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/val.dart';

class MainProvider with ChangeNotifier{
  String WS_ADRESS = "wss://socket.paratic.com";
  IO.Socket? socket;
  List<Val> vals=[];

  bool _isConnect=false;


  bool get isConnect => _isConnect;

  set isConnect(bool value) {
    _isConnect = value;
    notifyListeners();
  }




  MainProvider(){
    init();
  }

  init(){
   print('init');
   socket = IO.io(WS_ADRESS, IO.OptionBuilder().setTransports(['websocket']).build());
   socket?.onConnect((p){
     isConnect=true;


     socket?.emit('joinStream',{"codes": [
      "XGLD",
      "XGCEYREK",
      "XAU/USD",
      "SG14BIL",
      "SG18BIL",
      "SG22BIL",
      "XHGLD",
      "XGYARIM",
      "XGZIYNET",
      "SCUM",
      "SGATA",
      "SGIKIBUCUK",
      "SGGREMSE",
      "SGBESLI",
      "USGLDKG"
     ]});


     print(['CONNECT', p]);
   });
   socket?.onDisconnect((p){
     isConnect=false;
     print(['DISCONNECT', p]);
   });
   socket?.onError((p) => print(['ERROR', p]));
   socket?.onConnecting((p) => print(['CONNECTING', p]));
   socket?.onConnectError((p) => print(['CONNECT ERROR', p]));
   socket?.onConnectTimeout((p) => print(['TIMEOUT', p]));
   socket?.on('connect_error', (p) => print(['CONNECT ERROR', p]));


   socket?.on('dolar_endeksi', (p){
     print(p);
   });
   socket?.on('euro_endeksi', (p){
     print(p);
   });
   socket?.on('spot_pariteler', (p) {
     print(['spot_pariteler', p]);
     Map<String, dynamic> decodedData = json.decode(p);
     String key = decodedData.keys.first;

     List<String> fields = decodedData[key].split('|');
     bool add=true;
     for(int i=0;i<vals.length;i++){
       if(vals[i].code==key){
         vals[i].v=double.parse(fields[0]);
         add=false;
       }
     }
     if(add){
       vals.add(Val(key,double.parse(fields[0])));
     }
     notifyListeners();


   });


  }

}