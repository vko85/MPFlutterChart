import 'package:mp_chart_x/mp/core/data/chart_data.dart';
import 'package:mp_chart_x/mp/core/data_interfaces/i_radar_data_set.dart';
import 'package:mp_chart_x/mp/core/entry/entry.dart';
import 'package:mp_chart_x/mp/core/highlight/highlight.dart';

class RadarData extends ChartData<IRadarDataSet> {
  List<String>? _labels;

  RadarData() : super();

  RadarData.fromList(List<IRadarDataSet> dataSets) : super.fromList(dataSets);

  // ignore: unnecessary_getters_setters
  List<String>? get labels => _labels;

  // ignore: unnecessary_getters_setters
  set labels(List<String>? value) {
    _labels = value;
  }

  @override
  Entry? getEntryForHighlight(Highlight? highlight) {
    return getDataSetByIndex(highlight?.dataSetIndex??0)!
        .getEntryForIndex(highlight?.x?.toInt()??0);
  }
}
