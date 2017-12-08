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

var i: integer;
  S, line, comment: string;
  hitComment: integer;
begin
  hitComment := -1;
  for I := 0 to strs.Count - 1 do begin
    line := strs[I].Trim;
    doOnLine(line);
    if (line.StartsWith('public class')) then begin
      doOnLine('class begin...');
    end else if (line.StartsWith('}')) then begin
      doOnLine('class end.');
    end else begin
      if (S.StartsWith('//')) then begin
        // getCommentOfSlash();
      end else begin
        if hitComment=0 then begin
          if (S.StartsWith('*')) then begin
            //comment := '';
            //if not comment.isEmpty() then begin
            // hiComment := 1;
            // continue;
            //end
          end;
        end else begin
        end;

        if (S.StartsWith('/*')) then begin
         hitComment := 0;
        end else if (S.StartsWith('*/')) then begin
          hitComment := 1;
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

