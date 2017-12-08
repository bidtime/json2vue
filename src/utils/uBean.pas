unit uBean;

interface

uses classes, Generics.Collections, uBeanPro;

type
  TBean = class(TObject)
  private
    //class var FMaxId: Int64;
    FList: TList;
    FMapPK: TDictionary<String, String>;
    FMapColumn: TDictionary<String, String>;
    //FContext: TStrings;
    FColumns: TStrings;
    //
    FOnLine: TGetStrProc;
    FOnValidLine: TGetStrProc;
    procedure doOnLine(const S: string);
    procedure doOnValidLine(const S: string);
  public
    FTableName: string;
    FComment: string;
  public
    class constructor Create;
    constructor Create;
    destructor Destroy; override;
    //
    //procedure addColumn(const u: TColumnPro);
    procedure setContent(const strs: TStrings);
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

class constructor TBean.Create;
begin
  //FMaxId := 67541628411220000;
end;

constructor TBean.Create;
begin
  //inherited Create;
  FList := TList.Create;
  FMapPK := TDictionary<String, String>.Create;
  FMapColumn:= TDictionary<String, String>.Create;
end;

destructor TBean.Destroy;
begin
  FList.Free;
  FMapPK.Free;
  FMapColumn.Free;
end;

procedure TBean.doOnLine(const S: string);
begin
  if Assigned(FOnLine) then begin
    FOnLine(S);
  end;
end;

procedure TBean.doOnValidLine(const S: string);
begin
  if Assigned(FOnValidLine) then begin
    FOnValidLine(S);
  end;
end;

procedure TBean.setContent(const strs: TStrings);

  function isProper(const S: string): boolean;
  begin
    if (S.StartsWith('private')) or ( S.StartsWith('protected')) then begin
      if (S.Contains('(')) then begin // and (S.Contains('{')) then begin
        Result := false;
      end else begin
        Result := true;
      end;
    end else begin
      Result := false;
    end;
  end;

  function isComment(const S: string): boolean;
  begin
    if (S.StartsWith('//')) then begin
      Result := true;
    end else if (S.StartsWith('/*')) then begin
      Result := true;
    end else begin
      Result := false;
    end;
  end;

  function getComment(const S: string): string;
  begin

  end;

  function getRightStr(const S: string; const sub: string): string;
  var n: integer;
  begin
    n := S.IndexOf(sub);
    if (n>=0) then begin
      Result := S.Substring(n+sub.Length);
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

var i: integer;
  line, S, tmp, comment: string;
  hitComment: boolean;
  bIdxStr: boolean;
  bHitClass: boolean;
begin
  hitComment := false;
  bHitClass := false;
  for I := 0 to strs.Count - 1 do begin
    line := strs[I].Trim;
    S := line.Trim;
    //doOnLine(S);
    if (S.StartsWith('public class'))
        or (S.StartsWith('private class'))
          or (S.StartsWith('protected class')) then begin
      bHitClass := true;
      doOnLine('class begin...');
    //end else if (S.StartsWith('}')) then begin
    end else begin
      if not bHitClass then begin
        continue;
      end;
      doOnLine(S);
      //
      if (S.StartsWith('//')) then begin              //hit comment
        comment := getRightStr(S, '//');
      end else begin
        if (S.StartsWith('/*')) then begin            //hit comment begin
          bIdxStr := getCommentOfChar(S, '/*', tmp);
          if bIdxStr then begin
            hitComment := false;
            continue;
          end else begin
            hitComment := true;
          end;
        end else if (S.StartsWith('*')) then begin
          if hitComment then begin
            bIdxStr := getCommentOfChar(S, '*', tmp);
            if bIdxStr then begin
              hitComment := false;
              continue;
            end else begin
              hitComment := true;
            end;
          end;
        end else if (S.StartsWith('*/')) then begin   //hit comment end
          hitComment := false;
        end else if (S.StartsWith('*/')) then begin
        end else begin

        end;
      end;
    end;
  end;
end;

{procedure TBean.addColumn(const u: TColumnPro);
begin
  FList.Add(u);
end;}

end.

