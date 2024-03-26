# Va chercher le chemin racine du script
$varCheminDuScript = $MyInvocation.MyCommand.Path
$varCheminRacine = [io.path]::GetDirectoryName($varCheminDuScript)
$uniteEstimationTempsSec = "sec"
$uniteEstimationTempsMin = "min"
$LangSET = "EN"

## DEBUT DU FORMULAIRE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
# Importer les bibliotheques necessaires pour creer des interfaces graphiques
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Créer une nouvelle instance de la classe Form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'NoAFK'
$form.Icon = New-Object System.Drawing.Icon ($varCheminRacine + "\butterfly.ico")
$form.Size = New-Object System.Drawing.Size (380,400)
$form.StartPosition = 'CenterScreen'
$Form.Opacity = [System.Double]0.8

# NB Iterations
# Créer un controle Label pour afficher un texte
$labelNbIterations = New-Object System.Windows.Forms.Label
$labelNbIterations.Location = New-Object System.Drawing.Point (10,54)
$labelNbIterations.Size = New-Object System.Drawing.Size (190,20)
$labelNbIterations.Text = "number of iterations to do :"
$form.Controls.Add($labelNbIterations)
# Créer un controle NumericUpDown pour saisir un nombre entier
$ValNbIterations = New-Object System.Windows.Forms.NumericUpDown
$ValNbIterations.Location = New-Object System.Drawing.Point (260,50)
$ValNbIterations.Size = New-Object System.Drawing.Size (80,20)
$ValNbIterations.Minimum = 1
$ValNbIterations.Maximum = 10000
$ValNbIterations.Value = 10
$form.Controls.Add($ValNbIterations)

# Créer un controle Label pour afficher => En millisecondes :
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point (10,85)
$label2.Size = New-Object System.Drawing.Size (250,30)
$label2.Text = " => In milliseconds :"
$form.Controls.Add($label2)

#Tempo entre iterations
# Créer un contrôle Label pour afficher un texte Temps entre itérations
$labelPauseEntre2 = New-Object System.Windows.Forms.Label
$labelPauseEntre2.Location = New-Object System.Drawing.Point (30,115)
$labelPauseEntre2.Size = New-Object System.Drawing.Size (150,30)
$labelPauseEntre2.Text = "pause between 2 iterations :"
$form.Controls.Add($labelPauseEntre2)
# Créer un contrôle NumericUpDown pour saisir un nombre entier Temps entre itérations
$ValPauseEntre2 = New-Object System.Windows.Forms.NumericUpDown
$ValPauseEntre2.Location = New-Object System.Drawing.Point (260,112)
$ValPauseEntre2.Size = New-Object System.Drawing.Size (80,20)
$ValPauseEntre2.Minimum = 1
$ValPauseEntre2.Maximum = 100000
$ValPauseEntre2.Value = 1000
$form.Controls.Add($ValPauseEntre2)

#Tempo entre lettres
# Créer un contrôle Label pour afficher un texte Temps entre lettres
$labelPauseEntreLettres = New-Object System.Windows.Forms.Label
$labelPauseEntreLettres.Location = New-Object System.Drawing.Point (30,145)
$labelPauseEntreLettres.Size = New-Object System.Drawing.Size (150,30)
$labelPauseEntreLettres.Text = "pause after each letter :"
$form.Controls.Add($labelPauseEntreLettres)
# Créer un contrôle NumericUpDown pour saisir un nombre entier Temps entre lettres
$ValPauseEntreLettres = New-Object System.Windows.Forms.NumericUpDown
$ValPauseEntreLettres.Location = New-Object System.Drawing.Point (260,142)
$ValPauseEntreLettres.Size = New-Object System.Drawing.Size (80,20)
$ValPauseEntreLettres.Minimum = 1
$ValPauseEntreLettres.Maximum = 100000
$ValPauseEntreLettres.Value = 500
$form.Controls.Add($ValPauseEntreLettres)

#Tempo avant d effacer le mot affiche
# Creeer un controle Label pour afficher un texte pause fin de mot
$labelPauseFinMot = New-Object System.Windows.Forms.Label
$labelPauseFinMot.Location = New-Object System.Drawing.Point (30,175)
$labelPauseFinMot.Size = New-Object System.Drawing.Size (150,30)
$labelPauseFinMot.Text = "pause end of word :"
$form.Controls.Add($labelPauseFinMot)
# Créer un contrôle NumericUpDown pour saisir un nombre entier pause fin de mot
$ValPauseFinMot = New-Object System.Windows.Forms.NumericUpDown
$ValPauseFinMot.Location = New-Object System.Drawing.Point (260,172)
$ValPauseFinMot.Size = New-Object System.Drawing.Size (80,20)
$ValPauseFinMot.Minimum = 1
$ValPauseFinMot.Maximum = 100000
$ValPauseFinMot.Value = 1000
$form.Controls.Add($ValPauseFinMot)

# Hasard
# Créer un controle Label pour afficher un texte
$labelRandom = New-Object System.Windows.Forms.Label
$labelRandom.Location = New-Object System.Drawing.Point (10,205)
$labelRandom.Size = New-Object System.Drawing.Size (190,20)
$labelRandom.Text = "% of random to simulate a human :"
$form.Controls.Add($labelRandom)
# Créer un controle NumericUpDown pour saisir un nombre entier
$ValRandom = New-Object System.Windows.Forms.NumericUpDown
$ValRandom.Location = New-Object System.Drawing.Point (260,202)
$ValRandom.Size = New-Object System.Drawing.Size (80,20)
$ValRandom.Minimum = 1
$ValRandom.Maximum = 100
$ValRandom.Value = 50
$form.Controls.Add($ValRandom)

# Creer un controle Label pour afficher les infos
$Infos = New-Object System.Windows.Forms.Label
$Infos.Location = New-Object System.Drawing.Point (10,290)
$Infos.Size = New-Object System.Drawing.Size (350,40)
$Infos.Text = 'Select a text area. The script will run in 5 seconds'
$Infos.ForeColor = 'Red'
$form.Controls.Add($Infos)

# Creer un controle Button pour valider la saisie
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point (120,330)
$okButton.Size = New-Object System.Drawing.Size (75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

# Creer un controle Button pour annuler la saisie
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point (200,330)
$cancelButton.Size = New-Object System.Drawing.Size (75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

#Affichage dynamique du temps estimee ********************
$labelestimation = New-Object System.Windows.Forms.Label
$labelestimation.Location = New-Object System.Drawing.Point (40,245)
$labelestimation.Size = New-Object System.Drawing.Size (110,30)
$labelestimation.Text = "estimated duration : "
$labelestimation.ForeColor = 'Green'
$form.Controls.Add($labelestimation)
#Value a faire evoluer
$estimation = ($ValNbIterations.Value * ($ValPauseEntre2.Value + (7 * $ValPauseEntreLettres.Value) + $ValPauseFinMot.Value)) / 1000
$Resultestimation = New-Object System.Windows.Forms.Label
$Resultestimation.Location = New-Object System.Drawing.Point (160,245)
$Resultestimation.Size = New-Object System.Drawing.Size (100,30)
$Resultestimation.Text = " $estimation $uniteEstimationTempsSec"
$Resultestimation.ForeColor = 'Green'
$form.Controls.Add($Resultestimation)

##FONCTION Mise à jour Temps estimé
function MiseAJourEstimation {
    $estimation = ($ValNbIterations.Value * ($ValPauseEntre2.Value + (7 * $ValPauseEntreLettres.Value) + $ValPauseFinMot.Value)) / 1000
    if ($estimation -gt 600) {
        $estimation = [math]::Round($estimation / 60, 2)  # Arrondi à 2 décimales
        $Resultestimation.Text = "$estimation $uniteEstimationTempsMin"
        }
    else {    $Resultestimation.Text = "$estimation $uniteEstimationTempsSec"}
}

#Surveillance du changement
$ValNbIterations.add_ValueChanged({
    MiseAJourEstimation
})
$ValPauseEntre2.add_ValueChanged({
    MiseAJourEstimation
})
$ValPauseEntreLettres.add_ValueChanged({
    MiseAJourEstimation
})
$ValPauseFinMot.add_ValueChanged({
    MiseAJourEstimation
})


# Modification de la langue
    # Cr�er un text area pour stocker la valeur de la langue
    $LanguageVariable = New-Object System.Windows.Forms.TextBox
    $LanguageVariable.Location = New-Object System.Drawing.Point (210,17)
    $LanguageVariable.Size = New-Object System.Drawing.Size (30,20)
    $LanguageVariable.Text = $LangSET ## detecter automatiquement la langue
    $form.Controls.Add($LanguageVariable)


    # Cr�er un contr�le combo box pour afficher les langues disponibles
    $LanguageComboBox = New-Object System.Windows.Forms.ComboBox
    $LanguageComboBox.Location = New-Object System.Drawing.Point(240,17)
    $LanguageComboBox.Size = New-Object System.Drawing.Size(100,20)
    # Ajouter les langues au combo box
    $LanguageComboBox.Items.Add("English")
    $LanguageComboBox.Items.Add("Français")
    $LanguageComboBox.Items.Add("Español")
    # S�lectionner la langue actuelle
    $LanguageComboBox.SelectedItem = "English"
    # D�finir l'�v�nement SelectedIndexChanged du combo box
    $LanguageComboBox.Add_SelectedIndexChanged({
        # Modifier la langue du formulaire principal en fonction de la s�lection
        switch ($LanguageComboBox.SelectedItem) {
            "Français" {
                # Changer le texte des contr�les du formulaire principal en fran�ais
                $form.Text = "NoAFK (Fr)"
                $labelNbIterations.Text = "nombre d'itérations à faire :"
                $label2.Text = " => En millisecondes :"
                $labelPauseEntre2.Text = "pause entre 2 itérations :"
                $labelPauseEntreLettres.Text = "pause après chaque lettre :"
                $labelPauseFinMot.Text = "pause fin de mot :"
                $Infos.Text = 'Selectionner une zone de texte. Le script s executera dans 5 secondes'
                # Changer le texte des options du menu strip en fran�ais
                $AboutMenuItem.Text = "A Propos"
                $labelestimation.Text = "estimation duree : "
                $labelRandom.Text = "% de hasard (simule un humain) :"
                $LanguageVariable.Text = "FR"
            }
            "English" {
                # Changer le texte des contr�les du formulaire principal en anglais
                $form.Text = "NoAFK (En)"
                $labelNbIterations.Text = "number of iterations to do :"
                $label2.Text = " => In milliseconds :"
                $labelPauseEntre2.Text = "pause between 2 iterations :"
                $labelPauseEntreLettres.Text = "pause after each letter :"
                $labelPauseFinMot.Text = "pause end of word :"
                $Infos.Text = 'Select a text area. The script will run in 5 seconds'
                # Changer le texte des options du menu strip en anglais
                $AboutMenuItem.Text = "About"
                $labelestimation.Text = "estimated duration : "
                $labelRandom.Text = "% of random to simulate a human :"
                $LanguageVariable.Text = "EN"
            }
            "Español" {
                # Changer le texte des contr�les du formulaire principal en espagnol
                $form.Text = "NoAFK (Es)"
                $labelNbIterations.Text = "número de iteraciones a hacer :"
                $label2.Text = " => En milisegundos :"
                $labelPauseEntre2.Text = "pausa entre 2 iteraciones :"
                $labelPauseEntreLettres.Text = "pausa después de cada letra :"
                $labelPauseFinMot.Text = "pausa fin de palabra :"
                $Infos.Text = 'Seleccione un área de texto. El script se ejecutará en 5 segundos'
                # Changer le texte des options du menu strip en espagnol
                $AboutMenuItem.Text = "Acerca de"
                $labelestimation.Text = "duración estimada : "
                $labelRandom.Text = "% de azar para simular un humano :"
                $LanguageVariable.Text = "ES"
            }
        }
    })
    # Ajouter le combo box aux contr�les du formulaire
    $Form.Controls.Add($LanguageComboBox)


# *********************************************************


# Cr�er un objet menu strip
$MenuStrip = New-Object System.Windows.Forms.MenuStrip
# Ajouter le menu strip aux contr�les du formulaire
$form.Controls.Add($MenuStrip)

# Cr�er un objet menu item pour l'option About
$AboutMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem
# D�finir le texte du menu item
$AboutMenuItem.Text = "About"
# D�finir l'�v�nement Click du menu item
$AboutMenuItem.Add_Click({
    # Cr�er un autre formulaire pour afficher les informations sur le script
    $AboutForm = New-Object System.Windows.Forms.Form
    $AboutForm.Text = "About"
    $AboutForm.Size = New-Object System.Drawing.Size(300,200)
    $AboutForm.AutoSize = true
    $AboutForm.AutoSizeMode = GrowAndShrink
    $AboutForm.Auto
    $AboutForm.StartPosition = "CenterScreen"
    # Cr�er un contr�le label pour afficher le texte
    $AboutLabel = New-Object System.Windows.Forms.Label
    $AboutLabel.Text = "NoAFK Keyboard simulator. By Kiloloan. more info here : https://github.com/kiloloan/NoAFK "
    $AboutLabel.AutoSize = $true
    $AboutLabel.Location = New-Object System.Drawing.Point(10,10)
    # Ajouter le label aux contr�les du formulaire
    $AboutForm.Controls.Add($AboutLabel)
    # Afficher le formulaire
    $AboutForm.ShowDialog()
})
# Ajouter le menu item au menu strip
$MenuStrip.Items.Add($AboutMenuItem)



## FIN DU FORMULAIRE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##