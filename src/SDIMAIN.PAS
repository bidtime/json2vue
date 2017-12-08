unit SDIMAIN;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.Menus, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ImgList, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin, System.ImageList,
  System.Actions, uBean, FireDAC.VCLUI.Memo;

type
  TSDIAppForm = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    StatusBar: TStatusBar;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    actSetting: TAction;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    actDoIt: TAction;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    FDGUIxFormsMemo2: TFDGUIxFormsMemo;
    GroupBox3: TGroupBox;
    FDGUIxFormsMemo3: TFDGUIxFormsMemo;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    FDGUIxFormsMemo1: TFDGUIxFormsMemo;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    GroupBox4: TGroupBox;
    FDGUIxFormsMemo4: TFDGUIxFormsMemo;
    Splitter4: TSplitter;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure actSettingExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actDoItExecute(Sender: TObject);
  private
    { Private declarations }
    FBean: TBean;
    //
    procedure showLog(const S: string);
    procedure doOnLine(const S: string);
    procedure doOnValidLine(const S: string);
    procedure showStatus(const S: string);
  public
    { Public declarations }
  end;

var
  SDIAppForm: TSDIAppForm;

implementation

uses About, uFrmSetting;

{$R *.dfm}

procedure TSDIAppForm.FileNew1Execute(Sender: TObject);
begin
  { Do nothing }
end;

procedure TSDIAppForm.FileOpen1Execute(Sender: TObject);
begin
  OpenDialog.Execute;
end;

procedure TSDIAppForm.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure TSDIAppForm.FormCreate(Sender: TObject);
begin
  FBean := TBean.Create;
  FBean.OnLine := doOnLine;
  FBean.OnValidLine := doOnValidLine;
//  self.WindowState := wsMaximized;
end;

procedure TSDIAppForm.FormDestroy(Sender: TObject);
begin
  FBean.Free;
end;

procedure TSDIAppForm.actDoItExecute(Sender: TObject);
begin
  FBean.Context := self.FDGUIxFormsMemo1.Lines;
end;

procedure TSDIAppForm.actSettingExecute(Sender: TObject);
begin
  frmSetting.ShowModal;
end;

procedure TSDIAppForm.doOnLine(const S: string);
begin
  showLog(S);
  showStatus(S);
end;

procedure TSDIAppForm.doOnValidLine(const S: string);
begin
  showLog(S);
  showStatus(S);
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TSDIAppForm.showLog(const S: string);
begin
  self.FDGUIxFormsMemo4.Lines.Add(S);
end;

procedure TSDIAppForm.showStatus(const S: string);
begin
  self.StatusBar.Panels[0].Text := S;
  Application.ProcessMessages;
end;

end.
