# Folder Path
$dir = "$env:USERPROFILE\foldername"

# File Suffix
$FSFX = "mkv" ; 

# Subtitles Suffix
$SSFX = "srt" ; 

#file type Filter
$FFLT = '*.MKV'; $SFLT = '*.srt' ;

# Split strings
$FSplit = 'x264' ; $RS = '.720p' ;

#Folder containing full names MODIFY SUBFOLDER + $SFLT (subtitle names) VS $FFLT (FILE names)
$Names = @(Get-Childitem -LiteralPath "$dir\subfolder" -Filter $SFLT).name

$NSplit = '.x264.' # Split string (after Title) for above Name Template

$FFN = @(Get-Childitem -LiteralPath $dir -Filter $FFLT).name
$SRT = @(Get-Childitem -LiteralPath $dir -Filter $SFLT).name
$SSrc = @() ; $STRGT = @() ; $SSN = @()

for ($F = 0; $F -lt $FFN.count; $F++) { $NUM = $($F+1) ;
if ($NUM -le "9") { $NUM = "0$NUM" } ; $NUM = $NUM.ToString()

$SSN = "S01E$NUM" # MODIFY

$SSrc = $SRT.Where({$_ -match $SSN })
$FSrc = $FFN.Where({$_ -match $SSN })

# titles from $names folder
$Title = @(@($Names.Where({$_ -match $SSN }) -split $($SSN + '.').ToString())[1] -split $RS)[0]
$STRGT = $FFN.Where({$_ -match $SSN }) -replace "$FSFX","$SSFX"

#IF start
If ($Title -ne '' -and $STRGT -notmatch $Title) {
$STRGT = (($STRGT -split $FSplit)[0] + $FSplit + "." + $SSFX) -replace "$SSN",$($SSN + '.' + $Title)
$FTRGT = $STRGT -replace "$SSFX","$FSFX"
Rename-Item -LiteralPath ("$dir\$FSrc").ToString() "$FTRGT" 
Write-Host $FSrc -F cyan -NoNewline ; Write-Host " $FTRGT" -F green } #IF END

Rename-Item -LiteralPath ("$dir\$SSrc").ToString() "$STRGT"
Write-Host $SSrc -F Yellow -NoNewline ; Write-Host " $STRGT" -F green }




<#
# Fix double end after wrong/missing name split string ("264")
$SRTSrc = @() ; $SRTtarget = @()
for ($F = 0; $F -lt $MKV.count; $F++) { $NUM = $($F+1) ;
if ($NUM -le '9') { $NUM = "0$NUM" } ; $NUM = $NUM.ToString()
$SSN = "S02E$NUM"
$SRTSrc = $SRT.Where({$_ -match "$SSN" })
$MKVSrc = $MKV.Where({$_ -match $SSN })
$Title = @(@($Names.Where({$_ -match $SSN }) -split $($SSN + '.').ToString())[1] -split ".x264.")[0]
$SRTtarget = $SRTSrc -replace "$($Title + ".srt.")"
$MKVtarget = $MKVSrc -replace "$($Title + '.mkv.')"
Rename-Item -LiteralPath ("$dir\$SRTSrc").ToString() "$SRTtarget"
Rename-Item -LiteralPath ("$dir\$MKVSrc").ToString() "$MKVtarget"
}
#>


<#
$Stemplate = @{ LiteralPath = $("$dir\$SSrc").ToString()
    NewName = $('Title' + $SSN + '.' + $title + 'fileinfo' + $SSFX) }
$Ftemplate = @{ LiteralPath = $("$dir\$FSrc").ToString()
    NewName = $('Title' + $SSN + '.' + $title + 'fileinfo' + $FSFX) }
# Fix double end after wrong/missing name split string ("264")
$dir = "$env:USERPROFILE\Downloads\foldername"
$Names = @(Get-Childitem -LiteralPath "$dir\ara" -Filter $SFLT).name
$FSFX = "mkv" ; $SSFX = "srt" ; $FFLT = '*.MKV';
$SFLT = '*.srt' ; $FSplit = 'x264' ; $RS = '.NF.' ; $NSplit = '.x264.'
$FFN = @(Get-Childitem -LiteralPath $dir -Filter $FFLT).name
$SRT = @(Get-Childitem -LiteralPath $dir -Filter $SFLT).name
for ($F = "0" ; $F -lt $FFN.count; $F++) { $NUM = $($F+1) ;
if ($NUM -lt "10") { $NUM = "0$NUM" } ; $NUM = $NUM.ToString()
$SSN = "S02E$NUM"
$SSrc = $SRT.Where({$_ -match "$SSN" })
$FSrc = $FFN.Where({$_ -match $SSN })
$Title = @(@($Names.Where({$_ -match $SSN }) -split $($SSN + '.').ToString())[1] -split $RS)[0]
#Rename-Item @Stemplate
#Rename-Item @Ftemplate
Write-Host $FSrc -F cyan -NoNewline ; Write-Host $Ftemplate.Values -F green 
Write-Host $SSrc -F Yellow -NoNewline ; Write-Host $Stemplate.Values -F green
}#>