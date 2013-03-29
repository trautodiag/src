inherited F_CadAnAgendaCompromisso: TF_CadAnAgendaCompromisso
  Caption = 'Agenda de compromissos'
  ClientWidth = 570
  ExplicitWidth = 578
  ExplicitHeight = 521
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 570
    ClientRectRight = 569
    inherited ts_base: TcxTabSheet
      inherited pnl_Base: TPanel
        Width = 568
        inherited rg_base: TcxRadioGroup
          Left = 382
        end
      end
      inherited pnl_Consulta: TPanel
        Width = 568
        inherited grp_consulta: TGroupBox
          Width = 494
          inherited btn_filtrar: TcxButton
            Left = 410
          end
          inherited edt_Consulta: TcxTextEdit
            Width = 396
          end
        end
        inherited grp_qtdRegistros: TGroupBox
          Left = 494
        end
      end
      inherited pnl_grid: TPanel
        Width = 568
        inherited grid_base: TcxGrid
          Width = 568
          inherited vwl_base: TcxGridDBTableView
            object vwl_baseColumn1: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'AGC_Descricao'
              Options.Editing = False
              Options.Focusing = False
              Width = 300
            end
            object vwl_baseColumn2: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'AGC_Data'
              Options.Editing = False
              Options.Focusing = False
              Width = 80
            end
            object vwl_baseColumn3: TcxGridDBColumn
              Caption = 'Hora'
              DataBinding.FieldName = 'AGC_Hora'
              Options.Editing = False
              Options.Focusing = False
              Width = 30
            end
            object vwl_baseColumn4: TcxGridDBColumn
              Caption = 'Minuto'
              DataBinding.FieldName = 'AGC_Minuto'
              Options.Editing = False
              Options.Focusing = False
              Width = 30
            end
          end
        end
      end
    end
  end
end
