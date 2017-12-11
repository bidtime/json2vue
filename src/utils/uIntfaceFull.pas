unit uIntfaceFull;

interface

type
  TIntfaceFull = class(TObject)
  private
    //class var FMaxId: Int64;
  private
    FName: string;
    FMethod: string;
    FHttpUrl: string;
    FUrl: string;
    procedure SetHttpUrl(const S: string);
  public
    class constructor Create;
    constructor Create;
    destructor Destroy; override;
    procedure clear;
  public
    property Name: string read FName write FName;
    property Method: string read FMethod write FMethod;
    property HttpUrl: string write SetHttpUrl;
    property Url: string read FUrl;
  end;

implementation

uses SysUtils, classes;

{ TCarBrand }

class constructor TIntfaceFull.Create;
begin
  //FMaxId := 67541628411220000;
end;

procedure TIntfaceFull.clear;
begin
  FName:='';
  FMethod:='';
  FHttpUrl:='';
  FUrl:='';
end;

constructor TIntfaceFull.Create;
begin
  //inherited Create;
end;

destructor TIntfaceFull.Destroy;
begin
end;

procedure TIntfaceFull.SetHttpUrl(const S: string);

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

  function getUrlAPI(const S: string): string;
  begin
    if S.StartsWith('http://') then begin
      Result := getRightStr(S, 'http://{{ip}}:{{port}}/');
    end else begin
      Result := S;
    end;
  end;

begin
  self.FHttpUrl := S;
  self.FUrl := getUrlAPI(S);
end;

end.

