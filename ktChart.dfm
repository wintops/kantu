object ChartForm: TChartForm
  Left = 0
  Top = 0
  Caption = 'Chart'
  ClientHeight = 475
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 495
    Height = 475
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 892
    ExplicitHeight = 1152
    object TabSheet3: TTabSheet
      Caption = 'Balance Curve'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 884
      ExplicitHeight = 1124
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 487
        Height = 447
        Legend.Title.Text.Strings = (
          'Balance')
        Legend.Visible = False
        Title.Text.Strings = (
          ' ')
        BottomAxis.Title.Caption = 'Date'
        LeftAxis.Title.Caption = 'Balance'
        View3D = False
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 884
        ExplicitHeight = 1124
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object BalanceCurve: TLineSeries
          Brush.BackColor = clDefault
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Mathematical Expectancy'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 884
      ExplicitHeight = 1124
      object Chart2: TChart
        Left = 0
        Top = 0
        Width = 487
        Height = 447
        Legend.Visible = False
        Title.Text.Strings = (
          ' ')
        BottomAxis.Title.Caption = 'Bas from entry'
        LeftAxis.Title.Caption = 'Total ME(MFE-MAE)'
        View3D = False
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 884
        ExplicitHeight = 1124
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object ME_Shorts: TBarSeries
          Marks.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
        object ME_Longs: TBarSeries
          Marks.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Simulation Results'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 884
      ExplicitHeight = 1124
      object plChartOHLC: TPanel
        Left = 0
        Top = 0
        Width = 487
        Height = 447
        Align = alClient
        Caption = 'plChartOHLC'
        TabOrder = 0
        ExplicitWidth = 884
        ExplicitHeight = 1124
        object ChartOHLC: TChart
          Left = 1
          Top = 1
          Width = 485
          Height = 445
          Legend.Visible = False
          Title.Text.Strings = (
            ' ')
          View3D = False
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 882
          ExplicitHeight = 1122
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object GraphOHLC_Up: TBarSeries
            MultiBar = mbNone
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Bar'
            YValues.Order = loNone
          end
          object GraphOHLC_Down: TBarSeries
            MultiBar = mbNone
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Bar'
            YValues.Order = loNone
          end
          object GraphOpenTrades: TBubbleSeries
            Marks.Frame.Visible = False
            ClickableLine = False
            Pointer.HorizSize = 27
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.VertSize = 27
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
            RadiusValues.Name = 'Radius'
            RadiusValues.Order = loNone
          end
          object GraphCloseTrades: TBubbleSeries
            Marks.Frame.Visible = False
            ClickableLine = False
            Pointer.HorizSize = 34
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.VertSize = 34
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
            RadiusValues.Name = 'Radius'
            RadiusValues.Order = loNone
          end
        end
        object LabelCheck: TCheckBox
          Left = 210
          Top = 0
          Width = 177
          Height = 29
          Caption = 'Show Trade Labels'
          TabOrder = 1
          OnClick = LabelCheckClick
        end
        object ohlcCheck: TCheckBox
          Left = 26
          Top = 0
          Width = 125
          Height = 29
          Caption = 'Show OHLC'
          TabOrder = 2
          OnClick = ohlcCheckClick
        end
      end
    end
  end
  object PopupMenu7: TPopupMenu
    Left = 95
    Top = 29
    object MenuItem33: TMenuItem
      Caption = 'Save graph to BMP'
      OnClick = MenuItem33Click
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 160
    Top = 32
  end
end
