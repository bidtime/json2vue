program json2vue;

uses
  Forms,
  uFrmSetting in 'src\frm\uFrmSetting.pas' {frmSetting},
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
  uParserQuery in 'src\utils\uParserQuery.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSDIAppForm, SDIAppForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TFrmSetting, FrmSetting);
  Application.Run;
end.
