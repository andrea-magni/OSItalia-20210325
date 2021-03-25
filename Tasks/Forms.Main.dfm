object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RunButton: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 0
    OnClick = RunButtonClick
  end
  object CancelButton: TButton
    Left = 24
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = CancelButtonClick
  end
  object WaitButton: TButton
    Left = 24
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Wait'
    TabOrder = 2
    OnClick = WaitButtonClick
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 248
    Top = 96
  end
end
