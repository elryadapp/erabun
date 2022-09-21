import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // Set<Marker> _markers = {};
  GoogleMapController? googleMapController;

  @override
  void initState() {
    super.initState();
    // _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            titleText: 'اختر العنوان',
          ),
          body: SizedBox.expand(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox.expand(
                  child: GoogleMap(
                    
                      initialCameraPosition:
                          CameraPosition(target: authCubit.latLng!, zoom: 17),
                      zoomGesturesEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      indoorViewEnabled: true,
                      // markers: _markers,
                      onMapCreated: (controller) =>
                          googleMapController = controller),
                ),
                Positioned(
                  top: 60,
                  right: 10,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      color: AppUi.colors.hintColor,
                      icon: Icon(
                        Icons.my_location,
                        color: AppUi.colors.mainColor,
                      ),
                      onPressed: () async {
                        Position currentLocation =
                            await AppUtil.getCurrentLocation(context);

                        googleMapController!.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(currentLocation.latitude,
                                    currentLocation.longitude),
                                zoom: 16)));
                      },
                    ),
                  ),
                ),
                SizedBox.expand(
                  child: Center(
                    child: Icon(
                      Icons.add_location,
                      color: AppUi.colors.mainColor,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EarbunButton(
                        title: 'اختر',
                        color: AppUi.colors.mainColor.withOpacity(.8),
                        width: Constants.getwidth(context) * 0.9,
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          AppUtil.getAddressFromLatLong(
                                  LatLng(authCubit.latLng!.latitude,
                                      authCubit.latLng!.longitude),
                                  context)
                              .then((value) => AppUtil.getAddressFromLatLong(
                                      LatLng(authCubit.latLng!.latitude,
                                          authCubit.latLng!.longitude),
                                      context)
                                  .then((value) => authCubit
                                      .registerLocationController
                                      .text = value));

                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // void _setMarker() async {
  //   Uint8List destinationImageData = await convertAssetToUnit8List(
  //     AppUi.assets.carIcon,
  //     width: 120,
  //   );

  //   _markers = {};
  //   _markers.add(Marker(
  //     markerId: const MarkerId('marker'),
  //     position: AuthCubit.get(context).latLng!,
  //     icon: BitmapDescriptor.fromBytes(destinationImageData),
  //   ));

  //   setState(() {});
  // }

  // Future<Uint8List> convertAssetToUnit8List(String imagePath,
  //     {int width = 50}) async {
  //   ByteData data = await rootBundle.load(imagePath);
  //   Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }
}
