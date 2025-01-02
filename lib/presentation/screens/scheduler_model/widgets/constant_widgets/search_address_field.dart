import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class SearchAddressMap extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onSuggestionSelected;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;// New onChanged callback

  SearchAddressMap({
    required this.controller,
    this.onSuggestionSelected,
    this.onChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
      create: (_) => AddressProvider(
        controller: controller,
        onChange:onChanged , // Pass the callback to the provider
      ),
      child: Consumer<AddressProvider>(
        builder: (context, provider, _) {
          return Column(
          children: [
            Container(
              width: 320,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: onSubmit,
                onChanged: (value)=>provider.showOverlay(context),
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search,),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical:4),
                ),
              ),
            ),
            // if (provider.suggestions.isNotEmpty)
            //   _SuggestionOverlay(
            //     suggestions: provider.suggestions,
            //     onSuggestionSelected: (selected) {
            //       controller.text = selected;
            //       provider.removeOverlay();
            //       if (onSuggestionSelected != null) {
            //         onSuggestionSelected!(selected);
            //       }
            //     },
            //   ),
          ],
        );
        },
      ),
    );
  }
}
class _SuggestionOverlay extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onSuggestionSelected;

  const _SuggestionOverlay({
    required this.suggestions,
    required this.onSuggestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: suggestions.length > 5 ? 80.0 : double.infinity,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestions[index]),
                onTap: () => onSuggestionSelected(suggestions[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}


