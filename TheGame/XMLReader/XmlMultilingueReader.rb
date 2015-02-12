#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : XmlMultilingueReader.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
# Cette classe permet de parcourir les fichiers xml des r�f�rences de traduction du jeu et les ajoute dans des HashTables.
#

require 'rexml/document'
include REXML


class XmlMultilingueReader


	#=== Variable de classe ===
	@@FR_dicoObjet = Hash.new()
	@@FR_textesJeu = Hash.new()
	@@EN_dicoObjet = Hash.new()
	@@EN_textesJeu = Hash.new()
	  
	@@dicoObjetCourant=@@FR_dicoObjet
	@@textesJeuCourant=@@FR_textesJeu
	 
	@@LANGUE="FR"
  
  
	##
	# M�thode statique permettant de r�cup�rer les traductions fran�aises des objets et des textes du jeu
	# et de les ajouter � la HashTable correspondante.
	#
	def XmlMultilingueReader.lireXmlLangueFR()
		#Ouvre le fichier XML contenant les traductions des objets 
		begin
			file = File.new("XMLFile/Multilingue/FR/DicoObjetsJeu.xml")
			doc = Document.new(file)
		rescue
			puts "Impossible d'ouvrir le fichier langue des objets XML FR."
		end
		  
		#Pour chaque r�f�rence du fichier XML...
		doc.elements.each('objetsJeu/objet') do |s|
			#... on ajoute � la table
			@@FR_dicoObjet[s.elements['id'].text]=[s.elements['determinant'].text,s.elements['nom'].text]
		end
		 
		#Ouvre le fichier XML contenant les traductions des textes 
		begin
			file = File.new("XMLFile/Multilingue/FR/textesJeu.xml")
			doc = Document.new(file)
		rescue
			puts "Impossible d'ouvrir le fichier langue des textes XML FR."
		end
		  
		#Pour chaque r�f�rence du fichier XML...
		doc.elements.each('textesJeu/texte') do |s|
			#... on ajoute � la table
			@@FR_textesJeu[s.elements['id'].text]=s.elements['contenu'].text
		end
		return nil       
	end


	##
	# M�thode statique permettant de r�cup�rer les traductions anglaises des objets et des textes du jeu
	# et de les ajouter � la HashTable correspondante.
	#
	def XmlMultilingueReader.lireXmlLangueEN()
		#Ouvre le fichier XML contenant les traductions des objets 
		begin
			file = File.new("XMLFile/Multilingue/EN/DicoObjetsJeu.xml")
			doc = Document.new(file)
		rescue
			puts "Impossible d'ouvrir le fichier langue des objets XML EN."
		end
		
		#Pour chaque r�f�rence du fichier XML...
		doc.elements.each('objetsJeu/objet') do |s|
			#... on ajoute � la table
			@@EN_dicoObjet[s.elements['id'].text]=[s.elements['determinant'].text,s.elements['nom'].text]
		end
		  
		#Ouvre le fichier XML contenant les traductions des textes 
		begin
			file = File.new("XMLFile/Multilingue/EN/textesJeu.xml")
			doc = Document.new(file)
		rescue
			puts "Impossible d'ouvrir le fichier langue des textes XML EN."
		end
		  
		#Pour chaque r�f�rence du fichier XML...
		doc.elements.each('textesJeu/texte') do |s|
			#... on ajoute � la table
			@@EN_textesJeu[s.elements['id'].text]=s.elements['contenu'].text
		end
		return nil       
	end


	##
	# M�thode statique permettant d'initialiser chaque HashTable correspondantes aux objets/textes du jeu et � la langue FR/EN
	#
	def XmlMultilingueReader.lireXml()
		XmlMultilingueReader.lireXmlLangueFR()
		XmlMultilingueReader.lireXmlLangueEN()
	end
   
   
	##
	# M�thode statique permettant de changer la langue du jeu, et de choisir en cons�quence la HashTable � lire
	#
	#=== Param�tres:
	#* <b>idLangue</b> : une chaine de caract�res permettant de choisir la langue
	#
	def XmlMultilingueReader.setLangue(idLangue)
		case idLangue
		when "FR"
			@@dicoObjetCourant=@@FR_dicoObjet
			@@textesJeuCourant=@@FR_textesJeu
			@@LANGUE = "FR"
		when "EN"
			@@dicoObjetCourant=@@EN_dicoObjet
			@@textesJeuCourant=@@EN_textesJeu
			@@LANGUE = "EN"
		else
			@@dicoObjetCourant=@@FR_dicoObjet
			@@textesJeuCourant=@@FR_textesJeu
			@@LANGUE = "FR"
		end
	end
   
	   
	##
	# M�thode statique permettant de r�cup�rer la langue en cours
	#
	def XmlMultilingueReader.getLangue()
		return @@LANGUE
	end
    
    
	##
	# M�thode statique permettant de r�cup�rer la traduction d'un objet du jeu
	#
	#=== Param�tres:
	#* <b>objet</b> : l'objet dont on veut obtenir sa traduction (texte)
	#
	def XmlMultilingueReader.lireNom(objet)
		return @@dicoObjetCourant[objet.getIntitule()][1]
	end
   
   
	##
	# M�thode statique permettant de r�cup�rer la traduction d'un d�terminant d'un objet du jeu
	#
	#=== Param�tres:
	#* <b>objet</b> : l'objet dont on veut obtenir sa traduction (d�terminant)
	#
	def XmlMultilingueReader.lireDeterminant(objet)
		return @@dicoObjetCourant[objet.getIntitule()][0]
	end
  
  
	##
	# M�thode statique permettant de r�cup�rer la traduction enti�re (d�terminant + texte) d'un objet du jeu
	#
	#=== Param�tres:
	#* <b>objet</b> : l'objet dont on veut obtenir sa traduction
	#
	def XmlMultilingueReader.lireDeterminant_Nom(objet)
		determinant=@@dicoObjetCourant[objet.getIntitule()][0]
		
		if(determinant==nil)
			determinant=""
		end
		
		nom=@@dicoObjetCourant[objet.getIntitule()][1]
		return determinant+nom
	end
  
  
	##
	# M�thode statique permettant de r�cup�rer la traduction d'un texte du jeu
	#
	#=== Param�tres:
	#* <b>id</b> : l'id du texte dont on veut obtenir sa traduction
	#
	def XmlMultilingueReader.lireTexte(id)
		return @@textesJeuCourant[id]
	end
    
end
