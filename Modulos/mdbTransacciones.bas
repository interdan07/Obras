Option Explicit

' Módulo de Transacciones Bancarias
' Funciones para registrar y gestionar transacciones

Public Function RegistrarDeposito(idCuenta As Long, monto As Currency, descripcion As String) As Boolean
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    Dim saldoActual As Currency
    
    Set db = CurrentDb()
    
    ' Validar monto
    If monto <= 0 Then
        MsgBox "El monto debe ser mayor a cero", vbCritical
        Exit Function
    End If
    
    ' Obtener saldo actual
    saldoActual = ObtenerSaldo(idCuenta)
    
    ' Registrar transacción
    Set rst = db.OpenRecordset("tblTransacciones")
    rst.AddNew
    rst("IDCuenta") = idCuenta
    rst("TipoTransaccion") = "Deposito"
    rst("Monto") = monto
    rst("Fecha") = Now()
    rst("Descripcion") = descripcion
    rst("SaldoResultante") = saldoActual + monto
    rst.Update
    
    ' Actualizar saldo de la cuenta
    ActualizarSaldoCuenta idCuenta, monto
    
    rst.Close
    RegistrarDeposito = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al registrar depósito: " & Err.Description, vbCritical
    RegistrarDeposito = False
End Function

Public Function RegistrarRetiro(idCuenta As Long, monto As Currency, descripcion As String) As Boolean
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    Dim saldoActual As Currency
    
    Set db = CurrentDb()
    
    ' Validar monto
    If monto <= 0 Then
        MsgBox "El monto debe ser mayor a cero", vbCritical
        Exit Function
    End If
    
    ' Validar fondos disponibles
    saldoActual = ObtenerSaldo(idCuenta)
    If saldoActual < monto Then
        MsgBox "Fondos insuficientes. Saldo: " & saldoActual, vbCritical
        Exit Function
    End If
    
    ' Registrar transacción
    Set rst = db.OpenRecordset("tblTransacciones")
    rst.AddNew
    rst("IDCuenta") = idCuenta
    rst("TipoTransaccion") = "Retiro"
    rst("Monto") = monto
    rst("Fecha") = Now()
    rst("Descripcion") = descripcion
    rst("SaldoResultante") = saldoActual - monto
    rst.Update
    
    ' Actualizar saldo de la cuenta
    ActualizarSaldoCuenta idCuenta, -monto
    
    rst.Close
    RegistrarRetiro = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al registrar retiro: " & Err.Description, vbCritical
    RegistrarRetiro = False
End Function

Public Function RegistrarTransferencia(idCuentaOrigen As Long, idCuentaDestino As Long, monto As Currency, descripcion As String) As Boolean
    On Error GoTo ErrorHandler
    
    Dim saldoOrigen As Currency
    
    ' Validar fondos
    saldoOrigen = ObtenerSaldo(idCuentaOrigen)
    If saldoOrigen < monto Then
        MsgBox "Fondos insuficientes en la cuenta origen", vbCritical
        Exit Function
    End If
    
    ' Registrar retiro de cuenta origen
    If Not RegistrarRetiro(idCuentaOrigen, monto, "Transferencia a cuenta " & idCuentaDestino) Then
        Exit Function
    End If
    
    ' Registrar depósito en cuenta destino
    If Not RegistrarDeposito(idCuentaDestino, monto, "Transferencia de cuenta " & idCuentaOrigen) Then
        Exit Function
    End If
    
    RegistrarTransferencia = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al registrar transferencia: " & Err.Description, vbCritical
    RegistrarTransferencia = False
End Function

Public Function ActualizarSaldoCuenta(idCuenta As Long, monto As Currency) As Boolean
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    Dim nuevoSaldo As Currency
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("tblCuentasBancarias")
    
    rst.FindFirst "ID = " & idCuenta
    
    If rst.NoMatch Then
        MsgBox "Cuenta no encontrada", vbCritical
        Exit Function
    End If
    
    nuevoSaldo = rst("Saldo") + monto
    
    rst.Edit
    rst("Saldo") = nuevoSaldo
    rst.Update
    
    rst.Close
    ActualizarSaldoCuenta = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al actualizar saldo: " & Err.Description, vbCritical
    ActualizarSaldoCuenta = False
End Function

Public Function ObtenerHistorialTransacciones(idCuenta As Long, fechaInicio As Date, fechaFin As Date) As Object
    Dim db As Object
    Dim rst As Object
    Dim sql As String
    
    Set db = CurrentDb()
    
    sql = "SELECT * FROM tblTransacciones WHERE IDCuenta = " & idCuenta & _
          " AND Fecha BETWEEN #" & Format(fechaInicio, "mm/dd/yyyy") & "# AND #" & Format(fechaFin, "mm/dd/yyyy") & "#" & _
          " ORDER BY Fecha DESC"
    
    Set rst = db.OpenRecordset(sql)
    Set ObtenerHistorialTransacciones = rst
End Function

Public Function ValidarFondosDisponibles(idCuenta As Long, monto As Currency) As Boolean
    Dim saldoActual As Currency
    saldoActual = ObtenerSaldo(idCuenta)
    ValidarFondosDisponibles = (saldoActual >= monto)
End Function