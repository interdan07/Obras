Option Explicit

' Módulo de Reportes
' Funciones para generar reportes y exportar datos

Public Function GenerarEstadoCuenta(idCuenta As Long, fechaInicio As Date, fechaFin As Date) As Object
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    Dim sql As String
    
    Set db = CurrentDb()
    
    ' Obtener datos para el reporte
    sql = "SELECT " & _
          "tc.ID, tc.NumeroCuenta, tc.NombreBanco, tc.Saldo, " & _
          "COUNT(tt.ID) as TotalTransacciones, " & _
          "SUM(IIF(tt.TipoTransaccion='Deposito', tt.Monto, 0)) as TotalDepositos, " & _
          "SUM(IIF(tt.TipoTransaccion='Retiro', tt.Monto, 0)) as TotalRetiros " & _
          "FROM tblCuentasBancarias tc " & _
          "LEFT JOIN tblTransacciones tt ON tc.ID = tt.IDCuenta " & _
          "WHERE tc.ID = " & idCuenta & _
          " AND tt.Fecha BETWEEN #" & Format(fechaInicio, "mm/dd/yyyy") & "# AND #" & Format(fechaFin, "mm/dd/yyyy") & "# " & _
          "GROUP BY tc.ID, tc.NumeroCuenta, tc.NombreBanco, tc.Saldo"
    
    Set rst = db.OpenRecordset(sql)
    Set GenerarEstadoCuenta = rst
    Exit Function
    
ErrorHandler:
    MsgBox "Error al generar estado de cuenta: " & Err.Description, vbCritical
    Set GenerarEstadoCuenta = Nothing
End Function

Public Function GenerarMovimientos(idCuenta As Long, fechaInicio As Date, fechaFin As Date) As Object
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    Dim sql As String
    
    Set db = CurrentDb()
    
    sql = "SELECT * FROM tblTransacciones " & _
          "WHERE IDCuenta = " & idCuenta & _
          " AND Fecha BETWEEN #" & Format(fechaInicio, "mm/dd/yyyy") & "# AND #" & Format(fechaFin, "mm/dd/yyyy") & "# " & _
          "ORDER BY Fecha DESC"
    
    Set rst = db.OpenRecordset(sql)
    Set GenerarMovimientos = rst
    Exit Function
    
ErrorHandler:
    MsgBox "Error al generar reporte de movimientos: " & Err.Description, vbCritical
    Set GenerarMovimientos = Nothing
End Function

Public Function GenerarResumenTransacciones(tipoTransaccion As String, fechaInicio As Date, fechaFin As Date) As Object
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    Dim sql As String
    
    Set db = CurrentDb()
    
    sql = "SELECT TipoTransaccion, COUNT(*) as Cantidad, SUM(Monto) as Total " & _
          "FROM tblTransacciones " & _
          "WHERE Fecha BETWEEN #" & Format(fechaInicio, "mm/dd/yyyy") & "# AND #" & Format(fechaFin, "mm/dd/yyyy") & "# "
    
    If tipoTransaccion <> "" Then
        sql = sql & "AND TipoTransaccion = '" & tipoTransaccion & "' "
    End If
    
    sql = sql & "GROUP BY TipoTransaccion ORDER BY Total DESC"
    
    Set rst = db.OpenRecordset(sql)
    Set GenerarResumenTransacciones = rst
    Exit Function
    
ErrorHandler:
    MsgBox "Error al generar resumen: " & Err.Description, vbCritical
    Set GenerarResumenTransacciones = Nothing
End Function

Public Function ObtenerSaldosActuales() As Object
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("SELECT ID, NumeroCuenta, NombreBanco, Saldo, TipoCuenta, Estado FROM tblCuentasBancarias ORDER BY NombreBanco, NumeroCuenta")
    
    Set ObtenerSaldosActuales = rst
    Exit Function
    
ErrorHandler:
    MsgBox "Error al obtener saldos: " & Err.Description, vbCritical
    Set ObtenerSaldosActuales = Nothing
End Function

Public Function ExportarAPDF(nombreReporte As String, rutaDestino As String) As Boolean
    On Error GoTo ErrorHandler
    
    ' Esta función depende de Microsoft Access tendo la capacidad de exportar
    ' Se requiere configuración adicional del sistema
    
    DoCmd.OpenReport nombreReporte, acViewPreview
    ' DoCmd.OutputTo acOutputReport, nombreReporte, "PDF Format", rutaDestino
    
    ExportarAPDF = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al exportar a PDF: " & Err.Description, vbCritical
    ExportarAPDF = False
End Function

Public Function ExportarAExcel(nombreReporte As String, rutaDestino As String) As Boolean
    On Error GoTo ErrorHandler
    
    ' Exportar reporte a formato Excel
    DoCmd.OutputTo acOutputTable, nombreReporte, "Excel Workbook (*.xlsx)", rutaDestino
    
    ExportarAExcel = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al exportar a Excel: " & Err.Description, vbCritical
    ExportarAExcel = False
End Function

Public Function ObtenerTotalDepositos(idCuenta As Long) As Currency
    Dim db As Object
    Dim rst As Object
    Dim sql As String
    
    Set db = CurrentDb()
    
    sql = "SELECT SUM(Monto) as Total FROM tblTransacciones " & _
          "WHERE IDCuenta = " & idCuenta & " AND TipoTransaccion = 'Deposito'"
    
    Set rst = db.OpenRecordset(sql)
    
    If Not rst.EOF Then
        If IsNull(rst("Total")) Then
            ObtenerTotalDepositos = 0
        Else
            ObtenerTotalDepositos = rst("Total")
        End If
    End If
    
    rst.Close
End Function

Public Function ObtenerTotalRetiros(idCuenta As Long) As Currency
    Dim db As Object
    Dim rst As Object
    Dim sql As String
    
    Set db = CurrentDb()
    
    sql = "SELECT SUM(Monto) as Total FROM tblTransacciones " & _
          "WHERE IDCuenta = " & idCuenta & " AND TipoTransaccion = 'Retiro'"
    
    Set rst = db.OpenRecordset(sql)
    
    If Not rst.EOF Then
        If IsNull(rst("Total")) Then
            ObtenerTotalRetiros = 0
        Else
            ObtenerTotalRetiros = rst("Total")
        End If
    End If
    
    rst.Close
End Function