unit uBeanPro;

interface

type
  TBeanPro = class(TObject)
  private
    //class var FMaxId: Int64;
  public
    FFldName: string;
    FFldType: string;
    FFldLen: string;
    FComment: string;
    FNotNull: boolean;
    FDefVal: variant;
  public
    class constructor Create;
    constructor Create;
    destructor Destroy; override;
  public
    //property ShortCode: string read short_code write short_code;
  end;

implementation

uses SysUtils, classes;

{ TCarBrand }

class constructor TBeanPro.Create;
begin
  //FMaxId := 67541628411220000;
end;

constructor TBeanPro.Create;
begin
  //inherited Create;
end;

destructor TBeanPro.Destroy;
begin
end;

end.

