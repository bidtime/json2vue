unit uParserTxt;

interface

uses classes, Generics.Collections;

type
  TParserTxt = class(TObject)
  protected
    //class var FMaxId: Int64;
    FList: TList;
    FMapPK: TDictionary<String, String>;
    FMapColumn: TDictionary<String, String>;
    //FContext: TStrings;
    FColumns: TStrings;
    //
    FOnLine: TGetStrProc;
    FOnValidLine: TGetStrProc;
  public
    FTableName: string;
    FComment: string;
  public
    class constructor Create;
    constructor Create;
    destructor Destroy; override;
    //
    //procedure addColumn(const u: TColumnPro);
    procedure setContent(const strs: TStrings); virtual; abstract;
  public
    property List: TList read FList write FList;
    property MapPK: TDictionary<String, String> read FMapPK write FMapPK;
    property MapColumn: TDictionary<String, String> read FMapColumn write FMapColumn;
    property Context: TStrings write setContent;
    property Columns: TStrings read FColumns write FColumns;
    property OnLine: TGetStrProc read FOnLine write FOnLine;
    property OnValidLine: TGetStrProc read FOnValidLine write FOnValidLine;
  end;

implementation

uses SysUtils;

{ TCarBrand }

class constructor TParserTxt.Create;
begin
  //FMaxId := 67541628411220000;
end;

constructor TParserTxt.Create;
begin
  //inherited Create;
  FList := TList.Create;
  FMapPK := TDictionary<String, String>.Create;
  FMapColumn:= TDictionary<String, String>.Create;
end;

destructor TParserTxt.Destroy;
begin
  FList.Free;
  FMapPK.Free;
  FMapColumn.Free;
end;

procedure TParserTxt.doOnLine(const S: string);
begin
  if Assigned(FOnLine) then begin
    FOnLine(S);
  end;
end;

procedure TParserTxt.doOnValidLine(const S: string);
begin
  if Assigned(FOnValidLine) then begin
    FOnValidLine(S);
  end;
end;

{procedure TParserTxt.addColumn(const u: TColumnPro);
begin
  FList.Add(u);
end;}

end.

