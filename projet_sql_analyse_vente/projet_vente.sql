
-- PROJET DATA ANALYST : ANALYSE DES VENTES

USE projet_ventes;

-- 1. Chiffre d'affaires total
SELECT SUM(c.quantite * p.prix_unitaire) AS chiffre_affaires_total
FROM commande c
JOIN produit p ON c.id_produit = p.id_produit;

-- 2. Chiffre d'affaires par client
SELECT cl.nom,
       SUM(c.quantite * p.prix_unitaire) AS chiffre_affaires
FROM client cl
JOIN commande c ON cl.id_client = c.id_client
JOIN produit p ON c.id_produit = p.id_produit
GROUP BY cl.id_client, cl.nom
ORDER BY chiffre_affaires DESC;

-- 3. Chiffre d'affaires par ville
SELECT cl.ville,
       SUM(c.quantite * p.prix_unitaire) AS chiffre_affaires
FROM client cl
JOIN commande c ON cl.id_client = c.id_client
JOIN produit p ON c.id_produit = p.id_produit
GROUP BY cl.ville
ORDER BY chiffre_affaires DESC;

-- 4. Quantités vendues par produit
SELECT p.produit,
       SUM(c.quantite) AS quantite_totale
FROM produit p
JOIN commande c ON p.id_produit = c.id_produit
GROUP BY p.id_produit, p.produit
ORDER BY quantite_totale DESC;

-- 5. Nombre de commandes par client
SELECT cl.nom,
       COUNT(c.id_commande) AS nombre_commandes
FROM client cl
JOIN commande c ON cl.id_client = c.id_client
GROUP BY cl.id_client, cl.nom
ORDER BY nombre_commandes DESC;

-- 6. Clients dont le chiffre d'affaires dépasse 500 €
SELECT cl.nom,
       SUM(c.quantite * p.prix_unitaire) AS chiffre_affaires
FROM client cl
JOIN commande c ON cl.id_client = c.id_client
JOIN produit p ON c.id_produit = p.id_produit
GROUP BY cl.id_client, cl.nom
HAVING SUM(c.quantite * p.prix_unitaire) > 500
ORDER BY chiffre_affaires DESC;

SELECT
    client.nom,
    produit.produit,
    SUM(commande.quantite) AS quantite_achetee,
    SUM(commande.quantite * produit.prix_unitaire) AS montant_total
FROM client
JOIN commande
    ON client.id_client = commande.id_client
JOIN produit
    ON commande.id_produit = produit.id_produit
GROUP BY
    client.id_client,
    client.nom,
    produit.id_produit,
    produit.produit
ORDER BY
    client.nom,
    montant_total DESC;
