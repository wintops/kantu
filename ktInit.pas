unit ktInit;

interface

uses SysUtils, Classes, Forms,
  kantu_singleSystem, kantu_indicators, kantu_loadsymbol,
  kantu_definitions, kantu_main;

procedure init;
procedure start;

implementation

procedure assignMainCaption();
begin
  MainForm.Caption := KANTU_NAME;
end;

function slash(value: string): string;
begin
  if (value = '') then
    result := ''
  else
  begin
{$IFDEF WINDOWS}
    if (value[length(value)] <> '\') then
      result := value + '\'
{$ELSE}
    if (value[length(value)] <> '/') then
      result := value + '/'
{$ENDIF}
    else
      result := value;
  end;
end;

function getinstalldir: string;
begin
  result := slash(extractfiledir(paramstr(0)));
end;

procedure setMainFolder;
{$IFDEF DARWIN}
var
  authenticationLoad: TStringList;
{$ENDIF}
begin

  mainProgramFolder := GetCurrentDir;

{$IFDEF DARWIN}
  MainForm.mainProgramFolder := copy(getinstalldir, 1,
    pos(extractfilename(paramstr(0)), getinstalldir) - 1);
  SetCurrentDir(copy(getinstalldir, 1, pos(extractfilename(paramstr(0)) +
    '.app/Contents/MacOS', getinstalldir) - 1));
{$ENDIF}
end;

procedure init;
begin
  Application.Title := KANTU_NAME;
  Randomize;
  // CheckValidity();
  assignMainCaption;

  MainForm.Enabled := true;
  setMainFolder;
 MainForm.parseConfig;


end;

procedure start;
begin
  loadSymbol.UpdateData(nil);


  loadSymbol.LoadData(nil);
  MainForm.FinaMainSymbol(nil);

  //LoadIndicatorsAndHistory(mainProgramFolder+'/data/RM409.TXT');
  //SingleSystem.SymbolsCombo.Items.Add('RM409');
  //SingleSystem.SymbolsCombo.ItemIndex := 0;
end;
end.
