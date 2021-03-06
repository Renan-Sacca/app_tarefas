import '../backend/backend.dart';
import '../detalhes/detalhes_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TarefasRealizadasWidget extends StatefulWidget {
  const TarefasRealizadasWidget({Key key}) : super(key: key);

  @override
  _TarefasRealizadasWidgetState createState() =>
      _TarefasRealizadasWidgetState();
}

class _TarefasRealizadasWidgetState extends State<TarefasRealizadasWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF01010A),
        automaticallyImplyLeading: false,
        title: Text(
          'Tarefas ConclĂșidas',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Color(0xFFD6E2E6),
                fontSize: 25,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Color(0xFF1D1A1A),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: StreamBuilder<List<ListaTarefasRecord>>(
                  stream: queryListaTarefasRecord(
                    queryBuilder: (listaTarefasRecord) => listaTarefasRecord
                        .where('status', isEqualTo: true)
                        .orderBy('data', descending: true),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    List<ListaTarefasRecord> columnListaTarefasRecordList =
                        snapshot.data;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            columnListaTarefasRecordList.length, (columnIndex) {
                          final columnListaTarefasRecord =
                              columnListaTarefasRecordList[columnIndex];
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 2),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD81212),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalhesWidget(
                                          umaTarefa: columnListaTarefasRecord
                                              .reference,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                columnListaTarefasRecord.titulo,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20,
                                                        ),
                                              ),
                                              Text(
                                                columnListaTarefasRecord.data
                                                    .toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 12, 12, 12),
                                            child: ToggleIcon(
                                              onPressed: () async {
                                                final listaTarefasUpdateData =
                                                    createListaTarefasRecordData(
                                                  status:
                                                      !columnListaTarefasRecord
                                                          .status,
                                                );
                                                await columnListaTarefasRecord
                                                    .reference
                                                    .update(
                                                        listaTarefasUpdateData);
                                              },
                                              value: columnListaTarefasRecord
                                                  .status,
                                              onIcon: Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                              offIcon: Icon(
                                                Icons.radio_button_off,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
