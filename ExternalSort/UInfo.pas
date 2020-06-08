unit UInfo;

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
  StdCtrls;

type
  //������ - ���������� � �������
  TInfo = record
    name: string[40];
    continent: string[20];
    capital: string[40];
    area: LongInt;
    population: LongInt;
    politicalSystem: string[20];
  end;

  function InputInfo(aName, aContinent, aCapital: string; aArea, aPopulation: LongInt;
    aPoliticalSystem: string): TInfo;
  procedure PrintToMemo(var info: TInfo; var memo: TMemo);

implementation

uses
  SysUtils;

//���� ���������� � ��������
function InputInfo(aName, aContinent, aCapital: string; aArea, aPopulation: LongInt;
    aPoliticalSystem: string): TInfo;
begin
  with Result do
    begin
      name:= aName;
      continent:= aContinent;
      capital:= aCapital;
      area:= aArea;
      population:= aPopulation;
      politicalSystem:= aPoliticalSystem;
    end;
end;

//������ ���������� �� memo
procedure PrintToMemo(var info: TInfo; var memo: TMemo);
begin
  with info, memo do
    begin
      Lines.Add('��������: ' + info.name);
      Lines.Add('���������: ' + continent);
      Lines.Add('�������: ' + capital);
      Lines.Add('�������: ' + IntToStr(area) + ' ��^2');
      Lines.Add('����������� ���������: ' + IntToStr(population) + ' �������');
      Lines.Add('��������������� �����: ' + politicalSystem);
      Lines.Add('');
    end;  
end;  

end.
