# NoAFK v1.2
# KeyBoard Simulator / Simulateur de Clavier
# by Kiloloan
# URL du projet : https://github.com/kiloloan/NoAFK


# Va chercher le chemin racine du script
$varCheminDuScript = $MyInvocation.MyCommand.Path
$varCheminRacine = [io.path]::GetDirectoryName($varCheminDuScript)
$varCheminForm = ($varCheminRacine + "\res\NoAFK.Form3.ps1")
write-host $varCheminForm


Import-Module -Name $varCheminForm -Verbose -Force

## charge fonctions 
function Start-RandomSleep {
    param (
        [int]$inputMilliseconds
    )

    # Définir les facteurs de marge (par exemple, 50 %)
    $lowerFactor = 1 - $RandomFactor
    $upperFactor = 1 + $RandomFactor
   # Write-Output "Random $RandomFactor"

    # Calculer les bornes de la plage en utilisant les facteurs
    $minRange = $inputMilliseconds * $lowerFactor
    $maxRange = $inputMilliseconds * $upperFactor

    # Générer un nombre aléatoire entre $minRange et $maxRange
    $randomMilliseconds = Get-Random -Minimum $minRange -Maximum $maxRange

    # Faire une pause
   # Write-Output "Pause = $randomMilliseconds || $lowerFactor - $upperFactor"
    Start-Sleep -Milliseconds $randomMilliseconds
}
##############################


# Afficher le formulaire et récupérer le résultat
$result = $form.ShowDialog()

# Si l'utilisateur a cliqué sur OK, récupérer la valeur saisie
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $iterations = $ValNbIterations.Value
    $tempoEntreMot = $ValPauseEntre2.Value
    $tempoEntreLettres = $ValPauseEntreLettres.Value
    $tempoFinMot = $ValPauseFinMot.Value
    $LangSET = $LanguageVariable.Text
    $RandomFactor = $ValRandom.Value / 100
    $DelSET = $cbSupress.Checked
    Write-Output $LangSET
      }


# Importer la bibliothèque System.Web pour générer des mots de passe aléatoires
Add-Type -AssemblyName System.Web

# Lire le contenu du fichier mots.txt et le stocker dans la variable $mots
$varCheminDico = ("$varCheminRacine\dico" + $LangSET + ".txt")
Write-Output $varCheminDico
$mots = Get-Content -Path $varCheminDico -Force


# Créer une nouvelle instance de la classe Wscript.Shell
$wshell = New-Object -ComObject wscript.shell

# Sélectionner le champ de saisie de recherche Dutler
# https://dutler.group/search
# 2 secondes pour le faire

Start-Sleep -MilliSeconds 5000


# Faire une boucle du nombre d'itérations demandé
For ($i = 1; $i -le $iterations; $i++) {
    Write-Output "n° $i / $iterations"
    # Choisir un mot aléatoire dans la variable $mots et l'envoyer au champ de saisie
    $mot = Get-Random -InputObject $mots
    # $wshell.SendKeys($mot)
        # Envoyer chaque lettre du mot au champ de saisie
        foreach ($lettre in $mot.ToCharArray()) {
        $wshell.SendKeys($lettre)
        Start-RandomSleep -inputMilliseconds $tempoEntreLettres
        }

    #pause fin de mot saisie
    Start-RandomSleep -inputMilliseconds $tempoFinMot

    # Effacer le même nombre de caractères que le mot choisi
    if($DelSET -eq 'true'){
        $wshell.SendKeys("{BS $($mot.Length)}")

        #pause fin de mot
        $wshell.SendKeys($i)
        Start-RandomSleep -inputMilliseconds $tempoEntreMot
        $wshell.SendKeys("{BS $(([string]$i).Length)}")
        } 
    else {
        $wshell.SendKeys(" ")
        }
}
$wshell.SendKeys("ok")



