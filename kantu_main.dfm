object MainForm: TMainForm
  Left = 740
  Top = 473
  Caption = 'Kantu'
  ClientHeight = 460
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poDesktopCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OutOfSampleAnalysisLabel: TLabel
    Left = 21
    Top = 296
    Width = 3
    Height = 13
    Color = clBtnFace
    ParentColor = False
  end
  object extraLabel: TLabel
    Left = 657
    Top = 2
    Width = 214
    Height = 19
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
  end
  object selectedPatternLabel: TLabel
    Left = 559
    Top = 4
    Width = 6
    Height = 13
    Caption = '0'
    Color = clBtnFace
    ParentColor = False
    Visible = False
  end
  object StatusLabel: TLabel
    Left = 288
    Top = 2
    Width = 265
    Height = 19
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
  end
  object ResultsGrid: TStringGrid
    Left = 0
    Top = 65
    Width = 677
    Height = 395
    Align = alClient
    ColCount = 57
    RowCount = 2
    FixedRows = 0
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    TabOrder = 0
    OnClick = ResultsGridClick
  end
  object plStatus: TPanel
    Left = 0
    Top = 0
    Width = 677
    Height = 65
    Align = alTop
    Caption = ' '
    TabOrder = 1
  end
  object Button3: TButton
    Left = 8
    Top = 0
    Width = 105
    Height = 25
    Caption = 'Trade Analysis'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button1: TButton
    Left = 44
    Top = 31
    Width = 75
    Height = 18
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqDraft
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 125
    Top = 31
    Width = 316
    Height = 23
    TabOrder = 4
  end
  object MainMenu1: TMainMenu
    Left = 112
    Top = 240
    object MenuItem1: TMenuItem
      Caption = 'Simulation'
      object MenuItem3: TMenuItem
        Caption = 'Options'
        OnClick = MenuItem3Click
      end
      object MenuItem5: TMenuItem
        Caption = 'Filters'
        object MenuItem18: TMenuItem
          Caption = 'Define filters'
          OnClick = MenuItem18Click
        end
        object MenuItem19: TMenuItem
          Caption = 'Define Custom Filter'
          OnClick = MenuItem19Click
        end
      end
      object MenuItem8: TMenuItem
        Caption = 'Find Systems'
        object MenuItem16: TMenuItem
          Caption = 'Main Symbol'
          OnClick = FinaMainSymbol
        end
        object MenuItem28: TMenuItem
          Caption = 'Multiple Symbol'
          OnClick = MenuItem28Click
        end
      end
      object MenuItem35: TMenuItem
        Caption = 'Run Single System'
        OnClick = MenuItem35Click
      end
    end
    object MenuItem9: TMenuItem
      Caption = 'Selection'
      object MenuItem23: TMenuItem
        Caption = 'Export to MQL4'
        OnClick = MenuItem23Click
      end
      object MenuItem11: TMenuItem
        Caption = 'Show Pattern Composition'
        OnClick = MenuItem11Click
      end
      object MenuItem29: TMenuItem
        Caption = 'Show Trade Analysis on Click'
        OnClick = MenuItem29Click
      end
      object MenuItem30: TMenuItem
        Caption = 'Show Portfolio Result'
        OnClick = MenuItem30Click
      end
    end
    object MenuItem2: TMenuItem
      Caption = 'History'
      object MenuItem4: TMenuItem
        Caption = 'Load Symbol'
        OnClick = showloadSymbol
      end
    end
    object MenuItem20: TMenuItem
      Caption = 'More information...'
      OnClick = MenuItem20Click
    end
  end
  object OpenSymbolHistoryDialog: TOpenDialog
    DefaultExt = '.csv'
    Filter = 'History data file|*.csv'
    Left = 312
    Top = 200
  end
  object SaveDialog1: TSaveDialog
    Left = 304
    Top = 152
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 264
    object MenuItem13: TMenuItem
      Caption = 'Save contents to CSV'
      OnClick = MenuItem13Click
    end
    object MenuItem37: TMenuItem
      Caption = 'Hide/Show Columns'
      object MenuItem38: TMenuItem
        Caption = 'Abs. Profit'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem39: TMenuItem
        Caption = 'Profit/trade'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem40: TMenuItem
        Caption = 'Profit Longs'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem41: TMenuItem
        Caption = 'Profit Shorts'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem42: TMenuItem
        Caption = 'No. Longs'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem43: TMenuItem
        Caption = 'No. Shorts'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem44: TMenuItem
        Caption = 'Total Trades'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem45: TMenuItem
        Caption = 'Max DD'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem46: TMenuItem
        Caption = 'Ideal R'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem47: TMenuItem
        Caption = 'R^2'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem48: TMenuItem
        Caption = 'Ulcer Index'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem49: TMenuItem
        Caption = 'Max DD Length'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem50: TMenuItem
        Caption = 'Cons.Loss'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem52: TMenuItem
        Caption = 'Cons.Wins'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem53: TMenuItem
        Caption = 'Profit:MaxDD'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem54: TMenuItem
        Caption = 'Win %'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem51: TMenuItem
        Caption = 'Reward:Risk'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem56: TMenuItem
        Caption = 'Skewness'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem57: TMenuItem
        Caption = 'Kurtosis'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem58: TMenuItem
        Caption = 'PF'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem55: TMenuItem
        Caption = 'Std. Dev'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem60: TMenuItem
        Caption = 'Std.Dev.Breach'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem59: TMenuItem
        Caption = 'Total ME'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem62: TMenuItem
        Caption = 'SQN'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem63: TMenuItem
        Caption = 'Mod. Sharpe Ratio'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem61: TMenuItem
        Caption = 'Custom Criteria'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem64: TMenuItem
        Caption = 'Bars out'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem65: TMenuItem
        Caption = 'OSP'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem66: TMenuItem
        Caption = 'OSP/trade'
        Checked = True
        OnClick = showOrHideColumn
      end
      object MenuItem67: TMenuItem
        Caption = 'Lowest Lag'
        Checked = True
        OnClick = showOrHideColumn
      end
    end
  end
  object OpenKantuLibraryDialog: TOpenDialog
    Left = 448
    Top = 208
  end
  object SaveDialogMQL4: TSaveDialog
    DefaultExt = '.mq4'
    Filter = '*.mq4'
    Left = 472
    Top = 152
  end
  object PopupMenu2: TPopupMenu
    Left = 520
    Top = 280
    object MenuItem24: TMenuItem
      Caption = 'Save contents to CSV'
    end
  end
  object PopupMenu4: TPopupMenu
    Left = 448
    Top = 280
    object MenuItem26: TMenuItem
      Caption = 'Save contents to CSV'
    end
  end
  object PopupMenu6: TPopupMenu
    Left = 310
    Top = 269
    object MenuItem34: TMenuItem
      Caption = 'Save contents to CSV'
    end
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'csv|*.csv'
    Left = 398
    Top = 150
  end
end
