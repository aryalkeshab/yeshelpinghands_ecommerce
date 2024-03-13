import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/textfields.dart';
import 'package:yeshelpinghand/features/store_location/presentation/controllers/store_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreLocationScreen extends StatefulWidget {
  const StoreLocationScreen({Key? key}) : super(key: key);

  @override
  State<StoreLocationScreen> createState() => _StoreLocationScreenState();
}

class _StoreLocationScreenState extends State<StoreLocationScreen> {
  var storeLocation = Get.put(StorePickupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Location'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
          child: Column(
            children: [
              PrimaryFormField(
                hintIcon: const Icon(Icons.location_city),
                label: "",
                hintTxt: "Search for Store Nearby.....",
                onSaved: (value) {},
              ),
              config.verticalSpaceMedium(),
              Expanded(
                child: ListView.builder(
                  itemCount: storeLocation.dummyStoreLocation.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                      
                      },
                      child: Card(
                        child: ListTile(
                          leading: SizedBox(
                              width: 80,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      storeLocation.dummyStoreLocation[index].imageUrl ?? '')),
                          title: Text(
                            storeLocation.dummyStoreLocation[index].storeName ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(storeLocation.dummyStoreLocation[index].description ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
