import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import '../../keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/locationData.dart';
class LocationInput extends StatefulWidget {
  final product;
  LocationInput(this.product);
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapImage;
  final TextEditingController _addressInputController = TextEditingController();
  final _focusNode = FocusNode();
  LocationData _locationData;

  initState() {
    // getStaticMapImage();
    _addressInputController.addListener(_updateMapImage);
    super.initState();
  }

  build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _focusNode,
          controller: _addressInputController,
          decoration: InputDecoration(labelText: 'Product Location'),
          // initialValue: window.product != null ? productTitle : '',
          validator: (String value) {
            if (value.trim() == '') {
              return "Enter the Address, dum dum!";
            }
          },
          onSaved: (String inputValue) {
            // _formData['title'] = inputValue;
          },
        ),
        SizedBox(
          height: 10,
        ),
        _staticMapImage != null ? Image.network(_staticMapImage.toString()) : Container(),
      ],
    );
  }


  _updateMapImage(){
    if(_focusNode.hasFocus){
      return false;
    }
    getStaticMapImage(_addressInputController.text.trim());
  }

   getStaticMapImage(addressInput) async {
    
    //get location from address text with geo coding api
    if(addressInput == null || addressInput == ''){
      return false;
    }
    final Uri geoCodingUri = Uri.https('maps.googleapis.com','/maps/api/geocode/json',{"address":addressInput,'key':mapsApiKey});

    final http.Response response = await http.get(geoCodingUri);
    if(response ==  null || (response.statusCode != 200 && response.statusCode != 201)){
      return false;
    }
    final decodedResponse = jsonDecode(response.body);
    final formattedAddress =
          decodedResponse['results'][0]['formatted_address'];
      final coords = decodedResponse['results'][0]['geometry']['location'];
    _locationData = LocationData(formattedAddress,coords['lat'],coords['lng']);

    final StaticMapProvider staticMapViewProvider =
        StaticMapProvider(mapsApiKey);
    final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
        [Marker('position', 'Come Here!', _locationData.latitude,_locationData.longitude)],
        center: Location(_locationData.latitude,_locationData.longitude),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _staticMapImage = staticMapUri;
    });
  }
}
