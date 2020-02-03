import 'package:cabofind/paginas/empresa_detalle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:location/location.dart' as LocationManager;
import 'package:location/location.dart';
import 'package:permission/permission.dart';
import 'package:url_launcher/url_launcher.dart';


import 'classes.dart';

//void main() => runApp(Maps());



class Rutas extends StatefulWidget {
  Rutas({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Rutas> {
  
  final Set<Polyline> polyline = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.900890, -109.942955),
    zoom: 13.0,
  );
  List data;
  String _mapStyle;

  Iterable markers = [];
  Iterable markers1 = [];
 Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;
//List<LatLng> routeCoords ;

 List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyA152PLBZLFqFlUMKQhMce3Z18OMGhPY6w");

   getaddressPoints() async {
    routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          //origin:  LatLng(22.897566, -109.903372),
          //destination: LatLng(22.903496, -109.891055),
          origin: LatLng(23.15693, -109.70918),
          //destination: LatLng(23.136895, -109.710269),
          destination: LatLng(23.159204, -109.711573),
         
          mode: RouteMode.driving);
          print(routeCoords);

  }

  _onMapCreated(GoogleMapController controller) {_controller.complete(controller);
    if (mounted)
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);    

          polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: [
          LatLng(23.16234, -109.71437), LatLng(23.16254, -109.71454), LatLng(23.16306, -109.71493), LatLng(23.1634, -109.71513), LatLng(23.16372, -109.71522), LatLng(23.16386, -109.71535), LatLng(23.16392, -109.71543), LatLng(23.16396, -109.71552), LatLng(23.16397, -109.71569),          LatLng(23.16397, -109.71562), LatLng(23.16395, -109.71579), LatLng(23.16392, -109.71591), LatLng(23.16373, -109.71627), LatLng(23.16358, -109.71641), LatLng(23.16346, -109.71647), LatLng(23.16334, -109.7165), LatLng(23.16144, -109.71627), LatLng(23.16129, -109.71624), LatLng(23.16119, -109.71619), LatLng(23.16113, -109.7161), LatLng(23.1611, -109.71596), LatLng(23.16113, -109.71577), LatLng(23.1612, -109.71565), LatLng(23.16131, -109.71559), LatLng(23.16142, -109.71558), LatLng(23.1626, -109.71572), LatLng(23.16269, -109.71566), LatLng(23.16282, -109.71557), LatLng(23.1629, -109.7154), LatLng(23.16296, -109.71527), LatLng(23.16231, -109.71435), LatLng(23.16042, -109.71267), LatLng(23.15905, -109.71143), LatLng(23.15894, -109.71134), LatLng(23.15876, -109.71126), LatLng(23.15849, -109.71099), LatLng(23.15746, -109.71011), LatLng(23.15719, -109.70989), LatLng(23.15707, -109.70978), LatLng(23.15632, -109.70888), LatLng(23.1561, -109.70869), LatLng(23.15596, -109.70862), LatLng(23.1558, -109.70857),
          LatLng(23.15576, -109.70856), LatLng(23.15543, -109.70853), LatLng(23.15515, -109.70853), LatLng(23.15498, -109.70848), LatLng(23.15254, -109.70873), LatLng(23.14998, -109.70898), LatLng(23.14568, -109.7094), LatLng(23.14191, -109.70977), LatLng(23.13782, -109.71018), LatLng(23.1375, -109.71018), LatLng(23.13658, -109.71028), LatLng(23.13363, -109.71057), LatLng(23.13123, -109.71082), LatLng(23.12936, -109.71099), LatLng(23.12774, -109.71115), LatLng(23.12717, -109.71123), LatLng(23.12621, -109.71132), LatLng(23.12533, -109.71139), LatLng(23.12203, -109.7117), LatLng(23.12133, -109.71173), LatLng(23.12089, -109.71183), LatLng(23.12071, -109.7118), LatLng(23.12008, -109.71186), LatLng(23.11914, -109.71194), LatLng(23.11827, -109.71207), LatLng(23.11817, -109.71204), LatLng(23.11786, -109.71212), LatLng(23.11735, -109.71211), LatLng(23.11527, -109.71237), LatLng(23.11472, -109.71241), LatLng(23.11379, -109.7125), LatLng(23.11304, -109.71257), LatLng(23.11079, -109.71278), LatLng(23.10964, -109.71291),
          LatLng(23.10965, -109.71291), LatLng(23.10907, -109.71292), LatLng(23.10824, -109.71273), LatLng(23.10708, -109.71246), LatLng(23.10621, -109.7122), LatLng(23.105, -109.71191), LatLng(23.10436, -109.71175), LatLng(23.10381, -109.71161), LatLng(23.103, -109.71145), LatLng(23.10142, -109.71109), LatLng(23.1005, -109.71086), LatLng(23.09676, -109.70994), LatLng(23.09503, -109.70951), LatLng(23.0939, -109.70926), LatLng(23.09336, -109.7091), LatLng(23.09297, -109.70898), LatLng(23.09277, -109.70888), LatLng(23.09259, -109.70876), LatLng(23.09211, -109.70837), LatLng(23.09135, -109.70775), LatLng(23.09107, -109.70757), LatLng(23.0907, -109.70742), LatLng(23.09009, -109.70729), LatLng(23.08967, -109.70727), LatLng(23.08933, -109.70728), LatLng(23.08772, -109.70734), LatLng(23.08337, -109.70751),
          LatLng(23.08337, -109.70751), LatLng(23.07903, -109.70764), LatLng(23.07854, -109.70763), LatLng(23.0782, -109.70757), LatLng(23.07797, -109.70749), LatLng(23.07708, -109.70714), LatLng(23.07584, -109.70669), LatLng(23.07412, -109.70602), LatLng(23.07357, -109.70583), LatLng(23.07284, -109.70555), LatLng(23.07249, -109.70543), LatLng(23.07216, -109.70534), LatLng(23.0718, -109.7053), LatLng(23.07095, -109.70526), LatLng(23.07025, -109.70519), LatLng(23.06987, -109.70512), LatLng(23.06932, -109.70497), LatLng(23.0689, -109.70479), LatLng(23.0683, -109.70454), LatLng(23.06776, -109.70429), LatLng(23.06672, -109.70384), LatLng(23.06499, -109.70307), LatLng(23.06431, -109.70276), LatLng(23.06411, -109.7027), LatLng(23.06393, -109.70268), LatLng(23.06362, -109.7027), LatLng(23.06337, -109.70276), LatLng(23.06305, -109.70292), LatLng(23.06273, -109.70317), LatLng(23.06238, -109.70346), LatLng(23.06201, -109.7037), LatLng(23.06176, -109.70384), LatLng(23.06137, -109.70399), LatLng(23.06103, -109.70408),
          LatLng(23.06103, -109.70408), LatLng(23.06018, -109.70412), LatLng(23.05973, -109.70411), LatLng(23.05853, -109.70403), LatLng(23.05462, -109.70375), LatLng(23.05358, -109.70374), LatLng(23.05304, -109.70376), LatLng(23.05265, -109.7038), LatLng(23.05208, -109.70397), LatLng(23.05174, -109.70405), LatLng(23.04955, -109.70463), LatLng(23.04926, -109.70474), LatLng(23.04796, -109.70498), LatLng(23.0462, -109.70548), LatLng(23.04566, -109.70567), LatLng(23.04528, -109.70582), LatLng(23.04504, -109.7059), LatLng(23.04503, -109.70593), LatLng(23.04501, -109.70596), LatLng(23.0449, -109.70604), LatLng(23.04472, -109.70611), LatLng(23.04453, -109.70615), LatLng(23.04425, -109.70615), LatLng(23.04358, -109.70621), LatLng(23.04156, -109.70671), LatLng(23.04056, -109.70696), LatLng(23.04006, -109.70711), LatLng(23.03962, -109.7073), LatLng(23.03918, -109.70753), LatLng(23.03879, -109.70777), LatLng(23.03824, -109.70823), LatLng(23.03793, -109.70852), LatLng(23.03741, -109.70911), LatLng(23.03704, -109.70969),
          LatLng(23.03704, -109.70969), LatLng(23.03654, -109.71043), LatLng(23.03612, -109.71099), LatLng(23.03566, -109.71149), LatLng(23.03524, -109.71188), LatLng(23.03509, -109.71205), LatLng(23.03472, -109.71246), LatLng(23.03413, -109.71298), LatLng(23.03344, -109.7137), LatLng(23.03291, -109.71424), LatLng(23.03261, -109.71449), LatLng(23.03227, -109.71473), LatLng(23.03212, -109.71482), LatLng(23.03091, -109.71533), LatLng(23.03031, -109.71557), LatLng(23.02991, -109.7157), LatLng(23.02879, -109.71605), LatLng(23.02806, -109.71627), LatLng(23.02785, -109.71632), LatLng(23.02771, -109.71634), LatLng(23.02749, -109.71632), LatLng(23.02707, -109.71621), LatLng(23.02667, -109.71608), LatLng(23.02637, -109.71603), LatLng(23.02549, -109.71602), LatLng(23.02518, -109.71603), LatLng(23.02492, -109.71612), LatLng(23.02474, -109.71625), LatLng(23.02463, -109.7164), LatLng(23.0245, -109.71664), LatLng(23.0242, -109.71748), LatLng(23.02407, -109.71774), LatLng(23.0239, -109.71798), LatLng(23.02366, -109.71826),
          LatLng(23.02366, -109.71826), LatLng(23.02336, -109.71851), LatLng(23.02311, -109.71872), LatLng(23.02261, -109.71908), LatLng(23.02223, -109.7193), LatLng(23.02179, -109.71948), LatLng(23.01999, -109.7201), LatLng(23.01942, -109.72037), LatLng(23.019, -109.72066), LatLng(23.0185, -109.72107), LatLng(23.01765, -109.72193), LatLng(23.01736, -109.72218), LatLng(23.01695, -109.72245), LatLng(23.0168, -109.72254), LatLng(23.01644, -109.72271), LatLng(23.01611, -109.72284), LatLng(23.01579, -109.72292), LatLng(23.01535, -109.72299), LatLng(23.01487, -109.72301), LatLng(23.01362, -109.72302), LatLng(23.01306, -109.72306), LatLng(23.01247, -109.72321), LatLng(23.01223, -109.72331), LatLng(23.01199, -109.72342), LatLng(23.01186, -109.72349), LatLng(23.01166, -109.72357), LatLng(23.01157, -109.72363), LatLng(23.01145, -109.7237), LatLng(23.01105, -109.72404), LatLng(23.01084, -109.72426), LatLng(23.01059, -109.72458), LatLng(23.01039, -109.72485), LatLng(23.0103, -109.72501), LatLng(23.0101, -109.72527),
          LatLng(23.0101, -109.72527), LatLng(23.00941, -109.72656), LatLng(23.00797, -109.72919), LatLng(23.00778, -109.72948), LatLng(23.00771, -109.72956), LatLng(23.00763, -109.72963), LatLng(23.00735, -109.72978), LatLng(23.00699, -109.72988), LatLng(23.00574, -109.73014), LatLng(23.00526, -109.73033), LatLng(23.00481, -109.73057), LatLng(23.00452, -109.73077), LatLng(23.00352, -109.73154), LatLng(23.00283, -109.73212), LatLng(23.00203, -109.73287), LatLng(23.00082, -109.73401), LatLng(22.99938, -109.73525), LatLng(22.99899, -109.73561), LatLng(22.99849, -109.73608), LatLng(22.99819, -109.73632), LatLng(22.99696, -109.73714), LatLng(22.9965, -109.73744), LatLng(22.99581, -109.73792), LatLng(22.99548, -109.73822), LatLng(22.99523, -109.73852), LatLng(22.99476, -109.73911), LatLng(22.99392, -109.74016), LatLng(22.99338, -109.74088), LatLng(22.99311, -109.74135), LatLng(22.99298, -109.74164), LatLng(22.99287, -109.74189), LatLng(22.99272, -109.74237), LatLng(22.99208, -109.74433), LatLng(22.99179, -109.74522),
          LatLng(22.99179, -109.74522), LatLng(22.99108, -109.74733), LatLng(22.99076, -109.74814), LatLng(22.98981, -109.75039), LatLng(22.98928, -109.75163), LatLng(22.98916, -109.75196), LatLng(22.98878, -109.75314), LatLng(22.98829, -109.75509), LatLng(22.9881, -109.75583), LatLng(22.98799, -109.75617), LatLng(22.98785, -109.75652), LatLng(22.98763, -109.75696), LatLng(22.98691, -109.7581), LatLng(22.98565, -109.76001), LatLng(22.98491, -109.76117), LatLng(22.98314, -109.76395), LatLng(22.98214, -109.76577), LatLng(22.98199, -109.76608), LatLng(22.98163, -109.76696), LatLng(22.98156, -109.76718), LatLng(22.98079, -109.76891), LatLng(22.98005, -109.77073), LatLng(22.97963, -109.77162), LatLng(22.97901, -109.77314), LatLng(22.97808, -109.77537), LatLng(22.97783, -109.77591), LatLng(22.97682, -109.77778), LatLng(22.97536, -109.7804), LatLng(22.97475, -109.78149), LatLng(22.9722, -109.78606), LatLng(22.97041, -109.78924), LatLng(22.96907, -109.79162), LatLng(22.96773, -109.79406), LatLng(22.96679, -109.79585),
          LatLng(22.96679, -109.79585), LatLng(22.96612, -109.7972), LatLng(22.96531, -109.79876), LatLng(22.9651, -109.79917), LatLng(22.96466, -109.79986), LatLng(22.96421, -109.80044), LatLng(22.964, -109.80066), LatLng(22.96262, -109.80195), LatLng(22.96041, -109.80396), LatLng(22.95961, -109.80467), LatLng(22.95795, -109.80617), LatLng(22.95644, -109.80758), LatLng(22.9543, -109.80959), LatLng(22.95205, -109.81163), LatLng(22.95134, -109.81227), LatLng(22.94985, -109.81363), LatLng(22.94948, -109.81394), LatLng(22.949, -109.81431), LatLng(22.94859, -109.81459), LatLng(22.9482, -109.81482), LatLng(22.94777, -109.81502), LatLng(22.94712, -109.81526), LatLng(22.94655, -109.81542), LatLng(22.94623, -109.81549), LatLng(22.94565, -109.81558), LatLng(22.94456, -109.81563), LatLng(22.94268, -109.81562), LatLng(22.9413, -109.81561), LatLng(22.93976, -109.81559), LatLng(22.93893, -109.81561), LatLng(22.93844, -109.81566), LatLng(22.93785, -109.81578), LatLng(22.93731, -109.81597), LatLng(22.93679, -109.81621),
          LatLng(22.93679, -109.81621), LatLng(22.93459, -109.8175), LatLng(22.93305, -109.81844), LatLng(22.93252, -109.81885), LatLng(22.93225, -109.8191), LatLng(22.93203, -109.81934), LatLng(22.9317, -109.81977), LatLng(22.93105, -109.82068), LatLng(22.92941, -109.82303), LatLng(22.92893, -109.82368), LatLng(22.92836, -109.82451), LatLng(22.92817, -109.82484), LatLng(22.92802, -109.82517), LatLng(22.92779, -109.82578), LatLng(22.92724, -109.82748), LatLng(22.92666, -109.82933), LatLng(22.92635, -109.83029), LatLng(22.92559, -109.83244), LatLng(22.92536, -109.83315), LatLng(22.92516, -109.83384), LatLng(22.92469, -109.83569), LatLng(22.92446, -109.83682), LatLng(22.92425, -109.83799), LatLng(22.92382, -109.84042), LatLng(22.92349, -109.84237), LatLng(22.92326, -109.84358), LatLng(22.92318, -109.84403), LatLng(22.92303, -109.84469), LatLng(22.92279, -109.84537), LatLng(22.92266, -109.84565), LatLng(22.92234, -109.84619), LatLng(22.92194, -109.84665), LatLng(22.92155, -109.847), LatLng(22.92123, -109.84724),
          LatLng(22.92123, -109.84724), LatLng(22.9207, -109.84755), LatLng(22.92011, -109.84779), LatLng(22.91972, -109.84789), LatLng(22.91717, -109.84818), LatLng(22.91532, -109.84838), LatLng(22.91458, -109.84846), LatLng(22.91428, -109.84851), LatLng(22.91385, -109.84862), LatLng(22.91353, -109.84874), LatLng(22.91311, -109.84895), LatLng(22.91273, -109.84917), LatLng(22.91236, -109.84945), LatLng(22.91212, -109.84967), LatLng(22.91182, -109.84998), LatLng(22.91158, -109.85028), LatLng(22.91133, -109.85067), LatLng(22.91118, -109.85094), LatLng(22.91094, -109.85151), LatLng(22.9103, -109.85379), LatLng(22.90984, -109.85547), LatLng(22.90964, -109.85621), LatLng(22.90863, -109.85992), LatLng(22.90816, -109.86174), LatLng(22.90778, -109.86313), LatLng(22.90732, -109.86476), LatLng(22.90655, -109.86762), LatLng(22.90533, -109.87208), LatLng(22.9045, -109.8752), LatLng(22.90299, -109.88078), LatLng(22.90287, -109.88127), LatLng(22.90275, -109.88195), LatLng(22.90273, -109.88244), LatLng(22.90275, -109.88286),
          //LatLng(22.90275, -109.88286), LatLng(22.90328, -109.8877), LatLng(22.90364, -109.89078), LatLng(22.90366, -109.89118), LatLng(22.90364, -109.89157), LatLng(22.9036, -109.89194), LatLng(22.90352, -109.89234), LatLng(22.90336, -109.89277), LatLng(22.90306, -109.89341), LatLng(22.90273, -109.89398), LatLng(22.89859, -109.90137), LatLng(22.89772, -109.90292), LatLng(22.89671, -109.90477), LatLng(22.89638, -109.90525), LatLng(22.8961, -109.90554), LatLng(22.89566, -109.90596), LatLng(22.89525, -109.90627), LatLng(22.89475, -109.90661), LatLng(22.8936, -109.90737), LatLng(22.89286, -109.90783), LatLng(22.89216, -109.9083), LatLng(22.89094, -109.90908), LatLng(22.89027, -109.90954), LatLng(22.88968, -109.90993), LatLng(22.88935, -109.91015), LatLng(22.88933, -109.91024), LatLng(22.88918, -109.91047),
          LatLng(22.90275, -109.88286), LatLng(22.90328, -109.8877), LatLng(22.90364, -109.89078), LatLng(22.90366, -109.89118), LatLng(22.90364, -109.89157), LatLng(22.9036, -109.89194), LatLng(22.90352, -109.89234), LatLng(22.90336, -109.89277), LatLng(22.90306, -109.89341), LatLng(22.90273, -109.89398), LatLng(22.89859, -109.90137), LatLng(22.89772, -109.90292), LatLng(22.89671, -109.90477), LatLng(22.89638, -109.90525), LatLng(22.8961, -109.90554), LatLng(22.89566, -109.90596), LatLng(22.89525, -109.90627), LatLng(22.89475, -109.90661), LatLng(22.8936, -109.90737), LatLng(22.89286, -109.90783), LatLng(22.89216, -109.9083), LatLng(22.89094, -109.90908), LatLng(22.89027, -109.90954), LatLng(22.88968, -109.90993), LatLng(22.88935, -109.91015), LatLng(22.88933, -109.91024), LatLng(22.88918, -109.91047), LatLng(22.88876, -109.91111), LatLng(22.88838, -109.91081), LatLng(22.88825, -109.91065), LatLng(22.88843, -109.91053),
          LatLng(22.88843, -109.91053), LatLng(22.88891, -109.91025), LatLng(22.88952, -109.90982), LatLng(22.89026, -109.90933), LatLng(22.89085, -109.90894), LatLng(22.89145, -109.90852), LatLng(22.89201, -109.90817), LatLng(22.89315, -109.90744), LatLng(22.89455, -109.90651), LatLng(22.89493, -109.90628), LatLng(22.89531, -109.90604), LatLng(22.89571, -109.90574), LatLng(22.89594, -109.90555), LatLng(22.89606, -109.90542), LatLng(22.89634, -109.9051), LatLng(22.8965, -109.90486), LatLng(22.8969, -109.90419), LatLng(22.89744, -109.90318), LatLng(22.89813, -109.90197), LatLng(22.89895, -109.90048), LatLng(22.89935, -109.89978), LatLng(22.89992, -109.89878),
          LatLng(22.89992, -109.89878), LatLng(22.90278, -109.89366), LatLng(22.90298, -109.89331), LatLng(22.90313, -109.893), LatLng(22.90332, -109.89257), LatLng(22.90349, -109.89193), LatLng(22.90353, -109.89155), LatLng(22.90355, -109.89112), LatLng(22.90351, -109.89074), LatLng(22.90317, -109.88783), LatLng(22.90294, -109.88566), LatLng(22.90273, -109.8839), LatLng(22.90262, -109.88271), LatLng(22.90262, -109.88233), LatLng(22.90267, -109.88173), LatLng(22.90273, -109.88136), LatLng(22.90285, -109.88089), LatLng(22.90324, -109.87938), LatLng(22.904, -109.8766), LatLng(22.90484, -109.87343), LatLng(22.90548, -109.87109), LatLng(22.90628, -109.86818), LatLng(22.90732, -109.86438), LatLng(22.90779, -109.86257), LatLng(22.90844, -109.86023), LatLng(22.90873, -109.85912), LatLng(22.90937, -109.8568), LatLng(22.90959, -109.856), LatLng(22.91017, -109.8538), LatLng(22.91073, -109.85174), LatLng(22.91097, -109.8511),
          LatLng(22.91097, -109.8511), LatLng(22.91106, -109.85091), LatLng(22.91138, -109.85035), LatLng(22.91158, -109.85007), LatLng(22.91207, -109.84953), LatLng(22.91259, -109.8491), LatLng(22.91303, -109.84884), LatLng(22.9136, -109.84857), LatLng(22.91384, -109.84847), LatLng(22.91407, -109.84842), LatLng(22.91442, -109.84835), LatLng(22.91491, -109.84829), LatLng(22.91729, -109.84803), LatLng(22.91947, -109.8478), LatLng(22.91997, -109.84771), LatLng(22.92061, -109.84749), LatLng(22.92114, -109.8472), LatLng(22.92144, -109.84698), LatLng(22.92194, -109.84651), LatLng(22.92224, -109.84616), LatLng(22.92246, -109.84582), LatLng(22.9228, -109.84511), LatLng(22.92297, -109.84454), LatLng(22.92314, -109.84368), LatLng(22.92389, -109.83934), LatLng(22.92418, -109.83767), LatLng(22.92439, -109.83656), LatLng(22.92459, -109.83559), LatLng(22.92491, -109.83427), LatLng(22.92536, -109.83274), LatLng(22.92575, -109.83163), LatLng(22.92606, -109.8308), LatLng(22.92631, -109.83003), LatLng(22.92677, -109.82857),
          LatLng(22.92677, -109.82857), LatLng(22.92709, -109.82752), LatLng(22.92731, -109.82685), LatLng(22.92757, -109.82603), LatLng(22.92791, -109.8251), LatLng(22.92808, -109.82471), LatLng(22.92822, -109.82446), LatLng(22.92924, -109.82303), LatLng(22.93052, -109.82123), LatLng(22.93172, -109.81957), LatLng(22.93213, -109.81908), LatLng(22.93248, -109.81873), LatLng(22.93315, -109.81823), LatLng(22.93394, -109.81774), LatLng(22.93499, -109.81712), LatLng(22.93633, -109.81631), LatLng(22.93659, -109.81616), LatLng(22.93697, -109.81595), LatLng(22.93729, -109.81581), LatLng(22.93795, -109.81561), LatLng(22.93829, -109.81554), LatLng(22.93885, -109.81548), LatLng(22.93971, -109.81547), LatLng(22.94138, -109.81549), LatLng(22.94342, -109.81549), LatLng(22.94535, -109.8155), LatLng(22.94583, -109.81545), LatLng(22.94623, -109.81539), LatLng(22.94672, -109.81527), LatLng(22.9476, -109.81495), LatLng(22.9484, -109.81456), LatLng(22.94891, -109.81424), LatLng(22.94956, -109.81372), LatLng(22.95165, -109.81184),
          LatLng(22.95165, -109.81184), LatLng(22.95428, -109.80944), LatLng(22.95462, -109.80913), LatLng(22.95866, -109.80532), LatLng(22.95993, -109.80398), LatLng(22.96008, -109.80381), LatLng(22.96083, -109.8029), LatLng(22.96244, -109.80095), LatLng(22.96296, -109.80032), LatLng(22.96327, -109.79996), LatLng(22.96347, -109.79979), LatLng(22.96381, -109.79957), LatLng(22.9646, -109.79911), LatLng(22.96494, -109.79885), LatLng(22.96525, -109.79851), LatLng(22.96543, -109.79824), LatLng(22.96573, -109.79768), LatLng(22.96709, -109.79501), LatLng(22.96779, -109.79369), LatLng(22.96808, -109.79318), LatLng(22.96909, -109.79134), LatLng(22.97118, -109.78758), LatLng(22.97352, -109.78341), LatLng(22.9748, -109.78113), LatLng(22.97646, -109.77815), LatLng(22.9775, -109.77627), LatLng(22.97788, -109.77554), LatLng(22.97886, -109.77318), LatLng(22.97954, -109.77152), LatLng(22.97982, -109.77096), LatLng(22.97994, -109.77072), LatLng(22.98007, -109.77039), LatLng(22.98068, -109.76886), LatLng(22.98084, -109.7685),
          LatLng(22.98084, -109.7685), LatLng(22.98144, -109.76688), LatLng(22.9818, -109.76597), LatLng(22.98224, -109.76513), LatLng(22.98263, -109.76449), LatLng(22.98347, -109.76318), LatLng(22.98553, -109.75998), LatLng(22.98715, -109.75749), LatLng(22.98741, -109.75708), LatLng(22.98774, -109.75644), LatLng(22.98789, -109.75609), LatLng(22.98806, -109.75555), LatLng(22.98865, -109.75317), LatLng(22.98905, -109.75183), LatLng(22.98917, -109.75147), LatLng(22.98955, -109.7505), LatLng(22.99008, -109.74925), LatLng(22.99066, -109.74795), LatLng(22.9909, -109.74738), LatLng(22.99115, -109.74669), LatLng(22.99203, -109.74408), LatLng(22.99248, -109.74269), LatLng(22.99283, -109.74169), LatLng(22.99299, -109.74135), LatLng(22.99332, -109.74079), LatLng(22.99354, -109.74047), LatLng(22.99483, -109.73881), LatLng(22.9953, -109.73822), LatLng(22.9955, -109.73801), LatLng(22.99574, -109.73781), LatLng(22.99624, -109.73746), LatLng(22.99776, -109.73648), LatLng(22.99822, -109.73613), LatLng(22.99891, -109.73551),
          LatLng(22.99891, -109.73551), LatLng(22.99954, -109.73494), LatLng(23.00152, -109.7331), LatLng(23.00207, -109.73254), LatLng(23.00246, -109.73218), LatLng(23.00302, -109.73169), LatLng(23.00378, -109.73113), LatLng(23.00488, -109.73037), LatLng(23.00511, -109.73024), LatLng(23.0054, -109.73012), LatLng(23.00578, -109.73), LatLng(23.00651, -109.72981), LatLng(23.00699, -109.72965), LatLng(23.00729, -109.72951), LatLng(23.00764, -109.72929), LatLng(23.00783, -109.72911), LatLng(23.00798, -109.72892), LatLng(23.00882, -109.72743), LatLng(23.00945, -109.72627), LatLng(23.01008, -109.72507), LatLng(23.0103, -109.72472), LatLng(23.01072, -109.72418), LatLng(23.01106, -109.72387), LatLng(23.01145, -109.72355), LatLng(23.01169, -109.72339), LatLng(23.01205, -109.72319), LatLng(23.01257, -109.72305), LatLng(23.01298, -109.72297), LatLng(23.01342, -109.72293), LatLng(23.01448, -109.7229),
          LatLng(23.01448, -109.7229), LatLng(23.0149, -109.72291), LatLng(23.01537, -109.72287), LatLng(23.0158, -109.72278), LatLng(23.01632, -109.72261), LatLng(23.01655, -109.72251), LatLng(23.01681, -109.72237), LatLng(23.01697, -109.72228), LatLng(23.01728, -109.72207), LatLng(23.01776, -109.72165), LatLng(23.01849, -109.72092), LatLng(23.01891, -109.72055), LatLng(23.01909, -109.72041), LatLng(23.01959, -109.72013), LatLng(23.01998, -109.71995), LatLng(23.02174, -109.71937), LatLng(23.02217, -109.71922), LatLng(23.02259, -109.719), LatLng(23.02291, -109.71879), LatLng(23.02314, -109.71861), LatLng(23.0236, -109.71817), LatLng(23.02393, -109.71774), LatLng(23.02418, -109.71731), LatLng(23.02428, -109.71707), LatLng(23.02446, -109.71654), LatLng(23.02458, -109.71632), LatLng(23.02468, -109.7162), LatLng(23.02481, -109.71608), LatLng(23.02499, -109.716), LatLng(23.02516, -109.71595), LatLng(23.02579, -109.71594),
          LatLng(23.02579, -109.71594), LatLng(23.02635, -109.71594), LatLng(23.02668, -109.716), LatLng(23.02696, -109.71608), LatLng(23.02741, -109.71623), LatLng(23.02767, -109.71626), LatLng(23.02784, -109.71624), LatLng(23.028, -109.71621), LatLng(23.02878, -109.71595), LatLng(23.02943, -109.71575), LatLng(23.03035, -109.71547), LatLng(23.03181, -109.71487), LatLng(23.03205, -109.71475), LatLng(23.03237, -109.71455), LatLng(23.03267, -109.71433), LatLng(23.03293, -109.71408), LatLng(23.0342, -109.71282), LatLng(23.03504, -109.71196), LatLng(23.03567, -109.71136), LatLng(23.03603, -109.71094), LatLng(23.03665, -109.7101), LatLng(23.03735, -109.70905), LatLng(23.03768, -109.70857), LatLng(23.03785, -109.70837), LatLng(23.03816, -109.70807), LatLng(23.03849, -109.70781), LatLng(23.03857, -109.70775), LatLng(23.03898, -109.70748), LatLng(23.03953, -109.70719), LatLng(23.03986, -109.70705), LatLng(23.04018, -109.70693), LatLng(23.04065, -109.7068), LatLng(23.04253, -109.70631), LatLng(23.04339, -109.70606),
          LatLng(23.04339, -109.70606), LatLng(23.04369, -109.70597), LatLng(23.04422, -109.70574), LatLng(23.04463, -109.70559), LatLng(23.04485, -109.70555), LatLng(23.04541, -109.70548), LatLng(23.04568, -109.70543), LatLng(23.04729, -109.70502), LatLng(23.04841, -109.70475), LatLng(23.04864, -109.70467), LatLng(23.0492, -109.70453), LatLng(23.04948, -109.70449), LatLng(23.04981, -109.70442), LatLng(23.05076, -109.70417), LatLng(23.05233, -109.70378), LatLng(23.05257, -109.70374), LatLng(23.05334, -109.70365), LatLng(23.05387, -109.70365), LatLng(23.05476, -109.70368), LatLng(23.05621, -109.70378), LatLng(23.05689, -109.70381), LatLng(23.0572, -109.70386), LatLng(23.05807, -109.70389), LatLng(23.05951, -109.70397), LatLng(23.05988, -109.70399), LatLng(23.06068, -109.704), LatLng(23.06107, -109.70395), LatLng(23.06143, -109.70384), LatLng(23.06171, -109.70374), LatLng(23.06186, -109.70366), LatLng(23.06224, -109.70341), LatLng(23.06294, -109.70282), LatLng(23.06322, -109.70257), LatLng(23.06337, -109.70249),
          LatLng(23.06337, -109.70249), LatLng(23.06382, -109.70243), LatLng(23.06402, -109.7025), LatLng(23.06501, -109.70297), LatLng(23.06729, -109.70395), LatLng(23.06836, -109.70443), LatLng(23.06935, -109.70488), LatLng(23.06962, -109.70497), LatLng(23.06992, -109.70504), LatLng(23.07027, -109.70508), LatLng(23.07214, -109.70523), LatLng(23.0724, -109.70527), LatLng(23.07266, -109.70535), LatLng(23.07395, -109.70583), LatLng(23.07512, -109.70627), LatLng(23.0765, -109.70678), LatLng(23.07718, -109.70705), LatLng(23.07817, -109.70742), LatLng(23.07844, -109.70749), LatLng(23.07863, -109.7075), LatLng(23.07974, -109.70748), LatLng(23.08577, -109.70728), LatLng(23.08716, -109.70722), LatLng(23.08879, -109.70719), LatLng(23.08923, -109.70718), LatLng(23.08975, -109.70715), LatLng(23.09015, -109.70716), LatLng(23.09047, -109.7072), LatLng(23.09087, -109.70732), LatLng(23.09109, -109.70742), LatLng(23.09159, -109.70773), LatLng(23.0918, -109.70791), LatLng(23.09219, -109.70827), LatLng(23.09243, -109.70848),
          LatLng(23.09243, -109.70848), LatLng(23.09269, -109.70867), LatLng(23.09293, -109.7088), LatLng(23.09321, -109.70891), LatLng(23.09357, -109.70901), LatLng(23.09385, -109.70909), LatLng(23.09454, -109.70924), LatLng(23.09582, -109.70956), LatLng(23.09613, -109.70964), LatLng(23.09692, -109.70987), LatLng(23.09776, -109.71005), LatLng(23.09934, -109.71046), LatLng(23.10028, -109.71069), LatLng(23.102, -109.71109), LatLng(23.10311, -109.71133), LatLng(23.10412, -109.71159), LatLng(23.10449, -109.71165), LatLng(23.10528, -109.71185), LatLng(23.10589, -109.71199), LatLng(23.10682, -109.71224), LatLng(23.10892, -109.71275), LatLng(23.10928, -109.71279), LatLng(23.10956, -109.71278), LatLng(23.1098, -109.71274), LatLng(23.11151, -109.7126), LatLng(23.11231, -109.7125), LatLng(23.11412, -109.71233), LatLng(23.11548, -109.71218), LatLng(23.1178, -109.71195), LatLng(23.11793, -109.71192), LatLng(23.11826, -109.71193), LatLng(23.11926, -109.71182), LatLng(23.12007, -109.71172), LatLng(23.12128, -109.71165),
          LatLng(23.12128, -109.71165), LatLng(23.12587, -109.71122), LatLng(23.12714, -109.71109), LatLng(23.12799, -109.71099), LatLng(23.12937, -109.71085), LatLng(23.13078, -109.71073), LatLng(23.13315, -109.71051), LatLng(23.13536, -109.71028), LatLng(23.13975, -109.70985), LatLng(23.14107, -109.70967), LatLng(23.14188, -109.70959), LatLng(23.14485, -109.70935), LatLng(23.14725, -109.70913), LatLng(23.15072, -109.70879), LatLng(23.15179, -109.70868), LatLng(23.15395, -109.70845), LatLng(23.15412, -109.70844), LatLng(23.15429, -109.70833), LatLng(23.15469, -109.70817), LatLng(23.15566, -109.70766), LatLng(23.1558, -109.70763), LatLng(23.15594, -109.70763), LatLng(23.1561, -109.70767), LatLng(23.15622, -109.70774), LatLng(23.15634, -109.70784), LatLng(23.15642, -109.70794), LatLng(23.15663, -109.70844), LatLng(23.15693, -109.70918),
          LatLng(23.15694, -109.70918), LatLng(23.15711, -109.7095), LatLng(23.15727, -109.70972), LatLng(23.15758, -109.71006), LatLng(23.15803, -109.71042), LatLng(23.15885, -109.71119), LatLng(23.15894, -109.71134), LatLng(23.1592, -109.71158)
          //LatLng(22.90275, -109.88286), LatLng(22.90328, -109.8877), LatLng(22.90364, -109.89078), LatLng(22.90366, -109.89118), LatLng(22.90364, -109.89157), LatLng(22.9036, -109.89194), LatLng(22.90352, -109.89234), LatLng(22.90336, -109.89277), LatLng(22.90306, -109.89341), LatLng(22.90273, -109.89398), LatLng(22.89859, -109.90137), LatLng(22.89772, -109.90292), LatLng(22.89671, -109.90477), LatLng(22.89638, -109.90525), LatLng(22.8961, -109.90554), LatLng(22.89566, -109.90596), LatLng(22.89525, -109.90627), LatLng(22.89475, -109.90661), LatLng(22.8936, -109.90737), LatLng(22.89286, -109.90783), LatLng(22.89216, -109.9083), LatLng(22.89094, -109.90908), LatLng(22.89085, -109.90894), LatLng(22.89063, -109.90874), LatLng(22.89033, -109.90854), LatLng(22.89017, -109.90841), LatLng(22.8892, -109.90776), LatLng(22.88901, -109.90764), LatLng(22.88864, -109.90963), LatLng(22.88857, -109.90994), LatLng(22.88856, -109.91015), LatLng(22.88854, -109.91046), LatLng(22.88891, -109.91025), LatLng(22.88895, -109.91022)

          ],
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap)); 

          
        
      });
      
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style1.txt').then((string) {
      _mapStyle = string;
    });
    getData();
    //getData1();
    this.getCar();
    _currentLocation();
    this.getaddressPoints();
     
  }


  getData() async {
     
     /* var iconurl ='https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Interactive_icon.svg/681px-Interactive_icon.svg.png';
      var dataBytes;
      var request = await http.get(iconurl);
      var bytes = await request.bodyBytes;*/


    try {
      final response =
          await http.get('http://cabofind.com.mx/app_php/consultas_negocios/esp/rutas/rutas.php');
          //await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=22.900890,%20-109.942955&radius=500&key=AIzaSyA152PLBZLFqFlUMKQhMce3Z18OMGhPY6w');

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        List responseBody = json.decode(response.body);
        //List results = responseBody["results"];

        Iterable _markers = Iterable.generate(responseBody == null ? 0 : responseBody.length, (index) {

          String lat = responseBody[index]["RUT_LAT"];
          String long = responseBody[index]["RUT_LONG"];
          String nom = responseBody[index]["RUT_NOMBRE"];
          String sub = responseBody[index]["RUT_DESCRIPCION"];
          String icon = responseBody[index]["RUT_ICON"];

          var iconurl =responseBody[index]["RUT_LAT"];
     
          
//icon:BitmapDescriptor.fromBytes(dataBytes.buffer.asUint8List()),

          var lat1 = double.parse(lat);
          var long1 = double.parse(long);
          //Map result = results[index];
          //Map location = result["geometry"]["location"];
          //LatLng latLngMarker = LatLng(result["lat"], result["lng"]);
          LatLng latLngMarker = LatLng(lat1, long1);
         // print(lat);
          return Marker(markerId: MarkerId("marker$index"),position: latLngMarker, icon:BitmapDescriptor.fromAsset(icon), infoWindow: InfoWindow(title: nom, snippet:sub, onTap: (){
             

            }),
          onTap:(){}
            
            );
        });


        setState(() {

         
          
          markers = _markers;

         
          ///polyLine = _polyLine;

          
          
        });
      } else {
        throw Exception('Error');
      }
    } catch(e) {
      print(e.toString());
    }
  }

 

  Future<String> getCar() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://cabofind.com.mx/app_php/consultas_negocios/esp/rutas/empresas.php"),

        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(
            () {
          data = json.decode(
              response.body);
        });


    return "Success!";
  }

  void _currentLocation() async {
   final GoogleMapController controller = await _controller.future;
   LocationData currentLocation;
   var location = new Location();
   try {
     currentLocation = await location.getLocation();
     print(currentLocation);
     } on Exception {
       currentLocation = null;
       }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
          title: new Text( 'Rutas'),
        ),
      
      body: Stack(
              children: <Widget>[

          
               
          GoogleMap(
            polylines: polyline,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: false,
            markers: Set.from(
              markers
            ),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
          ),
/*
          Positioned(
                                right: 5.0,
                                bottom: 530.0,
                                child: new FloatingActionButton(
                                  child: new Icon(FontAwesomeIcons.mapMarkerAlt),
                                  backgroundColor: Colors.black,
                                  onPressed: _currentLocation,
                    
                                ),
                              ),  */
          
          
          
          Container(
            height: 100,
            width: 200,
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FadeInImage(   
                        image: ExactAssetImage('assets/busazul1.png'),
                        fit: BoxFit.cover,  
                        width: 35,  
                        //height: MediaQuery.of(context).size.height * 0.38,  
                        height: 35,  
                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),  
                        placeholder: AssetImage('android/assets/images/loading.gif'),  
                        fadeInDuration: Duration(milliseconds: 200),   
                        
                      ),
                      Text('  Paradas')
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      FadeInImage(   
                        image: ExactAssetImage('assets/busrojo1.png'),
                        fit: BoxFit.cover,  
                        width: 35,  
                        //height: MediaQuery.of(context).size.height * 0.38,  
                        height: 35,  
                        // placeholder: AssetImage('android/assets/images/jar-loading.gif'),  
                        placeholder: AssetImage('android/assets/images/loading.gif'),  
                        fadeInDuration: Duration(milliseconds: 200),   
                        
                      ),
                      Text('  Paradas importantes')
                    ],
                  )
                ],
              ) ,
            ),
          ), 
          _buildContainer(),
        ],
      ),
    );

    

  }

  Future<void> _gotoLocation(String lat,String long) async {
    var lat1 = double.parse(lat);
    var long1 = double.parse(long);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat1, long1), zoom: 30,tilt: 40.0,
      bearing: 45.0,)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        height: 160.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
          return Card(
           
                      child: Row (
              children: <Widget>[
              SizedBox(width: 15.0),
              FadeInImage(

                      image: NetworkImage(data[index]["RE_FOTO"]),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,

                      // placeholder: AssetImage('android/assets/images/jar-loading.gif'),
                      placeholder: AssetImage('android/assets/images/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 200),

                    ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                
                child:  Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        

        
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
                child: Text(data[index]["RE_NOMBRE"],
              style: TextStyle(
                  color: Color(0xff6200ee),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )),
        ),
        Text(
                 "Horarios", 
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21.0,
                  ),
                ),
        Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                
                Container(
                    child: Text(
                 data[index]["RE_HORARIO"], 
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                ))
                
              ],
            )),
            SizedBox(height:5.0),
            Text(
                 "Costos", 
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21.0,
                  ),
                ),
        Container(
                    child: Text(
                 data[index]["RE_PRECIO"],
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                  ),
                )),
                SizedBox(height:5.0),
        
      ],
    )
              ),
              
            ],
            ),
          );
          }
          
        ),
      ),
    );
  }
/*
  Widget _boxes(String _image, String lat,String long,String restaurantName,String catnom,String subnom) {
    //var lat1 = double.parse(lat);
    //var long1 = double.parse(long);
    return  GestureDetector(
        onTap: () {
          var lat1 = double.parse(lat);
          var long1 = double.parse(long);
          _gotoLocation(lat,long);

          
        },
        child:Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(_image),
                            ),
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDetailsContainer1(_image,lat,long,restaurantName,catnom,subnom),
                          ),
                        ),

                      ],)
                ),
              ),
            ),
    );
  }

  Widget myDetailsContainer1(String _image,String lat,String long,String restaurantName,String catnom,String subnom ) {

     
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
               catnom, 
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              ))
              
            ],
          )),
          SizedBox(height:5.0),
        Container(
                  child: Text(
               subnom,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              SizedBox(height:5.0),
        RaisedButton(

                  onPressed: (){},  

                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0) ),
                  color: Colors.black,  
                  
                  child: new Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      new Text('Solicitar Uber ', style: TextStyle(fontSize: 20, color: Colors.white)), 
                      new Icon(FontAwesomeIcons.uber, color: Colors.white,)
                    ],
                  )
                  
                ),
      ],
    );}
  */
  }

