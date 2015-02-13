#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlRefSonsReader.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir le fichier XML des r�f�rences sons et de les ajouter � la "biblioth�que" RefSons (classe BibliothequeRefSons).
#

require 'sdl'
require 'rexml/document'
include REXML


class XmlRefSonsReader


   ##
   # M�thode statique permettant de r�cup�rer les diff�rents sons du jeu
   # et de les ajouter � la liste des sons du jeu (liste listRefSons).
   #
   #=== Param�tres:
	#* <b>listRefSons</b> : la liste contenant tout les sons
	#* <b>listRefChannel</b> : la liste contenant les num�ros de channel attribu�s � chaque son
	#
   def XmlRefSonsReader.lireXml(listRefSons, listRefChannel)
      #Ouvre le fichier XML contenant les sons du jeu
      begin
         file = File.new("XMLFile/references_sons.xml")
         doc = Document.new(file)
      rescue
         raise "Impossible d'ouvrire le fichier XML des r�f�rences sons."
      end

      #Pour chaque r�f�rence du fichier XML...
      channel = 0
      doc.elements.each('ref_sons/reference') do |s|
         #... on ajout la r�f�rence � la biblioth�que
         listRefSons[s.elements['intitule_objet'].text] = SDL::Mixer::Wave.load(s.elements['son'].text)
         listRefChannel[s.elements['intitule_objet'].text] = channel
         channel += 1
      end
		return nil
   end

end
