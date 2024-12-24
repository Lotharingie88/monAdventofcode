object Fadventofcod: TFadventofcod
  Left = 0
  Top = 0
  Align = alLeft
  AutoSize = True
  Caption = 'Advent Of Code'
  ClientHeight = 650
  ClientWidth = 1208
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDefault
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 21
  object Label1: TLabel
    Left = 158
    Top = 3
    Width = 37
    Height = 21
    Caption = 'Jour :'
  end
  object Label2: TLabel
    Left = 277
    Top = 3
    Width = 62
    Height = 21
    Caption = 'Exercice :'
  end
  object Label4: TLabel
    Left = 0
    Top = 3
    Width = 51
    Height = 21
    Caption = 'Ann'#233'e :'
  end
  object Label3: TLabel
    Left = 455
    Top = 3
    Width = 53
    Height = 21
    Caption = 'Fichier :'
  end
  object Label5: TLabel
    Left = 9
    Top = 608
    Width = 57
    Height = 23
    Caption = 'process :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe Print'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 481
    Top = 608
    Width = 151
    Height = 23
    Caption = 'Temps de traitement :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe Print'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 9
    Top = 32
    Width = 67
    Height = 21
    Caption = ' R'#233'sultat :'
  end
  object Label8: TLabel
    Left = 9
    Top = 248
    Width = 134
    Height = 21
    Caption = 'Visu fichier source :'
  end
  object Label9: TLabel
    Left = 943
    Top = 34
    Width = 33
    Height = 21
    Caption = 'Log :'
  end
  object lbTime: TLabel
    Left = 662
    Top = 608
    Width = 4
    Height = 21
  end
  object lbProc: TLabel
    Left = 97
    Top = 608
    Width = 4
    Height = 21
  end
  object Memo1: TMemo
    Left = 8
    Top = 61
    Width = 930
    Height = 183
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object CbJour: TComboBox
    Left = 201
    Top = 0
    Width = 70
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
    Left = 345
    Top = 0
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
  object Memo2: TMemo
    Left = 9
    Top = 287
    Width = 921
    Height = 315
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button1: TButton
    Left = 801
    Top = -1
    Width = 97
    Height = 25
    Caption = 'Quitter'
    TabOrder = 4
    OnClick = Button1Click
  end
  object edFic: TEdit
    Left = 514
    Top = -3
    Width = 281
    Height = 29
    TabOrder = 5
  end
  object cbAn: TComboBox
    Left = 57
    Top = 0
    Width = 81
    Height = 29
    TabOrder = 6
    Items.Strings = (
      '2025'
      '2024'
      '2023'
      '2022'
      '2021'
      '2020'
      '2019'
      '2018'
      '2017'
      '2016'
      '2015')
  end
  object cbTest: TCheckBox
    Left = 392
    Top = 3
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    Caption = 'Test :'
    TabOrder = 7
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 257
    Top = 249
  end
  object Memo3: TMemo
    Left = 943
    Top = 61
    Width = 265
    Height = 505
    ScrollBars = ssBoth
    TabOrder = 9
  end
end
