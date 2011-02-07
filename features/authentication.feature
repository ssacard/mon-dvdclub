# language: fr
Fonctionnalité: Authentification
	Afin de maintenir ses propres listes de dvds et de contacts
	Un visiteur
	Veut un compte


	Scénario: S'inscrire directement depuis le site
		Soit je suis sur la page d'accueil
		Lorsque je suis le lien "Ouvrir un club"
		Et que je remplis "Email" avec "test@example.com"
		Et que je remplis "Mot de passe" avec "testpass"
		Et que je remplis "Nom du club:" avec "test club"
		Et que je coche "j'accepte les conditions d'utilisations"
		Et que j'appuie sur "Créer"
		Alors je dois être sur la page d'accueil de mon club
		Et je dois voir "Voici votre DVDCLub. Commencez par ajouter des DVD !"
		Et je dois voir "Pas de DVD actuellement dans vos club"
		Et je dois recevoir un mail de confirmation de mon inscription


	Scénario: S'inscrire avec Facebook
		Soit je suis sur la page d'accueil
		Lorsque je suis le lien "Ouvrir un club"
		Et que je suis le lien "M'inscrire avec Facebook"
		Et que je remplis "Nom du club" avec "test club"
		Et que je coche "j'accepte les conditions d'utilisations"
		Et que j'appuie sur "M'inscrire"
		Et que je confirme l'autorisation sur facebook
		Alors je dois être sur la page d'accueil de mon club
		Et je dois voir "Voici votre DVDCLub. Commencez par ajouter des DVD !"
		Et je dois voir "Pas de DVD actuellement dans vos club"
		Et je dois recevoir un mail de confirmation de mon inscription


	Scénario: S'inscrire avec une invitation
		Soit j'ai reçu un mail d'invitation
		Lorsque je suis le lien qu'il contient
		Et que je remplis "Mot de passe" avec "testpass"
		Et que je remplis "Votre pseudo dans ce club" avec "test nick 2"
		Et que je coche "j'accepte les conditions d'utilisations"
		Et que j'appuie sur "Créer"
		Alors je dois être sur la page d'accueil de mon club
		Et je dois voir "Voici votre DVDCLub. Commencez par ajouter des DVD !"
		Et je dois recevoir un mail de confirmation de mon inscription


	Scénario: S'inscrire avec une invitation et Facebook
		Soit j'ai reçu un mail d'invitation
		Lorsque je suis le lien qu'il contient
		Et que je suis le lien "M'inscrire avec Facebook"
		Et que je coche "j'accepte les conditions d'utilisations"
		Et que j'appuie sur "M'inscrire"
		Et que je confirme l'autorisation sur facebook
		Alors je dois être sur la page d'accueil de mon club
		Et je dois voir "Voici votre DVDCLub. Commencez par ajouter des DVD !"
		Et je dois voir "Pas de DVD actuellement dans vos club"
		Et je dois recevoir un mail de confirmation de mon inscription


	Scénario: Se connecter
		Soit les utilisateurs suivant :
		|login|email|password|state|
		|test|test@example.com|test_password|active|
		Et je suis sur la page d'accueil
		Lorsque je suis le lien "Se connecter"
		Et que je remplis "Email" avec "test@example.com"
		Et que je remplis "Mot de passe" avec "test_password"
		Et que j'appuie sur "Se connecter"
		Alors je dois voir "Mon compte"
		Et je dois voir "Se déconnecter"
		Et je dois être sur la page d'accueil de mon club


	Scénario: Se connecter avec facebook
		Soit les utilisateurs suivant :
		|login|email|password|state|
		|test|test@example.com|test_password|active|
		Et je suis sur la page d'accueil
		Lorsque je suis le lien "Se connecter"
		Et que je suis le lien "Connexion avec Facebook"
		Alors je dois voir "Mon compte"
		Et je dois voir "Se déconnecter"
		Et je dois être sur la page d'accueil de mon club


	Scénario: Se déconnecter
		Soit les utilisateurs suivant :
		|login|email|password|state|
		|test|test@example.com|test_password|active|
		Et je suis connecté en tant que "test"
		Lorsque je suis le lien "Se déconnecter"
		Alors je dois être sur la page d'accueil de mon club
		Et je dois voir "Créer un club"
		Et je dois voir "Se connecter"


	Scénario: Envoyer une invitation
		Soit les utilisateurs suivant :
		|login|email|password|state|
		|test|test@example.com|test_password|active|
		Et je suis connecté en tant que "test"
		Et je suis sur la page d'accueil de mon club
		Lorsque je suis le lien "J'invite des amis"
		Et que je remplis "A" avec "test2@example.com"
		Et que je remplis "Message" avec "Message test"
		Et que j'appuie sur "Inviter"
		Alors un mail doit être envoyé à "test2@example.com" avec un lien d'inscription par invitation
