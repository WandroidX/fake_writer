function Fake-Write 
{
  Param 
  (
    [Parameter(Mandatory)] [ValidateNotNullOrEmpty()]
    [string] $TextToWrite,
    [string] $Program = 'typingmaster pro' ,
    [ValidateRange(1, 1000000)]
    [int] $ErrorsAmount,
    [bool] $CanDelete = $true,
    [ValidateRange(0, 1000000)]
    [int] $CharInterval = 0
  )


  $wshell = New-Object -ComObject wscript.shell
  if ( $wshell.AppActivate($Program))
  {


    [string[]] $TextChars = $TextToWrite.ToCharArray()
    if ($ErrorsAmount) 
    {

      [object[]] $ChangedIndex = @()
      for ($i = 1; $i -lt $ErrorsAmount; $i++) 
      {
        Write-Verbose "tomando el caracter no. $i"
        do{
          [int] $IndexCharToChange = Get-Random(0..$TextChars.Length)
          [string] $CorrectChar = $TextChars[$IndexCharToChange]

        } while ($ChangedIndex -contains $IndexCharToChange)

        Write-Verbose "tomando el caracter de error no. $i"
        do {
          [int] $IndexCharError = Get-Random(0..$TextChars.Length)
          [string] $CharError = $TextChars[$IndexCharError]
        } until ($CharError -ne $CorrectChar)

        if ($CanDelete)
        {
          $TextChars[$IndexCharToChange] = "$CharError{BACKSPACE}$CorrectChar"
        } else {
          $TextChars[$IndexCharToChange] = "$CharError"
        }
        $ChangedIndex += $IndexCharToChange
      }
    }

    #Write-Verbose "Escribiendo caracteres"
    Write-Host "Caracteres: $TextChars"
    foreach ($Char in $TextChars) 
    {
      Start-Sleep -Milliseconds $CharInterval
      $wshell.SendKeys($Char)
    }
  } else {
    Write-Host "No se ha ejecutado la función completamente debido a que el programa ($Program) no ha sido activado o su nombre no es correcto. Por favor, revíselo."
  }
}

Fake-Write -Program 'Klavaro - fluidez' -TextToWrite "Another scenario where you would implement an additional check is if you needed to combine several parameters. For instance, if you had a script that took two parameters, Directory and FileName, and you combine them later in the script, you can t test for their combined value by using the current validation attributes.~" -ErrorsAmount 10 -Verbose
