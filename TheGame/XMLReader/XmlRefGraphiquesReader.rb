#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlRefGraphiquesReader.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir le fichier XML des r�f�rences graphiques et le les ajouter � la "biblioth�que" RefGraphiques (classe RefGraphiques).
#

require 'VUE/ReferencesGraphiques.rb'
require 'rexml/document'
include REXML


class XmlRefGraphiquesReader


   ##
   # M�thode statique permettant de r�cup�rer les r�f�rences graphiques des diff�rentes �l�ments d'affichages du jeu
   # et de les ajouter � la biblioth�que d'images du jeu (biblioth�que RefGraphiques).
   #
	#=== Param�tres:
	#* <b>biblioRefGgraphiques</b> : la classe ReferencesGraphiques
	#
   def XmlRefGraphiquesReader.lireXml(biblioRefGgraphiques)
      #Ouvre le fichier XML contenant les r�f�rences graphiques des diff�rents �l�ments
      begin
         file = File.new("XMLFile/references_graphiques.xml")
         doc = Document.new(file)
      rescue
         raise "Impossible d'ouvrire le fichier XML des r�f�rences graphiques."
      end

      #Pour chaque r�f�rence du fichier XML...
      doc.elements.each('ref_graphiques/reference') do |s|
         #... on ajout la r�f�rence � la biblioth�que
         biblioRefGgraphiques.addRefGraphique(s.elements['intitule_objet'].text,s.elements['img_ihm'].text)
      end
		return nil
   end

end
