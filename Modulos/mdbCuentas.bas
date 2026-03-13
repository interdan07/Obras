Option Explicit

' Módulo de Gestión de Cuentas Bancarias
' Funciones CRUD para administrar cuentas

Public Function AgregarCuenta(numeroCuenta As String, nombreBanco As String, tipoCuenta As String, saldoInicial As Currency) As Boolean
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("tblCuentasBancarias")
    
    ' Validaciones
    If numeroCuenta = "" Then
        MsgBox "El número de cuenta es requerido", vbCritical
        Exit Function
    End If
    
    If saldoInicial < 0 Then
        MsgBox "El saldo no puede ser negativo", vbCritical
        Exit Function
    End If
    
    ' Agregar nuevo registro
    rst.AddNew
    rst("NumeroCuenta") = numeroCuenta
    rst("NombreBanco") = nombreBanco
    rst("TipoCuenta") = tipoCuenta
    rst("Saldo") = saldoInicial
    rst("FechaCreacion") = Now()
    rst("Estado") = "Activa"
    rst.Update
    
    rst.Close
    AgregarCuenta = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al agregar cuenta: " & Err.Description, vbCritical
    AgregarCuenta = False
End Function

Public Function ActualizarCuenta(idCuenta As Long, nombreBanco As String, tipoCuenta As String) As Boolean
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("tblCuentasBancarias")
    
    rst.FindFirst "ID = " & idCuenta
    
    If rst.NoMatch Then
        MsgBox "Cuenta no encontrada", vbCritical
        Exit Function
    End If
    
    rst.Edit
    rst("NombreBanco") = nombreBanco
    rst("TipoCuenta") = tipoCuenta
    rst.Update
    
    rst.Close
    ActualizarCuenta = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al actualizar cuenta: " & Err.Description, vbCritical
    ActualizarCuenta = False
End Function

Public Function ObtenerCuenta(idCuenta As Long) As Object
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("tblCuentasBancarias")
    
    rst.FindFirst "ID = " & idCuenta
    
    If rst.NoMatch Then
        Set ObtenerCuenta = Nothing
    Else
        Set ObtenerCuenta = rst
    End If
End Function

Public Function ObtenerSaldo(idCuenta As Long) As Currency
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("SELECT Saldo FROM tblCuentasBancarias WHERE ID = " & idCuenta)
    
    If rst.RecordCount > 0 Then
        ObtenerSaldo = rst("Saldo")
    Else
        ObtenerSaldo = 0
    End If
    
    rst.Close
End Function

Public Function ListarCuentas() As Object
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("SELECT * FROM tblCuentasBancarias WHERE Estado = 'Activa'")
    
    Set ListarCuentas = rst
End Function

Public Function EliminarCuenta(idCuenta As Long) As Boolean
    On Error GoTo ErrorHandler
    
    Dim db As Object
    Dim rst As Object
    
    Set db = CurrentDb()
    Set rst = db.OpenRecordset("tblCuentasBancarias")
    
    rst.FindFirst "ID = " & idCuenta
    
    If rst.NoMatch Then
        MsgBox "Cuenta no encontrada", vbCritical
        Exit Function
    End If
    
    rst.Edit
    rst("Estado") = "Inactiva"
    rst.Update
    
    rst.Close
    EliminarCuenta = True
    Exit Function
    
ErrorHandler:
    MsgBox "Error al eliminar cuenta: " & Err.Description, vbCritical
    EliminarCuenta = False
End Function
