#COMOK
#!/usr/bin/env ruby 

## 
# Fichier        : YamlSlot.rb 
# Auteur         : L3SPI - Groupe de projet B 
# Fait partie de : TheGame 
# 
#===Cette classe permet de parcourir le fichier Yaml d'un slot de sauvegarde. Elle permet de lire les infos du fichier yaml
# mais �galement d'�crire dedans pour sauvegarder les informations d'une partie.
#

# Pour enregistrer la date du jour dans les informations de sauvegarde
require 'date'

require 'VUE/BibliothequeSlot.rb'
require 'VUE/Slot.rb'

require 'yaml.rb'

class YamlSlot
   
 
   # M�thode statique permettant de r�cup�rer les informations d'un slot de sauvegarde
   # et de les ajouter � la liste des infos d'un slot de sauvegarde (classe Slot).
   #
   #=== Param�tres : 
	#* <b>nomFicSlotYaml :</b> une chaine de caract�res correspondant au nom du fichier yaml � lire
	#
   def YamlSlot.lireYaml(nomFicSlotYaml)
      #Ouvre le fichier YAML contenant les infos du slot "nomFicXml"
      begin
         file = File.open("YAMLSlot/" + nomFicSlotYaml)
      rescue
         raise "Impossible d'ouvrir le fichier YAMLSlot/" + nomFicSlotYaml
      end

		tabElement = Array.new
		
		# r�cup�re chaque objet contenu dans le doc YAML et les stockent dans un tableau
		YAML.load_documents(file) do |obj| 
			tabElement.push(obj)
		end
		
		pseudo 	= tabElement[0]
		nomDiff 	= tabElement[1]
		date 		= tabElement[2]
		temps 	= tabElement[3]
		modele 	= tabElement[4]
		
		# Ajoute le pseudo du joueur, la difficult�, la date, le temps de jeu et le modele aux informations du slot
      BibliothequeSlot.ajouter(nomFicSlotYaml, 
      							Slot.creer(nomFicSlotYaml, pseudo, nomDiff, date, temps, modele))
 
   end
   

	##
   # M�thode statique permettant d'ajouter les infos pour la sauvegarde d'un joueur au fichier YAML (slotX.yaml)
   #
   #=== Param�tres : 
	#* <b>nomFicSlotYaml :</b> une chaine de caract�res correspondant au nom du fichier yaml � lire
	#* <b>modele :</b> le modele � sauvegarder
	#
	def YamlSlot.ecrireYaml(nomFicSlotYaml, modele)
		
		# Arret du temps pour l'enregistrer
		modele.joueur.dateFinJeu = Time.now
		
		# Calcul du temps total depuis le debut de la session de jeu
		modele.joueur.calculerTempsTotal

      begin
	      file = File.open("YAMLSlot/" + nomFicSlotYaml, "w")

      	file.syswrite(modele.joueur.pseudo.to_yaml())
      	
      	file.syswrite(modele.difficulte.intitule.to_yaml())
      	
	      d = Date.today
	      date = d.mday.to_s + "/" + d.mon.to_s + "/" + d.year.to_s
	      file.syswrite(date.to_yaml())
	      
	      file.syswrite(modele.joueur.tempsTotal.to_yaml())
	      
	      file.syswrite(modele.to_yaml())
	      
	      # Reprise du temps apres avoir sauvegarder
	      modele.joueur.dateDebutJeu = Time.now
	      
	   rescue
			raise "Impossible d'ouvrir le fichier YAMLSlot/" + nomFicSlotYaml
		ensure
			file.close
		end
		
	end

end
