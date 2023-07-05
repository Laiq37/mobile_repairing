import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_repairing/constants/AppColors.dart';
import 'package:mobile_repairing/widgets/drop_down_text.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String? dropDownTitle;
  final String hint;
  final String selectedItem;
  final Function(String? value) onChanged;

  const CustomDropDown({required this.items,  this.dropDownTitle, required this.hint, required this.selectedItem, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(dropDownTitle != null)
         Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 33,
                            ),
                            child: DropDownTexts(title: dropDownTitle!),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 33,
                            ),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          AppColors.blackClr.withOpacity(0.3))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: AppColors.TextFieldClr,
                                    hint: Text(hint),
                                    elevation: 0,
                                    borderRadius: BorderRadius.circular(10),
                                    style: GoogleFonts.commissioner(
                                        color:
                                            AppColors.blackClr.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                    isExpanded: true,
                                    value: selectedItem,
                                    items: 
                                    items.map((String model) 
                                      => DropdownMenuItem(
                                        value: model,
                                        child: Text(model),
                                      )
                                    ).toList(),
                                    onChanged: onChanged
                                  ),
                                ),
                              ),
                            ),
                          ),
      ],
    );
  }
}