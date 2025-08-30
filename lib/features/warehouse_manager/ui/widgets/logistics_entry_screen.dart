import 'package:flutter/material.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/upload_number_image_and_name_of_driver_shipment.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/shipments_info_card.dart';
import 'package:final_subul_project/features/receiving_shipments/ui/widgets/title_of_columns_receive_shipments.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/volumetric_weight_calculation.dart';

class LogisticsEntryScreen extends StatelessWidget {
  const LogisticsEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: size.height / 5),
        TitleOfColumnsReceiveShipments(),
        SizedBox(height: size.height / 20),
        ShipmentInfoCard(),
        SizedBox(height: size.height / 30),
        Row(
          children: [
           // UploadNumberImageAndNameOfDriverShipment(shipmentId: 1),
            SizedBox(width: size.width / 60),
            VolumetricWeightCalculation(),
          ],
        ),
      ],
    );
  }
}
