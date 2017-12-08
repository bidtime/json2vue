program json2vue;

uses
  Forms,
  uCharSplit in 'src\utils\uCharSplit.pas',
  uCharUtils in 'src\utils\uCharUtils.pas',
  uFrmSetting in 'src\frm\uFrmSetting.pas' {frmSetting},
  uBean in 'src\utils\uBean.pas',
  uBeanPro in 'src\utils\uBeanPro.pas',
  ABOUT in 'src\frm\ABOUT.PAS' {AboutBox},
  SDIMAIN in 'src\SDIMAIN.PAS' {SDIAppForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSDIAppForm, SDIAppForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TFrmSetting, FrmSetting);
  Application.Run;
end.
