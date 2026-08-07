import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../xcore.dart';

class MapPickerScreen extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const MapPickerScreen({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  GoogleMapController? _mapController;
  late LatLng _selectedPosition;

  @override
  void initState() {
    super.initState();
    _selectedPosition = LatLng(
      widget.initialLatitude ?? 19.0760,
      widget.initialLongitude ?? 72.8777,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  void _onMapTapped(LatLng position) {
    setState(() => _selectedPosition = position);
  }

  void _onMarkerDragEnd(LatLng position) {
    setState(() => _selectedPosition = position);
  }

  void _confirm() {
    Navigator.pop(context, _selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick location'),
        actions: [
          TextButton(onPressed: _confirm, child: const Text('Confirm')),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _selectedPosition,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('picker'),
            position: _selectedPosition,
            draggable: true,
            onDragEnd: _onMarkerDragEnd,
          ),
        },
        onTap: _onMapTapped,
        onMapCreated: (controller) => _mapController = controller,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}
