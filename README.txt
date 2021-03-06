
FRENCH VERSION BELOW !!

ENGLISH DESCRIPTION

Welcome to Advanced Statistics !

A modulable mod allowing you to track your stats all along your run (and compare it to your other runs !)

This mod is a little HUD that shows where the timer is, and uses a gradient of color to easily show your performance (red = bad, green = good)

To enable / disable the HUD, press [TAB]/[MENU]/[SELECT] for 1.5 seconds

For now these stats are tracked : 
  - Accuracy : (Hits / Tears shot) %
  - Level completion : (Rooms entered / Total rooms) %
  - KillStreak : Number of ennemies killed without being hit (Color depends on your average of your Maximum KillStreak)
  - RoomStreak : Number of rooms entered without being hit (Color depends on your average of  your Maximum RoomStreak) 
  - TimeStreak : Time spend without being hit (Color depends on your average of  your Maximum TimeStreak)
  - Hits taken : Number of hits taken (Color depends on your average of  Hits taken per level)	
  - Ennemy killed : Number of ennemy killed (Color depends on your average of  Ennemy killed per level)

Tell me if you have any idea of additional stats, I can add them in future updates

You can choose to enable extra information globally. For each stat, You can choose individually to disable the extra information (basically the global stats)

There are multiple languages curently available :
  - English
  - English Detailed
  - French

If you want to help me translating to an other language (or correct my poor english), contact me.


HOW CAN I CHANGE THE SHOWN STATS ?

The mod is totally modulable and is fully compatible with Mod Config Menu : https://steamcommunity.com/sharedfiles/filedetails/?id=1603631350
It's a simple menu that can help you with personalize the interface.

Otherwise, you can edit the configuration file (as_config.lua in the mod folder) to change the shown stats.
To avoid overflowing your screen, by default only two stats are printed on the base HUD and one when the timer is visible (and additional informations are hidden by default).
The stats by default are :
  - Accuracy, Hits taken (in the base HUD)
  - Level completion (when the timer is visible)


VERY IMPORTANT STUFF 

- When printing the map, the mod interface may override the in-game timer (or being shown not on top of the screen) due to internal modding issues.
If it occurs, hit [TAB]/[MENU]/[SELECT] for 10 seconds to solve the issue

- Accuracy only works on tears. For multi-hit tears (like piercing and ludivico), every hit will be taken in account. Familiar tears also count.

- This mod is not intended to be used in multiplayer, so you should disable it before. Otherwise, some stats may be broken

- The stats are common for all characters, so the max streaks may be broken by invulnerability items such as the mantle of the lost


TECHNICAL STUFF


-- Average computation

Each run doesn't have the same weight. For example, finishing a run on the 4th floor will give your run a weight of 3 + X, where X is your level completion ratio.
This computation was chosen because dying during the 1st floor should not be as important as a full run.
And so, for the stats that are compared to the average, this average has been computed using mostly your best runs.


CREDITS

A lot of my code (such as the way of setting config and language) is inspired from External Items Descriptions by WofSauge, so if you need an example for modding,
I strongly advise you to look at this one (really good one mod, go spend your steams points there ;p):
https://steamcommunity.com/sharedfiles/filedetails/?id=836319872&searchtext=external+items

Go look at the Modding of Isaac discord server, there is a lot of helpful stuff to learn making mods : https://discord.gg/JMaktQd




















DESCRIPTION EN FRANCAIS

Bienvenue dans le mod "Advanced Statistics" !

C'est un mod modulable, qui vous permet d'analyser les statistiques de votre run en cours (et m??me de les comparer avec vos runs pr??c??dentes)

Ce mod ajoute un petit HUD qui s'affiche ?? l'endroit o?? est sens?? ??tre le timer.
Il utilise un d??grad?? de couleur intuitif qui permet de comprendre facilement si vous ??tes dans une bonne run (rouge = nul, vert = cool)

Pour activer ou d??sactiver le HUD, appuyez sur [TAB]/[MENU]/[SELECT] pendant 1.5 secondes

Pour l'instant, les statistiques analys??es sont :
  - Pr??cision : (Nombre de larmes touch??es / Larmes tir??es)% 
  - Exploration du niveau : (Salles parcourues / Nombre total de salles) %
  - Eliminations indemne : Nombre d'ennemis tu??s sans se faire toucher (et la couleur d??pend de la moyenne des maximums d'Eliminations indemnes par run)
  - Salles indemne : Nombre de salles parcourues dans se faire toucher ( // )
  - Temps pass?? indemne : Temps pass?? sans se faire toucher ( // )
  - Coup re??us : Nombre de coups re??us (et la couleur d??pend de la moyenne des Nombre de coups re??us par niveau de toutes vos runs)
  - Ennemis tu??s : Nombre d'ennemis tu??s ( // )

Si vous avez des id??es d'autres statistiques, n'h??sitez pas ?? me les envoyer, je pourrai les rajouter dans de prochaines mises ?? jour

Vous pouvez aussi activer l'affichage d'informations suppl??mentaires de facon globlale.
Une fois cela fait, vous pouvez choisir de les enlever individuellement. Les informations suppl??mentaires sont g??n??ralement les statistiques toutes runs confondues.

Vous pouvez aussi changer de langue entre :
  - Anglais 
  - Anglais D??taill?? 
  - Francais

Si vous voulez m'aider ?? traduire ce mod dans d'autres langues (ou corriger des fautes), vous pouvez me contacter


COMMENT JE PEUX CHOISIR LES STATISTIQUES AFFICH??ES ?

Ce mod est totalement modulable, et est enti??rement compatible avec Mod Config Menu : https://steamcommunity.com/sharedfiles/filedetails/?id=1603631350
C'est un menu qui permet de personnaliser l'interface assez simplement.

Vous pouvez aussi ??diter directement le fichier de configuration (qui s'appelle as_config.lua dans le dossier du mod) pour personnaliser l'interface.


Pour ??viter de masquer tout votre ??cran, seules deux statistiques sont affich??es par d??faut sur le HUD initial et une seule quand le timer est affich??.
De plus, l'affichage des informations suppl??mentaires est d??sactiv?? par d??faut.

Les statistiques affich??es par d??faut sont :
  - Pr??cision, Coups re??us (dans le HUD initial)
  - Exploration du niveau (quand le timer est affich??)



INFORMATIONS IMPORTANTES

- Pour des raisons ind??pendantes de ma volont??, le texte du mod peut s'afficher sur le timer (ou ??tre d??cal?? alors que le timer n'est pas affich??).
Si jamais cela arrive appuyez sur [TAB]/[MENU]/[SELECT] pendant 10 secondes et cela intervertira les affichages.

- La pr??cision ne fonctionne que sur les larmes. Pour les attaques qui touchent plusieurs fois (comme avec ludovico ou les larmes percantes), chaque coup comptera.
Les larmes tir??es par les familiers sont aussi prises en compte dans la pr??cision.

- Ce mod n'a pas ??t?? pens?? pour ??tre utilis?? en multijoueurs, pensez donc ?? le d??sactiver avant (sinon certaines stats n'auront aucun sens)

- Pour l'instant, les stats sont communes pour tous les personnages, donc les stats de combo indemnes seront s??rement fauss??es par les items d'invuln??rabilit?? comme la mantle de the lost


INFORMATIONS TECHNIQUES

- Calcul de la moyenne

Toutes les runs n'ont pas le m??me impact dans le calcul de la moyenne. Par exemple, finir une run au 4??me ??tage donnera un poids de 3 + X ?? votre run, o?? X est votre ratio d'exploration de niveau
Le but de ce calcul est d'avoir des stats globales qui aient un sens, parce que mourir au premier ??tage ne devrait pas compter autant qu'une run compl??te
De plus cela permettra de vous comparer aux run o?? vous ??tes all??s loin, c'est ?? dire g??n??ralement celles o?? vous avez ??t?? meilleur ;)


CREDITS

Pour certaines des fonctionnalit??s de mon mod (comme la mani??re de faire un fichier de configuration ou de g??rer les langues) je me suis fortement inspir?? du mod External Items Descriptions de WofSauge,
donc si vous voulez une inspiration pour modder, je vous conseille plut??t de regarder celui ci (tr??s bon mod, allez d??penser vos points steam dedans ;p):
https://steamcommunity.com/sharedfiles/filedetails/?id=836319872&searchtext=external+items

Vous pouvez aussi rejoindre le serveur discord "Modding of Isaac", o?? vous trouverez beaucoup de ressources (et de personnes) pour apprendre ?? modder : 
https://discord.gg/JMaktQd











