#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlTerrainsReader.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir le fichier XML des terrains et de les ajouter � la biblioth�que correspondante.
#

require 'MODELE/Bibliotheque/BibliothequeTypeTerrain.rb'
require 'MODELE/Type/TypeTerrain.rb'
require 'rexml/document'
include REXML


class XmlTerrainsReader
    
    
	##
	# M�thode statique permettant de r�cup�rer les terrains et de les ajouter � la biblioth�que correspondante
	#
	def XmlTerrainsReader.lireXml()
		#Ouvre le fichier XML contenant les r�f�rences 
		begin
			file = File.new("XMLFile/types_terrains.xml")
			doc = Document.new(file)
		rescue
			puts "Impossible d'ouvrir le fichier XML des terrains."
		end
		  
		#Pour chaque r�f�rence du fichier XML...
		doc.elements.each('types_terrains/type') do |s|
			#... on ajoute � la biblioth�que
			BibliothequeTypeTerrain.ajouter(s.elements['intitule'].text,
													TypeTerrain.creer(
														s.elements['intitule'].text, 
														eval(s.elements['isAccessible'].text),
														s.elements['coutDeplacement'].text.to_f,
														s.elements['proba'].text.to_f,
														s.elements['niveau'].text.to_i
													)
			)
		end
		return nil
	end
    
    
end
