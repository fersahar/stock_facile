 -- Q1.5.1:tous les produits 
 SELECT * FROM produits;
1	Huile d'olive 1 L	18.5	24	1	2026-10-01T09:00:00	1
2	Couscous moyen 1 kg	2.3	40	1	2026-10-01T09:05:00	1
3	Eau minérale 1,5 L	0.85	120	1	2026-10-02T10:00:00	2
4	Jus d'orange 1 L	3.2	0	0	2026-10-02T10:10:00	2
5	Savon de Marseille	2.9	15	1	2026-10-03T11:00:00	3
6	Cahier 96 pages	1.6	60	1	2026-10-04T08:30:00	4

-- Q1.5.2 : Produits en rupture de stock
SELECT *
FROM produits
WHERE quantite = 0;
4	Jus d'orange' 1 L	3.2	0	0	2026-10-02T10:10:00	2

-- Q1.5.3 : Produits triés du plus cher au moins cher
SELECT *
FROM produits
ORDER BY prix DESC;
id	nom	prix	quantite	disponible	date_ajout	categorie_id
1	Huile d'olive 1 L	18.5	24	1	2026-10-01T09:00:00	1
4	Jus d'orange 1 L	3.2	0	0	2026-10-02T10:10:00	2
5	Savon de Marseille	2.9	15	1	2026-10-03T11:00:00	3
2	Couscous moyen 1 kg	2.3	40	1	2026-10-01T09:05:00	1
6	Cahier 96 pages	1.6	60	1	2026-10-04T08:30:00	4
3	Eau minérale 1,5 L	0.85	120	1	2026-10-02T10:00:00	2

-- Q1.5.4 : Nom de chaque produit et de sa catégorie (INNER JOIN)
SELECT produits.nom AS nom_produit,
       categories.nom AS nom_categorie
FROM produits
INNER JOIN categories
    ON produits.categorie_id = categories.id;
nom_produit	nom_categorie
Huile d'olive 1 L	Alimentation
Couscous moyen 1 kg	Alimentation
Eau minérale 1,5 L	Boissons
Jus d'orange 1 L	Boissons
Savon de Marseille	Hygiène
Cahier 96 pages	Papeterie

-- Q1.5.5 : Nombre de produits par catégorie
SELECT categories.nom AS categorie,
       COUNT(produits.id) AS nombre_produits
FROM categories
LEFT JOIN produits
    ON categories.id = produits.categorie_id
GROUP BY categories.id, categories.nom;

categorie	nombre_produits
Alimentation	2
Boissons	2
Hygiène	1
Papeterie	1

-- Q1.5.6 : Valeur totale du stock
SELECT SUM(prix * quantite) AS valeur_totale_stock
FROM produits;
valeur_totale_stock
777.5
-- a) prix négatif
INSERT INTO produits (nom, prix, quantite, date_ajout, categorie_id)
VALUES ('Test prix', -5, 1, '2026-10-05T08:00:00', 1);

L'exécution s'est terminée avec des erreurs.
Résultat : CHECK constraint failed: prix >= 0
À la ligne 58 :
INSERT INTO produits (nom, prix, quantite, date_ajout, categorie_id)
VALUES ('Test prix', -5, 1, '2026-10-05T08:00:00', 1);

-- b) catégorie qui n'existe pas
INSERT INTO produits (nom, prix, quantite, date_ajout, categorie_id)
VALUES ('Test catégorie', 1, 1, '2026-10-05T08:00:00', 99);

L'exécution s'est terminée avec des erreurs.
Résultat : FOREIGN KEY constraint failed
À la ligne 61 :
INSERT INTO produits (nom, prix, quantite, date_ajout, categorie_id)
VALUES ('Test catégorie', 1, 1, '2026-10-05T08:00:00', 99);

-- c) supprimer une catégorie qui contient des produits
DELETE FROM categories WHERE id = 1;

'exécution s'est terminée avec des erreurs.
Résultat : FOREIGN KEY constraint failed
À la ligne 64 :
DELETE FROM categories WHERE id = 1;