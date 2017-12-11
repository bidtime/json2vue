unit uParserQuery;

interface

uses classes, uParserBase;

type
  TEnumCtxType =(NONE, INFO, REQUEST, RESPONSE);
  TParserQuery = class(TParserBase)
  public
    class constructor Create;
    constructor Create;
    destructor Destroy; override;
    //
    procedure setContent(const strs: TStrings); override;
  end;

implementation

uses SysUtils, uCharSplit, uIntfaceFull;

{ TCarBrand }

class constructor TParserQuery.Create;
begin
  //FMaxId := 67541628411220000;
end;

constructor TParserQuery.Create;
begin
  inherited Create;
end;

destructor TParserQuery.Destroy;
begin
end;

  function getRightStr(const S: string; const sub: string): string;
  var n: integer;
  begin
    n := S.IndexOf(sub);
    if (n>=0) then begin
      Result := S.Substring(n+sub.Length).Trim;
    end else begin
      Result := '';
    end;
  end;

  function getRightStr2(const S: string; const sub: string; var str: string): boolean;
  var n: integer;
  begin
    n := S.IndexOf(sub);
    if (n>=0) then begin
      str := S.Substring(n+sub.Length).Trim;
      Result := true;
    end else begin
      str := S.Trim;
      Result := false;
    end;
  end;

  function getCommentOfChar(const S: string; const sub: string; var str: string): boolean;
  var getComment: boolean;
    tmp: string;
  begin
    getComment := getRightStr2(S, sub, tmp);
    if getComment and (not tmp.isEmpty()) then begin
      Result := true;
    end else begin
      Result := false;
    end;
  end;

procedure TParserQuery.setContent(const strs: TStrings);

  procedure doResponsePre(const IntfaceFull: TIntfaceFull; const strsReq: TStrings);
  var S: string;
  begin
    doOnResultLine('<template>');
    doOnResultLine('');
    doOnResultLine('<div>');
    //conditon
    doOnResultLine(reqToConditionStr(IntfaceFull, strsReq));
    //query button
    doOnResultLine('');
    doOnResultLine('  //查询按钮');
    doOnResultLine('  <el-button @click="query">查询</el-button>');
    doOnResultLine('');
    doOnResultLine('  //表格数据');
    doOnResultLine('  <el-table :data="data" border>');
    doOnResultLine('');
    S := '      <el-table-column label="%s" align="center">';
    S := format(S, [IntfaceFull.Name]);
    doOnResultLine(S);
  end;

  procedure doResponseEnd(const IntfaceFull: TIntfaceFull;
      const strReqVar, strReqParam: String);
    const SCRIPT_= '' + #13#10 +
'<script>' + #13#10 +
'import axios from "axios";' + #13#10 +
'' + #13#10 +
'export default {' + #13#10 +
'    data(){' + #13#10 +
'        return {' + #13#10 +
'            data:[' + #13#10 +
'                {' + #13#10 +
'' + #13#10 +
'                }' + #13#10 +
'            ],' + #13#10 +
'            %s' + #13#10 +
'        }' + #13#10 +
'    },' + #13#10 +
'' + #13#10 +
'    methods:{' + #13#10 +
'        query(){' + #13#10 +
'            axios.%s("%s",{' + #13#10 +
'                params:{' + #13#10 +
'                  %s' + #13#10 +
'                }' + #13#10 +
'            }).then(res=>{' + #13#10 +
'                if(res.data.success){' + #13#10 +
'                    this.data = res.data.data;' + #13#10 +
'                }else {' + #13#10 +
'' + #13#10 +
'                }' + #13#10 +
'            }).catch()' + #13#10 +
'        }' + #13#10 +
'    },' + #13#10 +
'' + #13#10 +
'    components:{' + #13#10 +
'    },' + #13#10 +
'' + #13#10 +
'    created(){' + #13#10 +
'        this.query();' + #13#10 +
'    }' + #13#10 +
'' + #13#10 +
'</script>';

    function getScriptTag(): string;
    begin
      Result := format(SCRIPT_, [strReqVar, IntfaceFull.Method,
        IntfaceFull.Url, strReqParam]);
    end;
  begin
    doOnResultLine('      </el-table-column>');
    doOnResultLine('');
    doOnResultLine('  </el-table>');

    doOnResultLine('');

    doOnResultLine('</div>');

    doOnResultLine('');

    doOnResultLine('</template>');

    doOnResultLine(getScriptTag());

  end;

  procedure doResponseStrs(const strsResp: TStrings);
    function getElTable(const key, value: string): string;
    const EE1='        <el-table-column label="%s" prop="%s" align="left"></el-table-column>';
    const EE2='        <el-table-column label="%s" prop="%s" %s align="left"></el-table-column>';
    var ext: string;
    begin
      if not self.FMapProp.TryGetValue(value, ext) then begin
        Result := format(EE1, [value, key]);
      end else begin
        Result := format(EE2, [value, key, ext]);
      end;
    end;

    function doPerResponse(const S, oriTitle: string): boolean;
    var key, value: string;
    begin
      Result := false;
      key := TCharSplit.getSplitIdx(S, #9, 0);
      value := TCharSplit.getSplitIdx(S, #9, 1);
      if oriTitle.Equals(value) then begin
        doOnResultLine(getElTable(key, value));
        Result := true;
      end;
    end;

    function getItOfStrs(const oriTitle: string): boolean;
    var J: integer;
      S: string;
    begin
      Result := false;
      for J := 0 to strsResp.Count - 1 do begin
        s := strsResp[J];
        if (S.StartsWith('data')) or
            (S.StartsWith('total')) or
            (S.StartsWith('msg')) or
            (S.StartsWith('success')) then begin
          continue;
        end else begin
          Result := doPerResponse(S, oriTitle);
          if Result then begin
            break;
          end;
        end;
      end;
    end;

  var I: integer;
    oriTitle: string;
    bHitKey: boolean;
  begin
    for I := 0 to FColumns.Count - 1 do begin
      oriTitle := FColumns[I].Trim;
      bHitKey := getItOfStrs(oriTitle);
      if (not bHitKey) then begin
        doOnResultLine(getElTable('', oriTitle));
      end;
    end;
  end;

  procedure doAllResponse(const IntfaceFull: TIntfaceFull;
    const strsReq: TStrings; const strsResp: TStrings);
  var strReqVar, strReqParam: string;
  begin
    doResponsePre(IntfaceFull, strsReq);
    doResponseStrs(strsResp);
    strReqVar := reqToVarStr(IntfaceFull, strsReq);
    strReqParam := reqToParamStr(IntfaceFull, strsReq);
    doResponseEnd(IntfaceFull, strReqVar, strReqParam);
  end;

var i: integer;
  line, S: string;
  enumCtx: TEnumCtxType;
  strsReq, strsResp: TStrings;
begin
  FIntfaceFull.clear;
  strsReq := TStringList.Create;
  strsResp := TStringList.Create;
  try
    enumCtx := NONE;
    for I := 0 to strs.Count - 1 do begin
      line := strs[I].Trim;
      S := line.Trim;
      doOnLine(S);
      //
      if (S.StartsWith('接口详情')) then begin
        doOnLine('interface begin...');
        enumCtx:=INFO;
        continue;
      end else if (S.StartsWith('请求参数列表')) then begin
        doOnLine('interface end.');
        //
        doOnLine('request begin...');
        enumCtx:=REQUEST;
        continue;
      end else if (S.StartsWith('响应参数列表')) then begin
        doOnLine('request end.');
        //
        doOnLine('response begin...');
        enumCtx:=RESPONSE;
        continue;
      end else begin
        case enumCtx of
          INFO: begin
              if S.StartsWith('接口名称') then begin
                FIntfaceFull.Name := getRightStr(S, ' ');
              end;
              if S.StartsWith('请求类型') then begin
                FIntfaceFull.Method := getRightStr(S, ' ');
              end;
              if S.StartsWith('请求Url') then begin
                FIntfaceFull.HttpUrl := getRightStr(S, ' ');
              end;
            end;
          REQUEST: begin
              if (S.StartsWith('变量名')) then begin
                continue;
              end;
              strsReq.Add(S);
            end;
          RESPONSE: begin
              if (S.StartsWith('变量名')) then begin
                continue;
              end;
              strsResp.Add(S);
            end;
          else begin
            continue;
          end;
        end;
      end;
    end;
    doAllResponse(FIntfaceFull, strsReq, strsResp);
    doOnLine('response end.');
  finally
    strsReq.Free;
    strsResp.Free;
  end;
end;

end.


