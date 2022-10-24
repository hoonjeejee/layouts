import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:layout_test/widgets/date_picker_text_field.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MainTabPageSalesTally1 extends StatefulWidget {
  const MainTabPageSalesTally1({super.key});

  @override
  State<MainTabPageSalesTally1> createState() => _MainTabPageSalesTallyState1();
}

class _MainTabPageSalesTallyState1 extends State<MainTabPageSalesTally1> {
  late double maxWidth;
  late double maxHeight;
  final _valueList = ['일별조회', '월별조회'];
  String? _selectedValue;
  double div01Height = 200;
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();

  // for grid
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employee = <Employee>[];
  //for paging
  final int _rowsPerPage = 10;
  final double _dataPagerHeight = 60.0;

  @override
  void initState() {
    super.initState();
    dateinputStart.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateinputEnd.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 30)));

    //for grid
    _employee = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employee);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      maxWidth = constraints.maxWidth;
      maxHeight = constraints.maxHeight;
      return Column(
        children: [
          _div1(Colors.black12, "Search Items"),
          Row(
            children: [
              _div2(Colors.black26, "Grid"),
            ],
          ),
        ],
      );
    });
  }

  Widget _div1(Color c, String str) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      alignment: Alignment.topLeft,
      height: div01Height,
      width: maxWidth,
      color: c,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            str,
            style: const TextStyle(fontSize: 24),
          ),
          Row(
            children: [
              _dropdownSearchKind(),
              const SizedBox(
                width: 100,
              ),
              datePickerTextField(context, dateinputStart, "조회기간.시작",
                  (formattedDate) {
                setState(() {
                  dateinputStart.text = formattedDate;
                });
              }),
              const Text("~"),
              datePickerTextField(context, dateinputEnd, "조회일자.마지막",
                  (formattedDate) {
                setState(() {
                  dateinputEnd.text = formattedDate;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _div2(Color c, String str) {
    //
    return Container(
      height: maxHeight - div01Height,
      color: c,
      width: maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            str,
            style: const TextStyle(fontSize: 24),
          ),
          _grid(),
        ],
      ),
    );
  }

/*
  DropdownSearch & DropdownButtonFormField 이 Row widget 내 속한다면
  SizedBox로 width를 지정해야서 써야한다. 그렇지 않으면 해당 width를 모두 잡아먹는다.
*/
  Widget _dropdownSearchKind() {
    return SizedBox(
      width: 200,
      child: DropdownSearch(
        items: const ["일별조회", "월별조회"],
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(labelText: "조회구분"),
        ),
        onChanged: print,
        selectedItem: "일별조회",
        validator: (String? item) {
          if (item == null) {
            return "Required field";
          }
          return null;
        },
      ),
    );
  }

  Widget _dropdownButton() {
    return DropdownButton(
      hint: const Text("조회구분"),
      items: _valueList
          .map(
            (String item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (String? value) => setState(() {
        _selectedValue = value;
      }),
      value: _selectedValue,
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _dropdownFormField() {
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _valueList
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: ((value) => setState(
            () {
              _selectedValue = value as String;
            },
          )),
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.deepPurple,
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////
  //

  Widget _grid() {
    return Container(
      color: Colors.black12,
      child: SizedBox(
        width: 400,
        child: SfDataGrid(
          source: _employeeDataSource,
          columns: [
            _gridColume('id'),
            _gridColume('name'),
            _gridColume('designation'),
            _gridColume('salary'),
          ],
          selectionMode: SelectionMode.none,
        ),
      ),
    );
  }

  GridColumn _gridColume(String colName) {
    String textStr = colName[0].toUpperCase() + colName.substring(1);
    Alignment alignment = Alignment.centerLeft;
    if (colName == "id" || colName == "salary") {
      alignment = Alignment.centerRight;
    }

    return GridColumn(
      columnName: colName,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: alignment,
        child: Text(
          textStr,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("new Screen");
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);

  final int id;
  final String name;
  final String designation;
  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id' ||
                  dataGridCell.columnName == 'salary')
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
