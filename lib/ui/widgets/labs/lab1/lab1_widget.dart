import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/lab1_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/matrix_transpose/matrix_transpose_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/matrix_transpose/matrix_transpose_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/prod_vec_and_scalar/prod_vec_scal_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/prod_vec_and_scalar/prod_vec_scal_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/scalar_product_of_vector/scalar_product_of_vector_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/scalar_product_of_vector/scalar_product_of_vector_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/sum_and_product_matrices/sum_and_product_matrices_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/sum_and_product_matrices/sum_and_product_matrices_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/sum_of_two_vectors/sum_of_two_vectors_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/sum_of_two_vectors/sum_of_two_vectors_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/vector_module/vector_module_model.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/vector_module/vector_module_widget.dart';

class Lab1Widget extends StatefulWidget {
  const Lab1Widget({Key? key}) : super(key: key);

  @override
  State<Lab1Widget> createState() => _Lab1WidgetState();
}

class _Lab1WidgetState extends State<Lab1Widget> {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab1Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №1',
        ),
      ),
      drawer: const _NavigationDrawer(),
      body: IndexedStack(
        index: model.selectedTab,
        children: [
          NotifierProvider(
            child: const ProdVecScalWidget(),
            create: () => ProdVecScalModel(),
          ),
          NotifierProvider(
            child: const SumOfTwoVectorsWidget(),
            create: () => SumOfTwoVectorsModel(),
          ),
          NotifierProvider(
            child: const ScalarProductOfVectorWidget(),
            create: () => ScalarProductOfVectorModel(),
          ),
          NotifierProvider(
            child: const VectorModuleWidget(),
            create: () => VectorModuleModel(),
          ),
          NotifierProvider(
            child: const MatrixTransposeWidget(),
            create: () => MatrixTransposeModel(),
          ),
          NotifierProvider(
            child: const SumAndProductsMatricesWidget(),
            create: () => SumAndProductsMatricesModel(),
          ),
        ],
      ),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            buildHeader(context),
            const SizedBox(height: 10),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => const SizedBox(
        height: 100,
        width: double.infinity,
        child: ColoredBox(
          color: Colors.blueAccent,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Programming vector and matrix operations',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) {
    final model = NotifierProvider.read<Lab1Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Product of a vector and a scalar',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              model.setSelectedTab(0);
              Navigator.of(context).pop();
            }, // Replacement
          ),
          ListTile(
            title: const Text(
              'Sum of two vectors',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              model.setSelectedTab(1);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text(
              'Scalar product of vectors',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              model.setSelectedTab(2);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text(
              'Vector module',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              model.setSelectedTab(3);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text(
              'Matrix transpose & Product of a matrix and a scalar',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              model.setSelectedTab(4);
              Navigator.of(context).pop();
            },
          ),
          // ListTile(
          //   title: const Text(
          //     'Product of a matrix and a scalar',
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   title: const Text(
          //     'Product of a matrix and a vector',
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            title: const Text(
              'Sum & product of two matrices',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              model.setSelectedTab(5);
              Navigator.of(context).pop();
            },
          ),
          // ListTile(
          //   title: const Text(
          //     'Product of two matrices',
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onTap: () {},
          // ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.settings),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
