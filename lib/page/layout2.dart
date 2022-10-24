import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:layout_test/widgets/date_picker_text_field.dart';
import 'package:layout_test/widgets/grid_sale_day.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MainTabPageSalesTally extends StatefulWidget {
  const MainTabPageSalesTally({super.key});

  @override
  State<MainTabPageSalesTally> createState() => _MainTabPageSalesTallyState();
}

class _MainTabPageSalesTallyState extends State<MainTabPageSalesTally> {
  late double maxWidth;
  late double maxHeight;
  double div01Height = 100;
  TextEditingController dateinputStart = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();

  // for grid
  late DayOrderDataSource _dayOrderDataSource;
  List<DayOrder> _dayOrder = <DayOrder>[];
  final DayOrderDateGrid _dayOrderDateGrid = DayOrderDateGrid();
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
    _dayOrder = _dayOrderDateGrid.getOrderData();
    _dayOrderDataSource = DayOrderDataSource(orders: _dayOrder);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      maxWidth = constraints.maxWidth;
      maxHeight = constraints.maxHeight;
      return SingleChildScrollView(
        child: Column(
          children: [
            _div1(Colors.black12),
            _div2(constraints, Colors.black26),
            SizedBox(
              height: _dataPagerHeight,
              child: SfDataPager(
                delegate: _dayOrderDataSource,
                pageCount: _dayOrder.length / _rowsPerPage,
                direction: Axis.horizontal,
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _div1(Color c) {
    return Container(
      //margin: const EdgeInsets.only(left: 30),
      padding: const EdgeInsets.only(left: 30),
      alignment: Alignment.topLeft,
      height: div01Height,
      width: maxWidth,
      color: c,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

  Widget _div2(BoxConstraints constraints, Color c) {
    //
    return Container(
      height: maxHeight - div01Height - _dataPagerHeight,
      padding: const EdgeInsets.only(top: 20),
      color: c,
      width: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dayOrderDateGrid.buildDataGrid(_dayOrderDataSource),
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
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("new Screen");
  }
}
