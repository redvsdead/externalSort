unit UShortInfo;

//� ��� ������� �������� ����� �����, ������� ��������:
//- ��������;
//- ���������;
//- �������;
//- ��������
//- ����������� ���������;
//- ���. �����.
//������� �������� � ������� ���������� � ������� �������� ��������� ���������,
//�������� ������������ ���������� ������������ �������

interface

uses
  UInfo, StdCtrls;

type
  //����������� ���������� � ������� ��� ����������
  TShortInfo = record
    name: string[40];
    capital: string[40];
    populationDestiny: Real;
  end;

  function InputInfo(info: TInfo): TShortInfo;
  procedure PrintToMemo(info: TShortInfo; var memo: TMemo);

implementation

uses
  SysUtils;


function InputInfo(info: TInfo): TShortInfo;
begin
  with Result do
    begin
      name:= info.name;
      capital:= info.capital;
      populationDestiny:= info.population / info.area;
    end;
end;

procedure PrintToMemo(info: TShortInfo; var memo: TMemo);
begin
  with info, memo do
    begin
      Lines.Add('��������: ' + info.name);
      Lines.Add('�������: ' + capital);
      Lines.Add('��������� ���������: ' + FloatToStrF(populationDestiny,ffFixed,5,2) + ' �������/��^2');
      Lines.Add('');
    end;  
end;  

end.
