unit uFrmSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmSetting = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    cbxTinyIntType: TComboBox;
    Label2: TLabel;
    cbxBitType: TComboBox;
    Label1: TLabel;
    cbxSmallInt: TComboBox;
    Label4: TLabel;
    cbxBigInt: TComboBox;
    Label5: TLabel;
    cbxDecimal: TComboBox;
    Label6: TLabel;
    cbxTimestamp: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FBName: string;
    function getAppPath(): string;
    procedure ctrl_file(const bWrite: boolean=false);
  public
    { Public declarations }
    procedure setFPath(const S: string);
    procedure finish(const ctx: string);
    //
    function getBit(): string;
    function getSmallInt(): string;
    function getTinyInt(): string;
    function getBigInt(): string;
    function getTimeStamp(): string;
    function getDecimal(): string;
  end;

var frmSetting: TFrmSetting;

implementation

uses IniFiles;

{$R *.dfm}

{ TfrmSetting }

function readFromFile(const fname: string): string;
var strs: TStrings;
begin
  strs := TStringList.Create;
  try
    strs.LoadFromFile(fname);
    Result := strs.Text;
  finally
    strs.Free;
  end;
end;

procedure saveToFile(const fname, ctx: string);
var strs: TStrings;
begin
  strs := TStringList.Create;
  try
    strs.Text := ctx;
    strs.SaveToFile(fname, TEncoding.UTF8);
  finally
    strs.Free;
  end;
end;

procedure TfrmSetting.Button1Click(Sender: TObject);
begin
  ctrl_file(true);
  ModalResult := mrOK;
end;

procedure TfrmSetting.Button2Click(Sender: TObject);
begin
  ctrl_file();
  ModalResult := mrCancel;
end;

procedure TfrmSetting.ctrl_file(const bWrite: boolean);
var myIniFile: TIniFile;
  i: integer;
  ctrl: TControl;
begin
 myIniFile := Tinifile.create(self.FBName);
 try
   for I := 0 to self.GroupBox1.ControlCount - 1 do begin
     ctrl := GroupBox1.Controls[I];
     if (ctrl is TComboBox) then begin
       if bWrite then begin
         myIniFile.WriteString('combox', TComboBox(ctrl).Name, TComboBox(ctrl).Text);
       end else begin
         TComboBox(ctrl).Text := myIniFile.ReadString('combox', TComboBox(ctrl).Name, TComboBox(ctrl).Text);
       end;
     end;
   end;
 finally
   myIniFile.Free;
 end;
end;

procedure TfrmSetting.finish(const ctx: string);
begin
  saveToFile(FBName, ctx);
end;

procedure TfrmSetting.FormCreate(Sender: TObject);
begin
  setFPath(getAppPath());
  ctrl_file();
end;

function TfrmSetting.getAppPath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

function TfrmSetting.getBigInt: string;
begin
  Result := self.cbxBigInt.Text;
end;

function TfrmSetting.getBit: string;
begin
  Result := self.cbxBitType.Text;
end;

function TfrmSetting.getDecimal: string;
begin
  Result := self.cbxDecimal.Text;
end;

function TfrmSetting.getSmallInt: string;
begin
  Result := self.cbxSmallInt.Text;
end;

function TfrmSetting.getTimeStamp: string;
begin
  Result := self.cbxTimestamp.Text;
end;

function TfrmSetting.getTinyInt: string;
begin
  Result := self.cbxTinyIntType.Text;
end;

procedure TfrmSetting.setFPath(const S: string);
begin
  FBName := S + '\' + 'setting.ini';
end;

end.
