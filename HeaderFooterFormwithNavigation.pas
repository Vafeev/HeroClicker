unit HeaderFooterFormwithNavigation;  
interface
// Подключение необходимых библиотек
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, System.ImageList,
  FMX.ImgList, FMX.Layouts, FMX.ExtCtrls;     
// Описание всех типов используемых объектов на форме
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
// Описание используемых переменных 
var
  HeaderFooterwithNavigation: THeaderFooterwithNavigation;
  a, atc, atc_s, enm_h, mon, lvl, i, j:integer;
implementation
{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}
procedure THeaderFooterwithNavigation.TitleActionUpdate(Sender: TObject); // Процедура для переключения окон в игре
begin
  if Sender is TCustomAction then
  begin
    if TabControl1.ActiveTab <> nil then
      TCustomAction(Sender).Text := TabControl1.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
end;
procedure THeaderFooterwithNavigation.attack_btnClick(Sender: TObject); // Процедура обработки нажатия на кнопку "Атака"
begin
  enm_h:=enm_h - atc; // Вычисление уровня здоровья противника после атаки. Здоровье противника минус сила атаки
  enm_health.Value := enm_h * atc_s; // Присваиваем счетчику здоровья занчения из переменной отвечающей за здоровье противника
  if enm_h<=0 // Цикл обработки смены противника
    then
      begin
        i:=i+1; // Перменная i отвечает за индекс противника. Прибавляем 1 каждый раз когда здоровье противника меньше или равно 0
        enm_h:=100; // Присвоить здоровье следующего противника как 100
        enm_health.Value:=enm_h * 100; // Присвоение здоровья противника счетчику противника (Не реализована прогрессия количества здоровья у противника относительно уровня героя)
        mon:=mon + 100; // Начисляем награду за "убийство" противника
      end;
  case i of // Оператор выбора для изменения "активного" противника привязанное к индексу (i) противника
   1: enm2.Visible:=False;
   2: enm3.Visible:=False;
   3: enm1.Visible:=False;
  end;
  if i=3 // Сброс значения i когда количество "убитых" противников достигает 3-х (Максимальное количество противников на данном этапе разработки)
    then
      begin
        i:=0; // Сброс значения перменной i
        enm1.Visible:=True; // Переключение видимости противника 1
        enm2.Visible:=True; // Переключение видимости противника 2
        enm3.Visible:=True; // Переключение видимости противника 3
      end;
  lvl_count.Text:=('Уровень: ' + IntToStr(lvl)); // Присвоить значению Text объекта lvl_count (Label) значение текущего уровня героя
  power_count.Text:=('Сила атаки: ' + IntToStr(atc)); // Присвоить значению Text объекта power_count (Label) значение текущей силы атаки героя
  money_count.Text:=('Деньги: ' + IntToStr(mon)); // Присвоить значению Text объекта money_count (Label) значение текущего количетсво монет
  if lvl >= 10 // Проверка, если уровень персонажа достигает 10-го
    then
      begin
        label3.Visible := True; // Включение видимости текстового поля знаменующее победу
        attack_btn.Enabled:=False; // Отключение кнопки "Атака"
        enm1.Visible:=False; // Отключение видимости противника 1
        enm2.Visible:=False; // Отключение видимости противника 2
        enm3.Visible:=False; // Отключение видимости противника 3
        enm_health.Value := 0; // Установка значения счетчика здоровья противника на 0
      end;
end;
procedure THeaderFooterwithNavigation.Button1Click(Sender: TObject); // Процедура обработки кнопки улучшения героя в Магазине
begin
  if mon>=(1000*lvl) // Проверка количества монет у героя, если больше стоимости улучшения (1000 * на уровень персонажа)
    then 
      begin
        mon:=mon-(1000*lvl); // Вычет монет необходимых на улучшение героя из его "кошелька"
        atc:=atc+1; // Повышение уровня атаки
         lvl:=lvl+1; // Повышения уровня героя
      end;
  lvl_count.Text:=('Уровень: ' + IntToStr(lvl)); // Присвоить значению Text объекта lvl_count (Label) значение текущего уровня героя
  power_count.Text:=('Сила атаки: ' + IntToStr(atc)); // Присвоить значению Text объекта power_count (Label) значение текущей силы атаки
  money_count.Text:=('Деньги: ' + IntToStr(mon)); // Присвоить значению Text объекта money_count (Label) значение текущего количетсво монет 
  label1.Text:=('Стоимость: ' + IntToStr(1000*lvl)); // Присвоить значению Text объекта Label1 (Label) значение текущей стоимости улучшения
end;
procedure THeaderFooterwithNavigation.FormCreate(Sender: TObject); // Процедура обработки формы при включении игры
begin
  atc:=10; // Присвоить значение силы атаки 10
  atc_s:=100; // Присвоить множетелю силы атаки 100
  mon:=0; // Просвоить колчество денег 0
  lvl:=1; // Присвоить уровень героя 0
  enm_h:=100; // Присвоить значение здоровья противника
  i:=0; // Присвоить значение индекса противника 0
  { This defines the default active tab at runtime }
  TabControl1.First(TTabTransition.None);
  enm_health.Value:=10000; // Присвоить счетчику здоровье противника 10000
  lvl_count.Text:=('Уровень: ' + IntToStr(lvl)); // Присвоить значению Text объекта lvl_count (Label) значение текущего уровня героя 
  power_count.Text:=('Сила атаки: ' + IntToStr(atc)); // Присвоить значению Text объекта power_count (Label) значение текущей силы атаки
  money_count.Text:=('Деньги: ' + IntToStr(mon)); // Присвоить значению Text объекта money_count (Label) значение текущего количетсво монет
  label1.Text:=('Стоимость: ' + IntToStr(1000*lvl)); // Присвоить значению Text объекта Label1 (Label) значение текущей стоимости улучшения
  label3.Visible := False; // Переключения видимости текстового сообщения о победе
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
