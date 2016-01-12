'------------------------------------------------------------
' ConvFile.vbs
' 实现Dos和Unix文本文件的相互转换
' benbenknight
Function ConvUnixToDos(strInfo)
' 将字符串从Unix换行格式转为Dos换行格式
' 即将vbCr替换为vbCrLf
    ' 先将vbCrLf换成vbCr
    ConvUnixToDos = Replace(strInfo, vbCrLf, vbLf)
    ' 先将vbCr换成vbCrLf
    ConvUnixToDos = Replace(ConvUnixToDos, vbLf, vbCrLf)
    
End Function
Function ConvDosToUnix(strInfo)
' 将字符串从Dos换行格式转为Unix换行格式
' 即将vbCrLf替换为vbCr
    ConvDosToUnix = Replace(strInfo, vbCrLf, vbLf)
    
End Function
Function ReadFileToString(strFilePath)
' 将文本文件读入到字符串中
' strFilePath 文本文件全路径
    ' 文件读写标志
    Const ForReading = 1
    
    ' 打开文件
    Set ofs = CreateObject("Scripting.FileSystemObject")
    Set ofile = ofs.OpenTextFile(strFilePath, ForReading, True)
    
    ' 读出文件
    ReadFileToString = ofile.ReadAll
    ' 关闭文件
    ofile.Close
    
End Function
Sub WriteStringToFile(strFilePath, strInfo)
' 将字符串写入文本文件
' strFilePath 文本文件全路径
' strInfo 字符串
    ' 文件读写标志
    Const ForWriting = 2
    Const isCreateNew = True
    Set ofs = CreateObject("Scripting.FileSystemObject")
    
    ' 打开文件
    Set ofile = ofs.OpenTextFile(strFilePath, ForWriting, isCreateNew)
    
    ' 写入文件
    ofile.Write strInfo
    
    '关闭文件
    ofile.Close
    
End Sub
   
    strSrcFile = "d:\merge_dos.txt"
    strDestFile = "d:\merge_unix.txt"
    strDestFile2 = "d:\merge_dos2.txt"
    
    ' 将Dos文件转为Unix文件
    strDos = ReadFileToString(strSrcFile)
    strUnix = ConvDosToUnix(strDos)
    WriteStringToFile strDestFile, strUnix
    
    ' 将Unix文件转为Dos文件
    strUnix = ReadFileToString(strDestFile)
    strDos = ConvUnixToDos(strUnix)
    WriteStringToFile strDestFile2, strDos