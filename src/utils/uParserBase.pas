unit uParserBase;

interface

uses classes, Generics.Collections;

type
  TParserBase = class(TObject)
  protected
    //class var FMaxId: Int64;
    FList: TList;
    FMapProp: TDictionary<String, String>;
    FMapColumn: TDictionary<String, String>;
    FColumns: TStrings;
    //
    FOnLine: TGetStrProc;
    FOnResultLine: TGetStrProc;
    procedure doOnLine(const S: string);
    procedure doOnResultLine(const S: string);
    //
    procedure setContent(const strs: TStrings); virtual; abstract;
    procedure setColumn(const str: String);
  public
    FTableName: string;
    FComment: string;
    procedure initial(const S: string);
  public
    class constructor Create;
    constructor Create;
    destructor Destroy; override;
  public
    property List: TList read FList write FList;
    property MapProp: TDictionary<String, String> read FMapProp write FMapProp;
    property MapColumn: TDictionary<String, String> read FMapColumn write FMapColumn;
    property Context: TStrings write setContent;
    property Columns: String write setColumn;
    property OnLine: TGetStrProc read FOnLine write FOnLine;
    property OnResultLine: TGetStrProc read FOnResultLine write FOnResultLine;
  end;

implementation

uses SysUtils, uCharSplit;

{ TCarBrand }

class constructor TParserBase.Create;
begin
  //FMaxId := 67541628411220000;
end;

constructor TParserBase.Create;
begin
  //inherited Create;
  FList := TList.Create;
  FColumns := TStringList.Create;
  FMapProp := TDictionary<String, String>.Create;
  FMapColumn:= TDictionary<String, String>.Create;
end;

destructor TParserBase.Destroy;
begin
  FList.Free;
  FMapProp.Free;
  FColumns.Free;
  FMapColumn.Free;
end;

procedure TParserBase.doOnLine(const S: string);
begin
  if Assigned(FOnLine) then begin
    FOnLine(S);
  end;
end;

procedure TParserBase.doOnResultLine(const S: string);
begin
  if Assigned(FOnResultLine) then begin
    FOnResultLine(S);
  end;
end;

procedure TParserBase.initial(const S: string);
begin
  self.FMapProp.Add('序号', 'type="index"');
end;

procedure TParserBase.setColumn(const str: String);
var i: integer;
  ss: TStrings;
  S: string;
begin
  FMapColumn.Clear;
  FColumns.Clear;
  ss := TStringList.Create();
  try
    TCharSplit.SplitChar(str, #9, ss);
    for I := 0 to ss.Count - 1 do begin
      s := ss[I];
      FMapColumn.AddOrSetValue(S, S);
      FColumns.Add(S);
    end;
  finally
   ss.Free;
  end;
end;

end.

