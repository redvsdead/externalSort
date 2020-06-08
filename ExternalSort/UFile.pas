unit UFile;

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
  UInfo, SysUtils, StdCtrls;

type
  //����� - ����
  TFile = class
  private
    f: file of TInfo;  //����
    fName: string;     //��� �����
    fElem: TInfo;      //������� ������� � �����
    fEof: Boolean;     //������� ����� �����
    fCount: Integer;   //���������� ������� � ����� (��� �����)
  public
    constructor Create(s: string);
    destructor Destroy; override;
    procedure ReadNext;
    procedure StartRead;
    procedure StartWrite;
    procedure Close;
    procedure AddElem(el: TInfo);
    function DeleteElem(s:String): Boolean;
    procedure Delete;
    procedure PrintToMemo(var memo: TMemo);

    property Eof: boolean
      read fEof;
    property Elem: TInfo
      read fElem
      write fElem;
    property Name: string
      read fName;
    property Count: Integer
      read fCount;
  end;


implementation

//�����������
constructor TFile.Create(s: string);
begin
  fName:= s;
  AssignFile(f,s);
end;

//����������
destructor TFile.Destroy;
begin
  inherited;
end;


//���������, ����������� �� ����� �������� �������
procedure TFile.ReadNext;
begin
  fEof:= System.Eof(f);
  if not fEof then
    read(f,fElem);
end;

//��������� ���������� ����� ��� ������
procedure TFile.StartRead;
begin
  Reset(f);
  fCount:= FileSize(f);
  ReadNext;
end;

//��������� ���������� ����� ��� ������
procedure TFile.StartWrite;
begin
  Rewrite(f);
  fCount:= 0;
end;

//��������� ����
procedure TFile.Close;
begin
  CloseFile(f);
end;


//��������� ���������� �������� � ����� �����
procedure TFile.AddElem(el: TInfo);
begin
  Reset(f);
  Seek(f, FileSize(f));
  write(f,el);
  Inc(fCount);
  CloseFile(f);
end;

//��������� �������� ��������
//���������� false ���� ����� ������ ��� � �����
function TFile.DeleteElem(s: string): Boolean;
var
  el: TInfo;
  size, n: Integer;
begin
  Result:= false;
  Reset(f);
  n:= 0;
  size:= FileSize(f);
  while not Result and (n < size) do
    begin
      read(f,el);
      if el.name = s then
        begin
          Seek(f, size-1);
          if n < size-1 then
            begin
              //�������� ������ n �� ���������
              read(f,el);
              Seek(f,n);
              write(f,el);
              Seek(f,size-1);
            end;
          //��������� ������ ��������
          Truncate(f);
          Result:= True;
          Dec(fCount);
        end;
      Inc(n)
    end;
  CloseFile(f);
end;

//�������� �����
procedure TFile.Delete;
begin
  DeleteFile(fName);
end;

//����� ����� �� memo
procedure TFile.PrintToMemo(var memo: TMemo);
var
  i: Integer;
begin
  memo.Clear;
  i:= 1;
  StartRead;
  if fEof then
    memo.Lines.Add('<���� ������>')
  else
    repeat
      UInfo.PrintToMemo(fElem,memo);
      Inc(i);
      ReadNext;
    until fEof;
  CloseFile(f);
end;

end.
