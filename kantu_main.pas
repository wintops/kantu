unit kantu_main;

{$IFNDEF DELPHI}
{$mode objfpc}{$H+}
{$ENDIF}
{
  2024
  8.8 Add ktInit ,ktCode, ktUtils....
 11.8 Move Charts to ktChart for LLCL
 12.27 Move TradeGrid to ktTradeGrid

}

interface

{$IFDEF DELPHI}
{$ELSE}
{$ENDIF}

uses



{$IFDEF LLCL}
LLCLmore,
{$ENDIF}
 {$IFDEF TEECHART}
   VclTee.Series,

{$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, Grids, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, // ExtDlgs,
  kantu_definitions,
  kantu_simulation, kantu_pricepattern, Math, kantu_filters,
  kantu_custom_filter,
  kantu_loadSymbol, kantu_portfolioresults, dateUtils, kantu_singleSystem






;
type

  { TMainForm }

  TMainForm = class(TForm)

    Button1: TButton;
    Button3: TButton;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    extraLabel: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenKantuLibraryDialog: TOpenDialog;
    OpenSymbolHistoryDialog: TOpenDialog;
    OutOfSampleAnalysisLabel: TLabel;

    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu4: TPopupMenu;
    PopupMenu6: TPopupMenu;
    ResultsGrid: TStringGrid;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    SaveDialogMQL4: TSaveDialog;
    selectedPatternLabel: TLabel;
    StatusLabel: TLabel;
    ProgressBar1: TProgressBar;
    plStatus: TPanel;


    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure FinaMainSymbol(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure showloadSymbol(Sender: TObject);
    procedure ResultsGridClick(Sender: TObject);
    procedure showOrHideColumn(Sender: TObject);
    procedure ResultsGridCompareCells(Sender: TObject;
      ACol, ARow, BCol, BRow: Integer; var Result: Integer);
    procedure ResultsGridGetCellHint(Sender: TObject; ACol, ARow: Integer;
      var HintText: String);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }


  public

    isCancel: boolean;
    simulationRuns: Integer;
    simulationTime: Integer;
    simulationType: Integer;
    selectedSystem: Integer;
    selectedSymbol: Integer;
    totalSystems: double;





    function CheckBeforeSimulation: boolean;

{$IFNDEF DELPHI}
    procedure ExportToMQL4;
    procedure LinearLeastSquares(data: TRealPointArray; var M, B, R: extended);
    procedure LinearLeastSquaresNormal(data: TRealPointArray;
      var M, B, R: extended);
    procedure ParseDelimited(const sl: TStrings; const value: string;
      const delimiter: string);
    procedure addPricePatternLogic(var F4_Code: TStringList;
      pricePattern: TIndicatorPattern; logic: Integer; useLibrary: boolean;
      strategyNumber: Integer);
    function findSymbol(symbolString: string): Integer;
    procedure pricePatternToMQL4(var Code_MQL4: TStringList;
      pricePattern: TIndicatorPattern; logic: Integer);
{$ENDIF}
    procedure parseConfig;
  end;

var
  MainForm: TMainForm;

implementation

{$IFDEF DELPHI}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses ktCode, ktUtils, KtChart, ktTradeGrid,
  kantu_indicators, kantu_regular_simulation, kantu_simulation_show;

procedure TMainForm.parseConfig;
var
  configFile: TStringList;
  i, j: Integer;
begin

  if FileExists('config.ini') = False then
    exit;

{$IFDEF DELPHI}
  // DefaultFormatSettings := FormatSettings;

  FormatSettings.ShortDateFormat := 'yyyy.mm.dd';
  FormatSettings.DateSeparator := '.';
  FormatSettings.DecimalSeparator := '.';
{$ELSE}
  DefaultFormatSettings.ShortDateFormat := 'yyyy.mm.dd';
  DefaultFormatSettings.DateSeparator := '.';
  DefaultFormatSettings.DecimalSeparator := '.';
{$ENDIF}
  SetCurrentDir(mainProgramFolder);
  j := 0;

  configFile := TStringList.Create;

  configFile.LoadFromFile('config.ini');
  if configFile.Count < 110 then
    exit;
{$IFDEF DELPHI}
  SimulationForm.OptionsGrid.Cells[1, 0] := OptionValueTitle;
  SimulationForm2.OptionsGrid.Cells[1, 0] := OptionValueTitle;

  for i := 0 to length(OptionNames) - 1 do
  begin
    SimulationForm.OptionsGrid.Cells[0, i + 1] := OptionNames[i];
    SimulationForm2.OptionsGrid.Cells[0, i + 1] := OptionNames[i];
  end;
{$ENDIF}
  for i := 1 to SimulationForm2.OptionsGrid.RowCount - 1 do
  begin
    SimulationForm2.OptionsGrid.Cells[1, i] := configFile[j];
    j := j + 1;
  end;

  for i := 1 to FiltersForm.FiltersGrid.RowCount - 1 do
  begin
    FiltersForm.FiltersGrid.Cells[1, i] := configFile[j];
    j := j + 1;
    FiltersForm.FiltersGrid.Cells[2, i] := configFile[j];
    j := j + 1;
    FiltersForm.FiltersGrid.Cells[3, i] := configFile[j];
    j := j + 1;
    FiltersForm.FiltersGrid.Cells[4, i] := configFile[j];
    j := j + 1;
  end;

  CustomFilterForm.CustomFormulaEdit.Text := configFile[j];
  j := j + 1;


  SimulationForm2.BeginInSampleCalendar.Text := configFile[j];
 SimulationForm.BeginInSampleCalendar.Text := configFile[j];

  j := j + 1;

  SimulationForm2.EndInSampleCalendar.Text := configFile[j];
  SimulationForm.EndInSampleCalendar.Text := configFile[j];

  j := j + 1;

  SimulationForm2.EndOutOfSampleCalendar.Text := configFile[j];
  SimulationForm.EndOutOfSampleCalendar.Text := configFile[j];

  j := j + 1;
  SimulationForm2.OptTargetComboBox.ItemIndex := StrToIntDef(configFile[j], 0);
  SimulationForm.OptTargetComboBox.ItemIndex := StrToIntDef(configFile[j], 0);
  j := j + 1;
  SimulationForm2.UseSLCheck.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.UseSLCheck.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;
  SimulationForm2.UseTPCheck.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.UseTPCheck.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;
  SimulationForm2.UseHourFilter.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.UseHourFilter.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;
  SimulationForm2.UseDayFilter.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.UseDayFilter.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;
  SimulationForm2.LROriginCheck.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.LROriginCheck.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;
  SimulationForm2.UseFixedSLTP.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.UseFixedSLTP.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;
  SimulationForm2.UseFixedHour.Checked := StrToBoolDef(configFile[j], False);
  SimulationForm.UseFixedHour.Checked := StrToBoolDef(configFile[j], False);
  j := j + 1;

  for i := 0 to ResultsGrid.ColCount - 1 do
  begin
{$IFDEF DELPHI}
    // ResultsGrid.Cols[i]
{$ELSE}
    ResultsGrid.Columns.Items[i].Visible := StrToBoolDef(configFile[j], False);
{$ENDIF}
    j := j + 1;
  end;

  FiltersForm.isLastYearProfitCheck.Checked :=
    StrToBoolDef(configFile[j], False);
  j := j + 1;

  configFile.Free;

end;

procedure TMainForm.showloadSymbol(Sender: TObject);
begin
  loadSymbol.Visible := True;

end;

function TMainForm.CheckBeforeSimulation: boolean;
begin

  Result := True;

  if SimulationForm.OptionsGrid.Cells[1, IDX_OPT_MAX_RULES_PER_CANDLE] = '0'
  then
  begin
    ShowMessage('Number of rules needs to be at least 1.');
    Result := False;
  end;

  if SimulationForm.OptionsGrid.Cells[1, IDX_OPT_NO_OF_CORES] = '0' then
  begin
    ShowMessage('Number of cores should be at least 1.');
    Result := False;
  end;

end;

procedure TMainForm.ResultsGridClick(Sender: TObject);
var
  Val: double;
  Col: Integer;
  Row: Integer;
  i: Integer;
  ylist: array [0 .. 4] of double;
  ylistBubble: array [0 .. 1] of double;
  symbol: Integer;
  simulationResults, simulationResultsInSample: TSimulationResults;
  positionType: string;
  indicatorSimulationResults, indicatorSimulationResultsInSample
    : TIndicatorSimulationResults;
begin

{$IFDEF DELPHI1}
{$ELSE}
  for Col := ResultsGrid.Selection.Left to ResultsGrid.Selection.Right do
    for Row := ResultsGrid.Selection.Top to ResultsGrid.Selection.Bottom do
      if TryStrToFloat(ResultsGrid.Cells[Col, Row], Val) then
      begin

        if Col = IDX_GRID_USE_IN_PORTFOLIO then
        begin

          if ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] = '0' then
          begin
            ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] := '1';
            exit
          end;

          if ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] = '1' then
          begin
            ResultsGrid.Cells[IDX_GRID_USE_IN_PORTFOLIO, Row] := '0';
            exit
          end;

        end;

        if Col = IDX_GRID_USE_IN_PORTFOLIO then
          exit;

        selectedSystem := StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER,
          Row]) - 1;

        selectedPatternLabel.Caption :=
          IntToStr(StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER,
          Row]) - 1);

        symbol := findSymbol(ResultsGrid.Cells[IDX_GRID_SYMBOL, Row]);

        selectedSymbol := symbol;

        if simulationType = SIMULATION_TYPE_INDICATORS then
        begin

          indicatorSimulationResultsInSample :=
            runIndicatorSimulation(indicatorEntryPatterns
            [StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row]) - 1],
            indicatorClosePatterns
            [StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row]) - 1],
            symbol, SimulationForm.UseSLCheck.Checked,
            SimulationForm.UseTPCheck.Checked,
            StrToDate(SimulationForm.BeginInSampleCalendar.Text),
            StrToDate(SimulationForm.EndInSampleCalendar.Text), True);

          indicatorSimulationResults :=
            runIndicatorSimulation(indicatorEntryPatterns
            [StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row]) - 1],
            indicatorClosePatterns
            [StrToInt(ResultsGrid.Cells[IDX_GRID_RESULT_NUMBER, Row]) - 1],
            symbol, SimulationForm.UseSLCheck.Checked,
            SimulationForm.UseTPCheck.Checked,
            StrToDate(SimulationForm.BeginInSampleCalendar.Text), Now, False);

 {$IF Defined(TEECHART) or Defined(TACHART)}

          with ChartForm do
          begin
          Show;
          BalanceCurve.Clear;
          BalanceCurveFit.Clear;
          BalanceCurvePortfolio.Clear;
          BalanceCurveFitPortfolio.Clear;
          upperStdDev.Clear;
          lowerStdDev.Clear;
          ME_Longs.Clear;
          ME_Shorts.Clear;

          GraphOHLC_Up.Clear;

          GraphOHLC_Down.Clear;

          GraphOpenTrades.Clear;
          GraphCloseTrades.Clear;
          end;

{$ENDIF}

{$IFDEF TEECHART}
          ChartForm.ChartOHLC.SeriesList.Clear;
{$ENDIF}

{$IFDEF TACHART}
          for i := 0 to length(tradeLines) - 1 do
          begin

            ChartForm.ChartOHLC.DeleteSeries(tradeLines[i]);
            tradeLines[i].Free;
          end;
          tradeLines := nil;

          GraphOHLC_Up.Source.YCount := 5;
          GraphOHLC_Down.Source.YCount := 5;
          GraphOpenTrades.Source.YCount := 2;
          GraphCloseTrades.Source.YCount := 2;
{$ENDIF}



          for i := 0 to length(LoadedIndiHistoryData[symbol].OHLC) - 1 do
          begin

            if LoadedIndiHistoryData[symbol].OHLC[i].close >
              LoadedIndiHistoryData[symbol].OHLC[i].open then
            begin
              ylist[0] := LoadedIndiHistoryData[symbol].OHLC[i].open;
              ylist[1] := (LoadedIndiHistoryData[symbol].OHLC[i].open +
                LoadedIndiHistoryData[symbol].OHLC[i].close) / 2;
              ylist[4] := LoadedIndiHistoryData[symbol].OHLC[i].high;
              ylist[3] := LoadedIndiHistoryData[symbol].OHLC[i].low;
              ylist[2] := LoadedIndiHistoryData[symbol].OHLC[i].close;
{$IFDEF TEECHART}
              ChartForm.GraphOHLC_Up.AddXY(LoadedIndiHistoryData[symbol].Time[i] * 100 /
                LoadedIndiHistoryData[symbol].pointConversion, ylist[2],
'' //{$ELSE}ylist
);
{$ENDIF}

{$IFDEF TEECHART}
              ChartForm.GraphOHLC_Down.AddXY(LoadedIndiHistoryData[symbol].Time[i] * 100 /
                LoadedIndiHistoryData[symbol].pointConversion, ylist[2],
'')
//{$ELSE}ylist
{$ENDIF}
            end
            else
            begin
              ylist[0] := LoadedIndiHistoryData[symbol].OHLC[i].close;
              ylist[2] := LoadedIndiHistoryData[symbol].OHLC[i].open;
              ylist[4] := LoadedIndiHistoryData[symbol].OHLC[i].high;
              ylist[3] := LoadedIndiHistoryData[symbol].OHLC[i].low;
              ylist[1] := (LoadedIndiHistoryData[symbol].OHLC[i].open +
                LoadedIndiHistoryData[symbol].OHLC[i].close) / 2;
{$IFDEF TEECHART}
              ChartForm.GraphOHLC_Down.AddXY(LoadedIndiHistoryData[symbol].Time[i] * 100 /
                LoadedIndiHistoryData[symbol].pointConversion, ylist[2],
'');//{$ELSE}ylist
{$ENDIF}

{$IFDEF TEECHART}

              ChartForm.GraphOHLC_Up.AddXY(LoadedIndiHistoryData[symbol].Time[i] * 100 /
                LoadedIndiHistoryData[symbol].pointConversion, ylist[2],
'');
//{$ELSE}ylist
{$ENDIF}

            end;
          end;
 {$IF Defined(TEECHART) or Defined(TACHART)}

          // plot long trade ME
          for i := 0 to length
            (indicatorSimulationResultsInSample.MFE_Longs) - 1 do
          begin
            ChartForm.ME_Longs.AddXY(i, indicatorSimulationResultsInSample.MFE_Longs[i] -
              indicatorSimulationResultsInSample.MUE_Longs[i]);
            ChartForm.ME_Shorts.AddXY(i, indicatorSimulationResultsInSample.MFE_Shorts[i]
              - indicatorSimulationResultsInSample.MUE_Shorts[i]);
          end;
{$ENDIF}
          FormTradeGrid.TradeGrid.RowCount := 1;

          if MenuItem29.Checked then
          begin
            StatusLabel.Caption := 'Creating trade table entries';
            StatusLabel.Visible := True;
            ProgressBar1.Position := 0;
            ProgressBar1.Max :=
              length(indicatorSimulationResults.BalanceCurve) - 1;
          end;

{$IFDEF TACHART}

          Chart1.AxisList[1].Marks.Source := BalanceCurve.Source;
          zeroLine.Position := INITIAL_BALANCE;
          inSampleEndLine.Position := SimulationForm.EndInSampleCalendar.Date;
          OutOfSampleEndLine.Position :=
            SimulationForm.EndOutOfSampleCalendar.Date;
{$ENDIF}
          for i := 1 to length(indicatorSimulationResults.BalanceCurve) - 1 do
          begin

            if indicatorSimulationResults.trades[i - 1].orderType = BUY then
              positionType := 'BUY'
            else
              positionType := 'SELL';

            ylistBubble[0] := 10 / LoadedIndiHistoryData[symbol]
              .pointConversion;
            ylistBubble[1] := indicatorSimulationResults.trades[i - 1]
              .openPrice * 1.03;
 {$IFDEF TEECHART}
            ChartForm.GraphOpenTrades.AddXY(indicatorSimulationResults.trades[i - 1]
              .openTime * 100 / LoadedIndiHistoryData[symbol].pointConversion,
              ylistBubble[1],
//'');{$ELSE}ylistylistBubble,
              DateTimeToStr(indicatorSimulationResults.trades[i - 1].openTime) +             '- open ' + IntToStr(i));
              {$ENDIF}

            ylistBubble[0] := 10 / LoadedIndiHistoryData[symbol]
              .pointConversion;
            ylistBubble[1] := indicatorSimulationResults.trades[i - 1]
              .closePrice * 0.97;
 {$IFDEF TEECHART}
            ChartForm.GraphCloseTrades.AddXY(indicatorSimulationResults.trades[i - 1]
              .closeTime * 100 / LoadedIndiHistoryData[symbol].pointConversion,
              ylistBubble[1],
//'');//{$ELSE}ylistylistBubble,
 DateTimeToStr(indicatorSimulationResults.trades[i - 1].closeTime)              + '- close ' + IntToStr(i));
{$ENDIF}

 {$IF Defined(TEECHART) or Defined(TACHART)}
            SetLength(ChartForm.tradeLines, length(ChartForm.tradeLines) + 1);

            ChartForm.tradeLines[length(ChartForm.tradeLines) - 1] := TLineSeries.Create(ChartForm.ChartOHLC);

            with ChartForm.tradeLines[length(ChartForm.tradeLines) - 1] do
            begin
              LinePen.Width := 3;

              if indicatorSimulationResults.trades[i - 1].profit > 0 then
                LinePen.Color := clGreen
              else
                LinePen.Color := clRed;

              AddXY(indicatorSimulationResults.trades[i - 1].openTime * 100 /
                LoadedIndiHistoryData[symbol].pointConversion,
                indicatorSimulationResults.trades[i - 1].openPrice);
              AddXY(indicatorSimulationResults.trades[i - 1].closeTime * 100 /
                LoadedIndiHistoryData[symbol].pointConversion,
                indicatorSimulationResults.trades[i - 1].closePrice);
            end;

            ChartForm.ChartOHLC.AddSeries(ChartForm.tradeLines[length(ChartForm.tradeLines) - 1]);
            ChartForm.ChartOHLC.Repaint;

            // this line draws the balance curve
            ChartForm.BalanceCurve.AddXY(indicatorSimulationResults.trades[i - 1]
              .closeTime, indicatorSimulationResults.BalanceCurve[i],
              FormatDateTime('mm/yyyy', indicatorSimulationResults.trades[i - 1]
              .closeTime));

            if indicatorSimulationResultsInSample.linearFitR2 > 0.1 then
            begin
              ChartForm.upperStdDev.AddXY(indicatorSimulationResults.trades[i - 1]
                .closeTime, indicatorSimulationResultsInSample.linearFitSlope *
                (indicatorSimulationResults.trades[i - 1].closeTime -
                indicatorSimulationResults.trades[0].closeTime) +
                indicatorSimulationResultsInSample.linearFitIntercept -
                indicatorSimulationResultsInSample.standardDeviationResiduals,
                FormatDateTime('mm/yyyy', indicatorSimulationResults.trades
                [i - 1].closeTime));
              ChartForm.lowerStdDev.AddXY(indicatorSimulationResults.trades[i - 1]
                .closeTime, indicatorSimulationResultsInSample.linearFitSlope *
                (indicatorSimulationResults.trades[i - 1].closeTime -
                indicatorSimulationResults.trades[0].closeTime) +
                indicatorSimulationResultsInSample.linearFitIntercept -
                indicatorSimulationResultsInSample.standardDeviationResiduals *
                2, FormatDateTime('mm/yyyy', indicatorSimulationResults.trades
                [i - 1].closeTime));
              ChartForm.BalanceCurveFit.AddXY(indicatorSimulationResults.trades[i - 1]
                .closeTime, indicatorSimulationResultsInSample.linearFitSlope *
                (indicatorSimulationResults.trades[i - 1].closeTime -
                indicatorSimulationResults.trades[0].closeTime) +
                indicatorSimulationResultsInSample.linearFitIntercept,
                FormatDateTime('mm/yyyy', indicatorSimulationResults.trades
                [i - 1].closeTime));
            end;
 {$ENDIF}
            if MenuItem29.Checked then
            begin

              StatusLabel.Caption := 'Creating trade table entries ' +
                IntToStr(i) + '/' +
                IntToStr(length(indicatorSimulationResults.BalanceCurve) - 1);
              ProgressBar1.Position := ProgressBar1.Position + 1;

              if i Mod 10 = 0 then
                Application.ProcessMessages;

              with FormTradeGrid do
              begin
              TradeGrid.RowCount := TradeGrid.RowCount + 1;
              TradeGrid.Cells[0, TradeGrid.RowCount - 1] := IntToStr(i);
              TradeGrid.Cells[1, TradeGrid.RowCount - 1] :=
                DateTimeToStr(indicatorSimulationResults.trades[i - 1]
                .openTime);
              TradeGrid.Cells[2, TradeGrid.RowCount - 1] :=
                DateTimeToStr(indicatorSimulationResults.trades[i - 1]
                .closeTime);
              TradeGrid.Cells[3, TradeGrid.RowCount - 1] :=
                FloatToStr(Round(indicatorSimulationResults.trades[i - 1]
                .openPrice * 100000) / 100000);
              TradeGrid.Cells[4, TradeGrid.RowCount - 1] :=
                FloatToStr(Round(indicatorSimulationResults.trades[i - 1]
                .closePrice * 100000) / 100000);
              TradeGrid.Cells[5, TradeGrid.RowCount - 1] :=
                FloatToStr(Round(indicatorSimulationResults.trades[i - 1].sl *
                100000) / 100000) + ' (' +
                FloatToStr
                (Round(Abs(indicatorSimulationResults.trades[i - 1].openPrice -
                indicatorSimulationResults.trades[i - 1].sl) * 100000) /
                100000) + ')';
              TradeGrid.Cells[6, TradeGrid.RowCount - 1] :=
                FloatToStr(Round(indicatorSimulationResults.trades[i - 1].TP *
                100000) / 100000) + ' (' +
                FloatToStr
                (Round(Abs(indicatorSimulationResults.trades[i - 1].openPrice -
                indicatorSimulationResults.trades[i - 1].TP) * 100000) /
                100000) + ')';
              TradeGrid.Cells[7, TradeGrid.RowCount - 1] :=
                FloatToStr(Round(indicatorSimulationResults.trades[i - 1].profit
                * 100) / 100);
              TradeGrid.Cells[8, TradeGrid.RowCount - 1] := positionType;

              TradeGrid.Cells[9, TradeGrid.RowCount - 1] :=
                FloatToStr(Round(indicatorSimulationResults.trades[i - 1].volume
                * 100) / 100);

              end;
            end;

          end;
{$IFDEF TEECHART}
          ChartForm.Chart1.Axes.Bottom.Maximum := indicatorSimulationResults.trades
            [length(indicatorSimulationResults.trades) - 1].closeTime;
          ChartForm.Chart1.Axes.Bottom.Minimum  :=  indicatorSimulationResults.trades[0].closeTime;
  {$ENDIF}
{$IFDEF TACHART}
        Chart1.AxisList.BottomAxis.Range.Max
          := indicatorSimulationResults.trades
            [length(indicatorSimulationResults.trades) - 1].closeTime;
          Chart1.AxisList.BottomAxis.Range.Min
          :=  indicatorSimulationResults.trades[0].closeTime;
 {$ENDIF}
          // only show this info on trade analysis on click
          if MenuItem29.Checked then
          begin
         // plChartOHLC.Visible:=true;
          {
            ChartOHLC.Visible := True;
            LabelCheck.Visible := True;
            Button2.Visible := True;
            ohlcCheck.Visible := True;
          }
          end;

        end;

        // ShowMessage(FloatToStr(simulationResults.balanceCurve[Length(simulationResults.balanceCurve)-1])) ;


        // StatusLabel.Visible := false;

      end;
{$ENDIF}
end;

procedure TMainForm.showOrHideColumn(Sender: TObject);
var
  i: Integer;
begin

{$IFDEF DELPHI}
{$ELSE}
  if Sender is TMenuItem then
  begin
    with Sender as TMenuItem do
    begin
      for i := 0 to ResultsGrid.ColCount - 1 do
      begin

        if (ResultsGrid.Columns.Items[i].Title.Caption = Caption) and
          (ResultsGrid.Columns.Items[i].Visible = False) then
        begin
          ResultsGrid.Columns.Items[i].Visible := True;
          Checked := True;
          break;
        end;

        if (ResultsGrid.Columns.Items[i].Title.Caption = Caption) and
          (ResultsGrid.Columns.Items[i].Visible) then
        begin
          ResultsGrid.Columns.Items[i].Visible := False;
          Checked := False;
          break;
        end;

      end;
    end;

  end;
{$ENDIF}
end;

procedure TMainForm.ResultsGridCompareCells(Sender: TObject;
  ACol, ARow, BCol, BRow: Integer; var Result: Integer);
begin
  // if Assigned(ResultsGrid.OnCompareCells) then
  // Result:=inherited DoCompareCells(Acol, ARow, Bcol, BRow)
  // else begin
  try
    Result := CompareValue(StrToFloat(ResultsGrid.Cells[ACol, ARow]),
      StrToFloat(ResultsGrid.Cells[BCol, BRow]));
  Except
    Result := AnsiCompareText(ResultsGrid.Cells[ACol, ARow],
      ResultsGrid.Cells[BCol, BRow]);
  end;
{$IFDEF DELPHI}
{$ELSE}
  if ResultsGrid.SortOrder = soDescending then
    Result := -Result;
{$ENDIF}
end;

procedure TMainForm.ResultsGridGetCellHint(Sender: TObject; ACol, ARow: Integer;
  var HintText: String);
begin
  Case ACol of
    IDX_GRID_USE_IN_PORTFOLIO:
      HintText := 'Check to include system in custom portfolio to evaluate.';
    IDX_GRID_RESULT_NUMBER:
      HintText := 'The result number for this system';
    IDX_GRID_SYMBOL:
      HintText := 'Symbol used to create this system';
    IDX_GRID_PROFIT:
      HintText := 'Absolute profit in USD';
    IDX_GRID_PROFIT_PER_TRADE:
      HintText := 'Profit per trade in USD';
    IDX_GRID_PROFIT_LONGS:
      HintText := 'Number of profitable long trades';
    IDX_GRID_PROFIT_SHORTS:
      HintText := 'Number of profitable short trades';
    IDX_GRID_LONG_COUNT:
      HintText := 'Total number of long trades';
    IDX_GRID_SHORT_COUNT:
      HintText := 'Total number of short trades';
    IDX_GRID_TOTAL_COUNT:
      HintText := 'Total trade number';
    IDX_GRID_MAX_DRAWDOWN:
      HintText := 'Maximum drawdown as a percentage of the initial balance';
    IDX_GRID_ULCER_INDEX:
      HintText := 'Ulcer Index as devised by Peter Martin';
    IDX_GRID_MAX_DRAWDOWN_LENGTH:
      HintText := 'Maximum period length between balance highs in days';
    IDX_GRID_CONS_LOSS:
      HintText := 'Maximum number of consecutive losing trades';
    IDX_GRID_CONS_WIN:
      HintText := 'Maximum number of consecutive winning trades';
    IDX_GRID_PROFIT_TO_DD_RATIO:
      HintText :=
        'Absolute profit to maximum draw down ratio (do not confuse with AAR/MaxDD)';
    IDX_GRID_WINNING_PERCENT:
      HintText := 'Winning percentage from the total number of trades';
    IDX_GRID_REWARD_TO_RISK:
      HintText := 'Average win to loss ratio';
    IDX_GRID_SKEWNESS:
      HintText :=
        'A measure of the extent to which the trade return distribution is skewed relative to a normal distribution';
    IDX_GRID_KURTOSIS:
      HintText :=
        'A measure of how peaked or "fat tailed" a statistical distribution is';
    IDX_GRID_PROFIT_FACTOR:
      HintText := 'Ratio between gross profit and gross loss';
    IDX_GRID_STD_DEV:
      HintText := 'Standard deviation of all trades';
    IDX_GRID_STD_DEV_BREACH:
      HintText :=
        'Maximum level of multiples of the standard deviation of residuals of the linear regression that have been breached by the balance curve';
    IDX_GRID_TOTAL_ME:
      HintText :=
        'Total sum of all long and short mathematical expectancy values';
    IDX_GRID_LINEAR_FIT_R2:
      HintText :=
        'Square of the correlation coefficient for the calculated linear regression';
    IDX_GRID_SQN:
      HintText := 'System Quality Number as defined by Van Tharp ';
    IDX_GRID_MODIFIED_SHARPE_RATIO:
      HintText := 'Absolute profit over standard deviation';
    IDX_GRID_CUSTOM_CRITERIA:
      HintText := 'Custom criteria defined by the user (see menu)';
    IDX_GRID_OUT_OF_SAMPLE_PROFIT:
      HintText := 'Absolute profit of the out of sample period';
    IDX_GRID_OSP_PER_TRADE:
      HintText := 'Absolute profit per trade for the out of sample period';
    IDX_GRID_DAYS_OUT:
      HintText := 'Number of days that the system remained out of the market';
  end;
end;




procedure TMainForm.Button1Click(Sender: TObject);
begin
  isCancel := True;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin

FormTradeGrid.Show;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  configFile: TStringList;
  i: Integer;
begin

{$IFDEF DELPHI}
{$ELSE}
  DefaultFormatSettings.ShortDateFormat := 'yyyy.mm.dd';
  DefaultFormatSettings.DateSeparator := '.';
  DefaultFormatSettings.DecimalSeparator := '.';
{$ENDIF}
  SetCurrentDir(mainProgramFolder);

  configFile := TStringList.Create;

  for i := 1 to SimulationForm2.OptionsGrid.RowCount - 1 do
    configFile.Add(SimulationForm2.OptionsGrid.Cells[1, i]);

  for i := 1 to FiltersForm.FiltersGrid.RowCount - 1 do
  begin
    configFile.Add(FiltersForm.FiltersGrid.Cells[1, i]);
    configFile.Add(FiltersForm.FiltersGrid.Cells[2, i]);
    configFile.Add(FiltersForm.FiltersGrid.Cells[3, i]);
    configFile.Add(FiltersForm.FiltersGrid.Cells[4, i]);
  end;

  configFile.Add(CustomFilterForm.CustomFormulaEdit.Text);

{$IFDEF DELPHI}
{$ELSE}
  configFile.Add(DateTimeToStr(SimulationForm2.BeginInSampleCalendar.Date));
  configFile.Add(DateTimeToStr(SimulationForm2.EndInSampleCalendar.Date));
  configFile.Add(DateTimeToStr(SimulationForm2.EndOutOfSampleCalendar.Date));
{$ENDIF}
  configFile.Add(IntToStr(SimulationForm2.OptTargetComboBox.ItemIndex));
  configFile.Add(BoolToStr(SimulationForm2.UseSLCheck.Checked));
  configFile.Add(BoolToStr(SimulationForm2.UseTPCheck.Checked));
  configFile.Add(BoolToStr(SimulationForm2.UseHourFilter.Checked));
  configFile.Add(BoolToStr(SimulationForm2.UseDayFilter.Checked));
  configFile.Add(BoolToStr(SimulationForm2.LROriginCheck.Checked));
  configFile.Add(BoolToStr(SimulationForm2.UseFixedSLTP.Checked));
  configFile.Add(BoolToStr(SimulationForm2.UseFixedHour.Checked));

{$IFDEF DELPHI}
{$ELSE}
  for i := 0 to ResultsGrid.ColCount - 1 do
    configFile.Add(BoolToStr(ResultsGrid.Columns.Items[i].Visible));
{$ENDIF}
  configFile.Add(BoolToStr(FiltersForm.isLastYearProfitCheck.Checked));

  // configFile.SaveToFile('config.ini');

  configFile.Free;

end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
{$IFDEF DELPHI}
  for i := Low(ResultNames) to High(ResultNames) do
    ResultsGrid.Cells[i , 0] := ResultNames[i];
 {$IFNDEF LLCL}

{$ENDIF}
{$ENDIF}
  // MainForm.Enabled := False;

end;

procedure TMainForm.MenuItem11Click(Sender: TObject);
begin

  Case simulationType of
    SIMULATION_TYPE_INDICATORS:
      ShowIndicatorPatternDecomposition;
  else
    ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem13Click(Sender: TObject);
begin
{$IFDEF DELPHI}
{$ELSE}
  if SaveDialog1.Execute then
    ResultsGrid.SaveToCSVFile(SaveDialog1.FileName);
{$ENDIF}
end;

procedure TMainForm.FinaMainSymbol(Sender: TObject);
var
  i: Integer;
begin

  if CheckBeforeSimulation = False then
    exit;
  SimulationForm.EndOutOfSampleCalendar.Text := DateToStr(Now);

  // match everything between normal and ghost forms
  for i := 1 to SimulationForm2.OptionsGrid.RowCount - 1 do
  begin
    SimulationForm.OptionsGrid.Cells[1, i] :=
      SimulationForm2.OptionsGrid.Cells[1, i];
  end;

  if isDataLoaded = False then
  begin
    ShowMessage('Please load data before running a simulation.');
    exit;
  end;

  Case simulationType of
    SIMULATION_TYPE_INDICATORS:
      runIndiSimulationFixedQuota(False);
  else
    ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem17Click(Sender: TObject);
begin

  if CheckBeforeSimulation = False then
    exit;

  SimulationForm.EndOutOfSampleCalendar.Text := DateToStr(Now);

  begin
    ShowMessage('Please load data before running a simulation.');
    exit;
  end;

  Case simulationType of
    SIMULATION_TYPE_INDICATORS:
      runIndiSimulationFixedQuota(True);
  else
    ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem18Click(Sender: TObject);
begin
  FiltersForm.Visible := True;
end;

procedure TMainForm.MenuItem19Click(Sender: TObject);
begin
  CustomFilterForm.Visible := True;
end;

procedure TMainForm.MenuItem20Click(Sender: TObject);
begin

  // OpenURL('');
   ShowMessage  ('OpenKantu, an open source price-action based system generator ');
end;

procedure TMainForm.MenuItem23Click(Sender: TObject);
begin
  ExportToMQL4;
end;

procedure TMainForm.MenuItem28Click(Sender: TObject);
var
  i: Integer;
begin

  if CheckBeforeSimulation = False then
    exit;

  if isDataLoaded = False then
  begin
    ShowMessage('Please load data before running a simulation.');
    exit;
  end;

  for i := 1 to SimulationForm2.OptionsGrid.RowCount - 1 do
  begin
    SimulationForm.OptionsGrid.Cells[1, i] :=
      SimulationForm2.OptionsGrid.Cells[1, i];
  end;

  Case simulationType of
    SIMULATION_TYPE_INDICATORS:
      runIndicatorSimulationFixedQuotaMultipleSymbols;
  else
    ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem29Click(Sender: TObject);
begin

  MenuItem29.Checked := not MenuItem29.Checked;

end;

procedure TMainForm.MenuItem30Click(Sender: TObject);
begin

  Case simulationType of
    SIMULATION_TYPE_INDICATORS:
      ShowIndicatorPatternPortfolioResult;
  else
    ShowMessage('no valid simulation type selected');
  end;

end;

procedure TMainForm.MenuItem35Click(Sender: TObject);
begin
  SingleSystem.Visible := True;
end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin

  SimulationForm2.Visible := True;
end;

end.
