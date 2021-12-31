object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Advent Of Code'
  ClientHeight = 749
  ClientWidth = 1157
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 37
    Height = 21
    Caption = 'Jour :'
  end
  object Label2: TLabel
    Left = 152
    Top = 8
    Width = 62
    Height = 21
    Caption = 'Exercice :'
  end
  object Label3: TLabel
    Left = 304
    Top = 8
    Width = 74
    Height = 21
    Caption = 'Data path :'
  end
  object Memo1: TMemo
    Left = 0
    Top = 40
    Width = 1157
    Height = 709
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object CbJour: TComboBox
    Left = 59
    Top = 6
    Width = 87
    Height = 29
    TabOrder = 1
    Items.Strings = (
      ''
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '07'
      '08'
      '09'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '21'
      '22'
      '23'
      '24'
      '25')
  end
  object CbExo: TComboBox
    Left = 224
    Top = 8
    Width = 41
    Height = 29
    Sorted = True
    TabOrder = 2
    OnClick = CbExoClick
    Items.Strings = (
      ''
      '1'
      '2')
  end
end
