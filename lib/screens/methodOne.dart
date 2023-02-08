import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

class methodOne extends StatefulWidget {
  const methodOne({super.key});

  @override
  State<methodOne> createState() => _methodOneState();
}

class _methodOneState extends State<methodOne> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPrinter();
    });
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen((event) {
      if (!mounted) return;
      setState(() {
        _devices = event;
      });
      if (_devices.isEmpty)
        setState(() {
          _devicesMsg = "No Devices Found";
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method One'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: _devices.isEmpty
                ? Center(
                    child: Text(_devicesMsg),
                  )
                : ListView.builder(
                    itemCount: _devices.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: Icon(Icons.print),
                        title: Text(_devices[index].name.toString()),
                        subtitle: Text(_devices[index].address.toString()),
                        onTap: () {
                          _startPrint(_devices[index]);
                        },
                      );
                    }),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await initPrinter();
        },
        child: Icon(Icons.print),
      ),
    );
  }

  Future<void> _startPrint(BluetoothDevice device) async {
    if (device != null && device.address != null) {
      await bluetoothPrint.connect(device);

      Map<String, dynamic> config = Map();
      List<LineText> list = [];
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Connect To Printer App 1",
        weight: 2,
        width: 2,
        height: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Connect To Printer App 2",
        weight: 2,
        width: 2,
        height: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      await bluetoothPrint.printLabel(config, list);
    }
  }
}
