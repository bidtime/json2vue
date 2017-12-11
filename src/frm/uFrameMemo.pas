unit uFrameMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, FireDAC.VCLUI.Memo;

type
  TFrame2 = class(TFrame)
    GroupBox1: TGroupBox;
    FDGUIxFormsMemo1: TFDGUIxFormsMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
