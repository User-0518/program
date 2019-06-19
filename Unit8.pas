unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm8 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Button3: TButton;
    Button2: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm8.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
if (Trim(Edit1.Text) <> '') and (Trim(Edit2.Text) <> '') and (Trim(Edit3.Text) <> '') then
  begin
    if length(edit2.text)>=6 then
    begin
      if Edit2.Text = Edit3.Text then
      begin
        DataModule2.ADOQuery1.Close;
        DataModule2.ADOQuery1.SQL.Text :=
          'SELECT * FROM [Пользователи] WHERE [логин] = :p_login';
        DataModule2.ADOQuery1.Parameters.ParamByName('p_login').Value := Edit1.Text;
        try
          DataModule2.ADOQuery1.Open;
        Except
          ShowMessage('Не удалось открыть таблицу пользователей');
          Exit;
        end;
        if DataModule2.ADOQuery1.RecordCount > 0 then
        begin
          MessageBox(handle, PChar('Данный пользователь уже существует!'),
            PChar('Ошибка'), MB_ICONERROR + MB_OK);
          Edit1.Text := '';
          Edit2.Text := '';
          Edit3.Text := '';
        end
        else
        begin
          DataModule2.ADOQuery1.Close;
          DataModule2.ADOQuery1.SQL.Text :=
            'INSERT INTO [Пользователи]([логин],[пароль]) VALUES(:p_login,:p_passw)';
          DataModule2.ADOQuery1.Parameters.ParamByName('p_login').Value := Edit1.Text;
          DataModule2.ADOQuery1.Parameters.ParamByName('p_passw').Value := Edit2.Text;
          MessageBox(handle, PChar('Регистрация успешно выполнена.'),
            PChar('Регистрация успешна'), MB_ICONASTERISK + MB_OK);
          Close;
        end;
      end
      else
      MessageBox(handle, PChar('Введеные пароли не совпадают!'),
        PChar('Ошибка'), MB_ICONWARNING + MB_OK);
    end
    else
      MessageBox(handle, PChar('Пароль не может содержать менее 6 символов'),
        PChar('Ошибка'), MB_ICONWARNING + MB_OK);
  end
  else
    MessageBox(handle, PChar('Пустые поля логин\пароль не допускаются!'),
      PChar('Ошибка'), MB_ICONWARNING + MB_OK);
end;

end.
