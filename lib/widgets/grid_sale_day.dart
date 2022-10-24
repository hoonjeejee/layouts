import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DayOrder {
  final String date;
  final int saleCnt;
  final int saleAmt;
  final int saleCancleCtn;
  final int saleCancleAmt;
  final int usedCnt;
  final int usedAmt;
  final int unUsedCnt;
  final int unUsedAmt;

  DayOrder(
    this.date,
    this.saleCnt,
    this.saleAmt,
    this.saleCancleCtn,
    this.saleCancleAmt,
    this.usedCnt,
    this.usedAmt,
    this.unUsedCnt,
    this.unUsedAmt,
  );
}

class DayOrderDateGrid {
  Widget buildDataGrid(DayOrderDataSource dayOrderDataSource) {
    return Container(
      color: Colors.black12,
      child: SizedBox(
        width: 900,
        height: 450,
        child: Theme(
          data: ThemeData(visualDensity: VisualDensity.comfortable),
          child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: dayOrderDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              _gridColume('date', '날짜'),
              _gridColume('saleCnt', '수량'),
              _gridColume('saleAmt', '금액'),
              _gridColume('saleCancleCtn', '수량'),
              _gridColume('saleCancleAmt', '금액'),
              _gridColume('usedCnt', '수량'),
              _gridColume('usedAmt', '금액'),
              _gridColume('unUsedCnt', '수량'),
              _gridColume('unUsedAmt', '금액'),
            ],
            stackedHeaderRows: <StackedHeaderRow>[
              StackedHeaderRow(cells: [
                StackedHeaderCell(
                  columnNames: ['saleCnt', 'saleAmt'],
                  child: const Center(
                    child: Text('판매'),
                  ),
                ),
                StackedHeaderCell(
                  columnNames: ['saleCancleCtn', 'saleCancleAmt'],
                  child: const Center(
                    child: Text('판매취소'),
                  ),
                ),
                StackedHeaderCell(
                  columnNames: ['usedCnt', 'usedAmt'],
                  child: const Center(
                    child: Text('사용'),
                  ),
                ),
                StackedHeaderCell(
                  columnNames: ['unUsedCnt', 'unUsedAmt'],
                  child: const Center(
                    child: Text('사용취소'),
                  ),
                ),
              ])
            ],
            selectionMode: SelectionMode.none,
          ),
        ),
      ),
    );
  }

  GridColumn _gridColume(String colName, String textStr) {
    return GridColumn(
      columnName: colName,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Text(
          textStr,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  List<DayOrder> getOrderData() {
    return [
      DayOrder('20221024', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221025', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221026', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221027', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221028', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221029', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221030', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221031', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221101', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221102', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221103', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221104', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221105', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221106', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221108', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221109', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221110', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221111', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221112', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221113', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221114', 1, 1, 2, 2, 3, 3, 4, 4),
      DayOrder('20221115', 1, 1, 2, 2, 3, 3, 4, 4),
    ];
  }
}

class DayOrderDataSource extends DataGridSource {
  DayOrderDataSource({required List<DayOrder> orders}) {
    dataGridRows = orders
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'date', value: dataGridRow.date),
              DataGridCell<int>(
                  columnName: 'salecnt', value: dataGridRow.saleCnt),
              DataGridCell<int>(
                  columnName: 'saleamt', value: dataGridRow.saleAmt),
              DataGridCell<int>(
                  columnName: 'saleCancleCtn',
                  value: dataGridRow.saleCancleCtn),
              DataGridCell<int>(
                  columnName: 'saleCancleAmt',
                  value: dataGridRow.saleCancleAmt),
              DataGridCell<int>(
                  columnName: 'usedCnt', value: dataGridRow.usedCnt),
              DataGridCell<int>(
                  columnName: 'usedAmt', value: dataGridRow.usedAmt),
              DataGridCell<int>(
                  columnName: 'unUsedCnt', value: dataGridRow.unUsedCnt),
              DataGridCell<int>(
                  columnName: 'unUsedAmt', value: dataGridRow.unUsedAmt),
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
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
