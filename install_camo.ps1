[xml]$camouflagesXML=Get-Content .\camouflages.xml
$colorSchemes=Select-Xml -Xml $camouflagesXML -XPath '//data/ColorSchemes'

$newCamo=Select-Xml -Xml $camouflagesXML -XPath '//data/ColorSchemes/colorScheme[1]'
$newCamo=$newCamo.Node.CloneNode($true)

$newCamo.name='colorSchemeUSNSalem'
$newCamo.color0='0.143 0.143 0.143 0.784'
$newCamo.color1='0.020 0.020 0.020 1.000'
$newCamo.color2='0.177 0.205 0.216 1.000'
$newCamo.color3='0.300 0.300 0.300 1.000'
#$newCamo.colorUI='0.338 0.408 0.486 1.000'

$colorSchemes.Node.AppendChild($camouflagesXML.CreateComment('USN Salem Post-war Camo'))
$colorSchemes.Node.AppendChild($newCamo)

$salemCamo=Select-Xml -Xml $camouflagesXML -XPath '//data/Camouflages/camouflage[annotation="Salem unique permOflage block"]'
$salemCamo.Node.Textures.Gun='content/gameplay/common/camouflage/textures/R_gun_camo_03.dds'
$newColorScheme=$camouflagesXML.CreateElement('colorSchemes')
$newColorScheme.InnerText='colorSchemeUSNSalem'
$salemCamo.Node.ReplaceChild($newColorScheme,$salemCamo.Node.SelectSingleNode('./colorSchemes[1]'))

$camouflagesXML.Save('.\test.xml')