program json2vue;

uses
  Forms,
  uParserBase in 'src\utils\uParserBase.pas',
  uBeanPro in 'src\utils\uBeanPro.pas',
  ABOUT in 'src\frm\ABOUT.PAS' {AboutBox},
  SDIMAIN in 'src\SDIMAIN.PAS' {SDIAppForm},
  HtmlParser_XE3UP in '..\delphiutils\src\utils\HtmlParser_XE3UP.pas',
  uNetHttpClt in '..\delphiutils\src\utils\uNetHttpClt.pas',
  uNetUtils in '..\delphiutils\src\utils\uNetUtils.pas',
  uFileUtils in '..\delphiutils\src\utils\uFileUtils.pas',
  uCharSplit in '..\delphiutils\src\utils\uCharSplit.pas',
  uParserUtils in '..\delphiutils\src\utils\uParserUtils.pas',
  uParserQuery in 'src\utils\uParserQuery.pas',
  uFrmSetting in 'src\frm\uFrmSetting.pas' {frmSetting},
  uFrameMemo in 'src\frm\uFrameMemo.pas' {Frame2: TFrame},
  uIntfaceFull in 'src\utils\uIntfaceFull.pas',
  uCharUtils in '..\delphiutils\src\utils\uCharUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSDIAppForm, SDIAppForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TFrmSetting, FrmSetting);
  Application.CreateForm(TfrmSetting, frmSetting);
  Application.Run;
end.
