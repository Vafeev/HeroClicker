unit HeaderFooterFormwithNavigation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, System.ImageList,
  FMX.ImgList, FMX.Layouts, FMX.ExtCtrls;

type
  THeaderFooterwithNavigation = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    TitleAction: TControlAction;
    NextTabAction1: TNextTabAction;
    TopToolBar: TToolBar;
    ToolBarLabel: TLabel;
    btnNext: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    BottomToolBar: TToolBar;
    attack_btn: TButton;
    enm_health: TProgressBar;
    Panel1: TPanel;
    lvl_count: TLabel;
    power_count: TLabel;
    money_count: TLabel;
    pad_list: TImageList;
    enm1: TImage;
    enm2: TImage;
    enm3: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ImageViewer1: TImageViewer;
    Brush1: TBrushObject;
    ImageViewer2: TImageViewer;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure attack_btnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HeaderFooterwithNavigation: THeaderFooterwithNavigation;
  a, atc, atc_s, enm_h, mon, lvl, i, j:integer;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure THeaderFooterwithNavigation.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if TabControl1.ActiveTab <> nil then
      TCustomAction(Sender).Text := TabControl1.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
end;

procedure THeaderFooterwithNavigation.attack_btnClick(Sender: TObject);
begin
  enm_h:=enm_h - atc;
  enm_health.Value := enm_h * atc_s;
  if enm_h<=0
    then
      begin
        i:=i+1;
        enm_h:=100;
        enm_health.Value:=enm_h * 100;
        mon:=mon + 100;
      end;
  case i of
   1: enm2.Visible:=False;
   2: enm3.Visible:=False;
   3: enm1.Visible:=False;
  end;
  if i=3
    then
      begin
        i:=0;
        enm1.Visible:=True;
        enm2.Visible:=True;
        enm3.Visible:=True;
      end;
  lvl_count.Text:=('Уровень: ' + IntToStr(lvl));
  power_count.Text:=('Сила атаки: ' + IntToStr(atc));
  money_count.Text:=('Деньги: ' + IntToStr(mon));
  if lvl >= 10
    then
      begin
        label3.Visible := True;
        attack_btn.Enabled:=False;
        enm1.Visible:=False;
        enm2.Visible:=False;
        enm3.Visible:=False;
        enm_health.Value := 0;
      end;
end;

procedure THeaderFooterwithNavigation.Button1Click(Sender: TObject);
begin
  if mon>=(1000*lvl)
    then
      begin
        mon:=mon-(1000*lvl);
        atc:=atc+1;
         lvl:=lvl+1;
      end;
  lvl_count.Text:=('Уровень: ' + IntToStr(lvl));
  power_count.Text:=('Сила атаки: ' + IntToStr(atc));
  money_count.Text:=('Деньги: ' + IntToStr(mon));
  label1.Text:=('Стоимость: ' + IntToStr(1000*lvl));


end;

procedure THeaderFooterwithNavigation.FormCreate(Sender: TObject);
begin
  a:=0;
  atc:=10;
  atc_s:=100;
  mon:=0;
  lvl:=1;
  enm_h:=100;
  i:=0;
  { This defines the default active tab at runtime }
  TabControl1.First(TTabTransition.None);
  enm_health.Value:=10000;
  lvl_count.Text:=('Уровень: ' + IntToStr(lvl));
  power_count.Text:=('Сила атаки: ' + IntToStr(atc));
  money_count.Text:=('Деньги: ' + IntToStr(mon));
  label1.Text:=('Стоимость: ' + IntToStr(1000*lvl));
  label3.Visible := False;
end;

procedure THeaderFooterwithNavigation.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (TabControl1.TabIndex <> 0) then
  begin
    TabControl1.First;
    Key := 0;
  end;
end;


end.
