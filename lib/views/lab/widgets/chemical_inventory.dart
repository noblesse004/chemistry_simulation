import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chemistry_simulation/providers/lab_provider.dart';
import 'package:chemistry_simulation/data/models/chemical_model.dart';
import 'chemical_card.dart';

class ChemicalInventory extends StatelessWidget {
  const ChemicalInventory({super.key});

  @override
  Widget build(BuildContext context) {
    final labProvider = context.read<LabProvider>();

    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      children: [
        // 1. HCl (Khớp với logic phản ứng 1 & 3)
        ChemicalCard(
          name: "HCl",
          color: Colors.blue.shade100,
          onTap: () => labProvider.selectChemical(
            ChemicalModel(id: "HCl", name: "HCl", formula: "HCl", type: "acid"),
          ),
        ),

        // 2. NaOH (Khớp với logic phản ứng 1)
        ChemicalCard(
          name: "NaOH",
          color: Colors.red.shade100,
          onTap: () => labProvider.selectChemical(
            ChemicalModel(
              id: "NaOH",
              name: "NaOH",
              formula: "NaOH",
              type: "base",
            ),
          ),
        ),

        // 3. BaCl2 (MỚI: Để chạy phản ứng tạo kết tủa số 2)
        ChemicalCard(
          name: "BaCl2",
          color: Colors.green.shade100,
          onTap: () => labProvider.selectChemical(
            ChemicalModel(
              id: "BaCl2",
              name: "BaCl2",
              formula: "BaCl2",
              type: "salt",
            ),
          ),
        ),

        // 4. H2SO4 (Khớp với logic phản ứng 2)
        ChemicalCard(
          name: "H2SO4",
          color: Colors.orange.shade100,
          onTap: () => labProvider.selectChemical(
            ChemicalModel(
              id: "H2SO4",
              name: "H2SO4",
              formula: "H2SO4",
              type: "acid",
            ),
          ),
        ),

        // 5. Quỳ tím (Khớp với logic nhận biết số 3)
        ChemicalCard(
          name: "Quỳ tím",
          color: Colors.purple.shade100,
          onTap: () => labProvider.selectChemical(
            ChemicalModel(
              id: "Quỳ tím",
              name: "Quỳ tím",
              formula: "Indicator",
              type: "indicator",
            ),
          ),
        ),
      ],
    );
  }
}
