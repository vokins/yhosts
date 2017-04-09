Const T_GATEWAY = "192.168.1.1" 'อ๘นุ
Const T_NEWDNS1 = "114.114.114.119" 'DNS1
Const T_NEWDNS2 = "8.8.4.4" 'DNS2
strWinMgmt="winmgmts:{impersonationLevel=impersonate}"
Set NICS = GetObject( strWinMgmt ).InstancesOf("Win32_NetworkAdapterConfiguration")
For Each NIC In NICS
If NIC.IPEnabled Then
NIC.SetDNSServerSearchOrder Array(T_NEWDNS1,T_NEWDNS2)
NIC.SetGateways Array(T_GATEWAY)
End If
Next
