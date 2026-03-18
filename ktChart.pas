unit ktChart;

interface

uses

{$IFDEF DELPHI}
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,   Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Menus,
{$ELSE}
  lclintf,   FileUtil, TAGraph, TASeries ,

 // ZMConnection, laz_synapse
{$ENDIF}
{$IFDEF TACHART}
  TAGraph, TASeries,
  TAFuncSeries, TAMultiSeries, TATools, TASources,
{$ENDIF}
{$IFDEF TEECHART}
  VclTee.TeeGDIPlus, VclTee.Series,  VclTee.TeEngine,
  VclTee.TeeProcs, VclTee.Chart,VCLTee.BubbleCh;
{$ENDIF}


type
  TChartForm = class(TForm)
    plChartOHLC: TPanel;
    LabelCheck: TCheckBox;
    ohlcCheck: TCheckBox;
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    Chart1: TChart;
    ChartOHLC: TChart;

    TabSheet4: TTabSheet;
    BalanceCurve: TLineSeries;
    ME_Shorts: TBarSeries;
    ME_Longs: TBarSeries;
    TabSheet2: TTabSheet;
   GraphOHLC_Up: TBarSeries;
    GraphOHLC_Down: TBarSeries;
        GraphOpenTrades: TBubbleSeries;
    GraphCloseTrades: TBubbleSeries;
    PopupMenu7: TPopupMenu;
    MenuItem33: TMenuItem;
    SaveDialog1: TSaveDialog;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LabelCheckClick(Sender: TObject);
    procedure ohlcCheckClick(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
  private
    { Private declarations }
  public





    tradeLines: array of TLineSeries;

    // BalanceCurve: TLineSeries;
    BalanceCurveFit: TLineSeries;
    BalanceCurveFitPortfolio: TLineSeries;
    BalanceCurvePortfolio: TLineSeries;


    upperStdDev: TLineSeries;
    lowerStdDev: TLineSeries;

  {$IFDEF TEECHART}

   // ME_Shorts: TBarSeries;
   // ME_Longs: TBarSeries;
   // GraphOHLC_Up: TLineSeries;
   // GraphOHLC_Down: TLineSeries;
    inSampleEndLine: TLineSeries;
    OutOfSampleEndLine: TLineSeries;
    zeroLine: TLineSeries;

{$ENDIF}




{$IFDEF TACHART}



    GraphOpenTrades: TBubbleSeries;
    GraphCloseTrades: TBubbleSeries;
    GraphOHLC_Up: TBoxAndWhiskerSeries;
    GraphOHLC_Down: TBoxAndWhiskerSeries;
    inSampleEndLine: TConstantLine;
    OutOfSampleEndLine: TConstantLine;
    zeroLine: TConstantLine;
{$ENDIF}
  end;

var
  ChartForm: TChartForm;

implementation

{$IFDEF DELPHI}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

procedure TChartForm.FormCreate(Sender: TObject);
begin
{$IFDEF TEECHART}
  // BalanceCurve := TLineSeries.Create(Chart1);
  BalanceCurveFit := TLineSeries.Create(Chart1);
  BalanceCurveFitPortfolio := TLineSeries.Create(Chart1);
  BalanceCurvePortfolio := TLineSeries.Create(Chart1);

  upperStdDev := TLineSeries.Create(Chart1);
  lowerStdDev := TLineSeries.Create(Chart1);

  inSampleEndLine := TLineSeries.Create(Chart1);
  OutOfSampleEndLine := TLineSeries.Create(Chart1);
  zeroLine := TLineSeries.Create(Chart1);

  //ME_Shorts := TBarSeries.Create(ChartOHLC);
  //ME_Longs := TBarSeries.create(ChartOHLC);

 //GraphOpenTrades := TBubbleSeries.Create(ChartOHLC);
 // GraphCloseTrades := TBubbleSeries.Create(ChartOHLC);
// GraphOHLC_Up := TLineSeries.Create(ChartOHLC);
 // GraphOHLC_Down := TLineSeries.Create(ChartOHLC);

{$ENDIF}
end;

procedure TChartForm.FormDestroy(Sender: TObject);
begin
{$IFDEF TEECHART}
 //  BalanceCurve.Free;
  BalanceCurveFit.Free;
  BalanceCurveFitPortfolio.Free;
  BalanceCurvePortfolio.Free;

 //GraphOpenTrades.Free;
 //GraphCloseTrades.Free;
  upperStdDev.Free;
  lowerStdDev.Free;
 // ME_Shorts.Free;
 // ME_Longs.Free;
//GraphOHLC_Up.Free;
 //GraphOHLC_Down.Free;
  inSampleEndLine.Free;
  OutOfSampleEndLine.Free;
  zeroLine.Free;

{$ENDIF}
end;

procedure TChartForm.LabelCheckClick(Sender: TObject);
begin
{$IFDEF TEECHART}

    GraphOpenTrades.Visible := LabelCheck.Checked;
    GraphCloseTrades.Visible := LabelCheck.Checked;


{$ENDIF}
end;

procedure TChartForm.MenuItem33Click(Sender: TObject);
begin
 {$IFDEF TEECHART}
  if SaveDialog1.Execute then
     Chart1.SaveToBitmapFile(SaveDialog1.FileName);
{$ENDIF}
end;

procedure TChartForm.ohlcCheckClick(Sender: TObject);
begin
{$IFDEF DELPHI}
    GraphOHLC_Up.Visible := ohlcCheck.Checked;
    GraphOHLC_Down.Visible := ohlcCheck.Checked;
{$ELSE}

    GraphOHLC_Up.Active := ohlcCheck.Checked;
    GraphOHLC_Down.Active := ohlcCheck.Checked;

{$ENDIF}
{$IFDEF TEECHART}
  ChartOHLC.Repaint;
{$ENDIF}
end;

end.
