object frmSetting: TfrmSetting
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #35774#32622
  ClientHeight = 303
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 11
    Width = 353
    Height = 238
    Caption = #31867#22411#26144#23556
    TabOrder = 0
    object Label3: TLabel
      Left = 45
      Top = 59
      Width = 38
      Height = 13
      Caption = 'tinyInt'#65306
    end
    object Label2: TLabel
      Left = 45
      Top = 32
      Width = 18
      Height = 13
      Caption = 'bit'#65306
    end
    object Label1: TLabel
      Left = 45
      Top = 86
      Width = 43
      Height = 13
      Caption = 'smallInt'#65306
    end
    object Label4: TLabel
      Left = 45
      Top = 113
      Width = 34
      Height = 13
      Caption = 'BigInt'#65306
    end
    object Label5: TLabel
      Left = 45
      Top = 140
      Width = 42
      Height = 13
      Caption = 'Decimal'#65306
    end
    object Label6: TLabel
      Left = 45
      Top = 167
      Width = 58
      Height = 13
      Caption = 'TimeStamp'#65306
    end
    object cbxTinyIntType: TComboBox
      Left = 141
      Top = 56
      Width = 138
      Height = 21
      ItemIndex = 1
      TabOrder = 0
      Text = 'Integer'
      Items.Strings = (
        'Short'
        'Integer')
    end
    object cbxBitType: TComboBox
      Left = 141
      Top = 29
      Width = 138
      Height = 21
      ItemIndex = 2
      TabOrder = 1
      Text = 'Integer'
      Items.Strings = (
        'Boolean'
        'Short'
        'Integer'
        'Long')
    end
    object cbxSmallInt: TComboBox
      Left = 141
      Top = 83
      Width = 138
      Height = 21
      ItemIndex = 1
      TabOrder = 2
      Text = 'Integer'
      Items.Strings = (
        'Short'
        'Integer')
    end
    object cbxBigInt: TComboBox
      Left = 141
      Top = 110
      Width = 138
      Height = 21
      ItemIndex = 1
      TabOrder = 3
      Text = 'Long'
      Items.Strings = (
        'Integer'
        'Long'
        'BigInteger')
    end
    object cbxDecimal: TComboBox
      Left = 141
      Top = 137
      Width = 138
      Height = 21
      ItemIndex = 1
      TabOrder = 4
      Text = 'BigDecimal'
      Items.Strings = (
        'Double'
        'BigDecimal')
    end
    object cbxTimestamp: TComboBox
      Left = 141
      Top = 164
      Width = 138
      Height = 21
      ItemIndex = 1
      TabOrder = 5
      Text = 'Date'
      Items.Strings = (
        'TimeStamp'
        'Date')
    end
  end
  object Button1: TButton
    Left = 200
    Top = 255
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 302
    Top = 255
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
