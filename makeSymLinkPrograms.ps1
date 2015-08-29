Get-ChildItem ".\*.lua" | ForEach-Object {
    $smallName = $_.BaseName
    $bigName = $_.Name

    #Write-Output $smallName

    $command = "cmd /c mklink /h"
    $link = "`.`.\$smallName"
    $target = ".\$bigName"

    invoke-expression "$command $link $target"
}