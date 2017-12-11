unit uParserBase;

interface

uses classes, Generics.Collections, uIntfaceFull;

type
  TParserBase = class(TObject)
  private
  protected
    //class var FMaxId: Int64;
    FList: TList;
    FMapProp: TDictionary<String, String>;
    FMapColumn: TDictionary<String, String>;
    FColumns: TStrings;
    FFormName: string;
    FIntfaceFull: TIntfaceFull;
    //
    FOnLine: TGetStrProc;
    FOnResultLine: TGetStrProc;
    procedure doOnLine(const S: string);
    procedure doOnResultLine(const S: string);
    //
    procedure setContent(const strs: TStrings); virtual; abstract;
    procedure setColumn(const str: String);
    //
    function reqToConditionStr(const IntfaceFull: TIntfaceFull;
      const strsReq: TStrings): string;
    function reqToParamStr(const IntfaceFull: TIntfaceFull;
      const strsReq: TStrings): string;
    function reqToVarStr(const IntfaceFull: TIntfaceFull;
      const strsReq: TStrings): string;
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
  FFormName := 'form1';
  FIntfaceFull := TIntfaceFull.Create;
  FList := TList.Create;
  FColumns := TStringList.Create;
  FMapProp := TDictionary<String, String>.Create;
  FMapColumn:= TDictionary<String, String>.Create;
end;

destructor TParserBase.Destroy;
begin
  FIntfaceFull.Free;
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

function TParserBase.reqToVarStr(const IntfaceFull: TIntfaceFull;
    const strsReq: TStrings): string;

  function doOneIt(const S: string): string;
  const SS = '              %s: %s, ' + #13#10;
  var key: string;
  begin
    key := TCharSplit.getSplitIdx(S, #9, 0);
    Result := format(SS, [key, QuotedStr('')]);
  end;

var i: integer;
  S: string;
begin
  Result := #13#10;
  Result := Result + '            ' +
    FFormName + ' {' + #13#10;
  for I := 0 to strsReq.Count - 1 do begin
    S := strsReq[I];
    Result := result + doOneIt(S);
  end;
  Result := Result +
    '            ' +
    '},';
end;

function TParserBase.reqToParamStr(const IntfaceFull: TIntfaceFull;
    const strsReq: TStrings): string;

  function doOneIt(const S: string): string;
  const SS = '                  %s: this.%s.%s, ' + #13#10;
  var key: string;
  begin
    key := TCharSplit.getSplitIdx(S, #9, 0);
    Result := format(SS, [key, FFormName, key]);
  end;

var i: integer;
  S: string;
begin
  Result := #13#10;
  for I := 0 to strsReq.Count - 1 do begin
    S := strsReq[I];
    Result := result + doOneIt(S);
  end;
end;

function TParserBase.reqToConditionStr(const IntfaceFull: TIntfaceFull;
    const strsReq: TStrings): string;

  function doOneIt(const S: string): string;
  const llbeg = '    <el-form-item label="%s" prop="%s">';
  const input_edt = '      <el-input v-model="%s.%s" placeholder="%s" width="150" align="center"/>';
  const llend = '    </el-form-item>';
  var key, val: string;
    itemBeg, inputStr, itemEnd: string;
  begin
    key := TCharSplit.getSplitIdx(S, #9, 0);
    val := TCharSplit.getSplitIdx(S, #9, 1);
    itemBeg := format(llbeg, [val, key]);
    inputStr := format(input_edt, [FFormName, key, '请输入' + val]);
    itemEnd := llend;
    Result :=
      itemBeg + #13#10 +
      inputStr + #13#10 +
      itemEnd;
  end;

var i: integer;
  S: string;
begin
  Result := #13#10;
  Result := Result + #13#10 + '  //查询条件';
  S := '  <el-form :inline="true" :model="%s">';
  S := format(s, [FFormName]);
  Result := Result + S;
  for I := 0 to strsReq.Count - 1 do begin
    S := strsReq[I];
    Result := result + #13#10 + doOneIt(S);
  end;
  Result := Result + #13#10
     + '  </el-form>';
end;

end.

