<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="utf-8"/>
  
    <!-- Document permettant de générer automatiquement des manifestes IIIF à partir de headers encodés en XML-TEI  -->
    <!-- A noter cependant que les tailles des images sont récupérées et ajoutées dans une seconde étape (réalisée par une autre partie de l'équipe) -->
    <!-- Conforme à : Presentation API 3.0 (https://iiif.io/api/presentation/3.0/) -->
    <!-- Auteur : Auriane Quoix -->
    
    <!-- Création d'une variable permettant de stocker le chemin jusqu'au dossier devant contenir les manifestes IIIF générés automatiquement -->
    <xsl:variable name="path">
        <xsl:text>../../5_TEItoIIIF/IIIFmanifests</xsl:text>
    </xsl:variable>
    <!-- Création d'une variable permettant de stocker la valeur de l'attribut @xml:id (correspond au nom du fichier XML) afin de créer le dossier contenant le manifeste IIIF -->
    <xsl:variable name="folderName" select="//tei:TEI/@xml:id"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:TEI">
        <!-- Création de variables permettant de stocker les valeurs apparaissent à plusieurs endroits du manifeste -->
        <xsl:variable name="title" select="//tei:titleStmt/tei:title"/>
        <xsl:variable name="source" select="//tei:ref/@facs"/>
        <xsl:variable name="publicationPlace" select="//tei:bibl/tei:pubPlace"/>
        <xsl:variable name="date" select="//tei:bibl/tei:date[1]"/>
        <!-- Variables qui permettent de composer l'URI de la "collection" à laquelle appartient la ressource -->
        <xsl:variable name="creationCollectionName1" select="substring-before(//tei:TEI/@xml:id,'_')"/>
        <xsl:variable name="creationCollectionName2" select="concat(//tei:date[@type = 'first_publication_number'], '-', //tei:date[@type = 'last_publication_number'])"/>
        <xsl:variable name="creationCollectionName3" select="substring-after(substring-after(//tei:TEI/@xml:id,'_'),'_')"/>
      
        <!-- Afin de respecter l'indentation du document en sortie nous avons fait le choix de limiter l'indentation ci-dessous
        (pas de retour à la ligne pour les instructions XSLT ou les commentaires). -->
        <xsl:result-document href="{$path}/{$folderName}/manifest.json">
{
  "@context": "http://iiif.io/api/presentation/3/context.json",
  "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/manifest",<!-- Récupération de l'@xml:id afin de composer l'URI du manifeste -->
  "type": "Manifest",
  "label": { "none": [ "<xsl:value-of select="$title"/> (<xsl:value-of select="$publicationPlace"/>, <xsl:value-of select="$date"/>)" ] },<!-- Label composé du titre, de la ville et de la date de publication de la ressource -->          
  "metadata": [<xsl:if test="//tei:bibl/tei:author/text() != ''"><!-- Ajout d'une condition afin que le label "Author" n'apparaisse que s'il contient une valeur -->
    {
      "label": { "en": [ "Author" ] },
      "value": {<!-- Ajout d'une double boucle afin que si plusieurs auteurs apparaissent dans le document XML-TEI source, ils apparaissent au sein de "value". Ajout également d'une condition permettant de séparer les valeurs par une virgule s'il y en a plusieurs (arborescence et indentation réalisée d'après la documentation IIIF : https://iiif.io/api/presentation/3.0/#b-example-manifest-response) -->
        "none": [<xsl:for-each select="//tei:bibl"><xsl:for-each select="tei:author"><xsl:if test="position() > 1">,</xsl:if>
          "<xsl:value-of select="text()"/>"</xsl:for-each></xsl:for-each>
        ]
      }
    },</xsl:if><xsl:if test="//tei:bibl/tei:editor[@role = 'director']/text() != ''"><!-- Même procédé que celui décrit ci-dessus et qui est répété dans les lignes suivantes pour les labels "Editor", "Publisher", "Physical description", "Notes" -->
    {
      "label": { "en": [ "Director" ] },
      "value": {
        "none": [<xsl:for-each select="//tei:bibl"><xsl:for-each select="tei:editor[@role = 'director']"><xsl:if test="position() > 1">,</xsl:if>
          "<xsl:value-of select="text()"/>"</xsl:for-each></xsl:for-each>
        ]
      }
    },</xsl:if><xsl:if test="//tei:bibl/tei:editor[not(@role)]/text() != ''">
    {
      "label": { "en": [ "Editor" ] },
      "value": {
        "none": [<xsl:for-each select="//tei:bibl"><xsl:for-each select="tei:editor[not(@role)]"><xsl:if test="position() > 1">,</xsl:if>
          "<xsl:value-of select="text()"/>"</xsl:for-each></xsl:for-each>
        ]
      }
    },</xsl:if>
    {
      "label": { "en": [ "Date" ] },
      "value": { "none": [ "<xsl:value-of select="$date"/>" ] }
    },<xsl:if test="//tei:bibl/tei:publisher/text() != ''">
    {
      "label": { "en": [ "Publisher" ] },
      "value": { 
        "none": [<xsl:for-each select="//tei:bibl"><xsl:for-each select="tei:publisher"><xsl:if test="position() > 1">,</xsl:if>
          "<xsl:value-of select="text()"/>"</xsl:for-each></xsl:for-each>
        ]
      }
    },</xsl:if>
    {
      "label": { "en": [ "Publication place" ] },
      "value": { "en": [ "<xsl:value-of select="$publicationPlace"/>" ] }
    },<xsl:if test="//tei:bibl/tei:extent/text() != ''">
    {
      "label": { "en": [ "Physical description" ] },
      "value": { "none": [ "<xsl:value-of select="//tei:extent"/>" ] }
    },</xsl:if><xsl:if test="//tei:bibl/tei:note/text() != ''">
    {
      "label": { "en": [ "Notes" ] },
      "value": {
        "none": [<xsl:for-each select="//tei:bibl"><xsl:for-each select="tei:note"><xsl:if test="position() > 1">,</xsl:if>
          "<xsl:value-of select="text()"/>"</xsl:for-each></xsl:for-each>
        ]
      }
    },</xsl:if>
    {
      "label": { "en": [ "Language" ] },
      "value": {
        "none": [<xsl:for-each select="//tei:language"><xsl:if test="position() > 1">,</xsl:if>
          "<xsl:value-of select="@ident"/>"</xsl:for-each>
        ]
      }
    },
    { <!-- Pas de mise en place de condition d'apparition concernant les labels ci-dessous car il peut être intéressant qu'ils apparaissent, même vides, puisque cela permet tout de même d'indiquer que l'information n'est pas connue. -->
      "label": { "en": [ "Repository" ] },
      "value": { "en": [ "<xsl:value-of select="//tei:repository"/>" ] }
     },
     {
      "label": { "en": [ "Digitised by" ] },
      "value": { "none": [ "<xsl:value-of select="//tei:surrogates/tei:name"/>" ] }
     },
     {
       "label": { "en": [ "Digitisation date" ] },
       "value": { "none": [ "<xsl:value-of select="//tei:surrogates/tei:name/@when"/>" ] }
     },
     {
       "label": { "en": [ "Source" ] },
       "value": { "none": [ "From: <xsl:value-of select="$source"/>" ] }
     },
     {
       "label": { "en": [ "Rights" ] },
       "value": { "none": [ "<xsl:value-of select="//tei:availability/tei:licence[2]/@target"/>" ] }
     }
  ],
  "summary": { "en": [ "<xsl:value-of select="$title"/>, published in <xsl:value-of select="$publicationPlace"/>, <xsl:value-of select="$date"/>." ] },
  "thumbnail": [
    {
      "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page1/full/80,100/0/default.jpg",
      "type": "Image",
      "format": "image/jpeg",
      "service": [
        {
          "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page1",
          "type": "ImageService3",
          "profile": "level1"
        }
      ]
    }
  ],
  "viewingDirection": "right-to-left",
  "behavior": [ "paged" ],
  "requiredStatement": {
    "label": { "en": [ "Attribution" ] },
    "value": { "en": [ "Provided by: <xsl:value-of select="$source"/>" ] }
  },<xsl:if test="//tei:bibl[@type = 'periodical']"><!-- "partOf" indique si le manifeste fait partie d'une collection. Mise en place d'une condition pour que la règle ne s'applique qu'aux périodiques. Le système des collections pourra aussi être mis en place ultérieurement pour certains catalogues publiés régulièrement (comme les biennales, salons etc.) -->
  "partOf": [
    {<!-- ci-dessous création de l'URI renvoyant à la collection -->
    "id": "https://iiif.unige.ch/iiif/2/visualcontagions/collection/<xsl:value-of select="$creationCollectionName1"/>_<xsl:value-of select="$creationCollectionName2"/>_<xsl:value-of select="$creationCollectionName3"/>",
      "type": "Collection"
    }
  ],</xsl:if>       
  "start": {
    "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p2",
    "type": "Canvas"
  },
    "items": [
      {
        "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p1",
        "type": "Canvas",
        "label": { "none": [ "p. 1" ] },
        "height": 0000,<!-- Les informations concernant la taille de l'image sont à ajouter dans une seconde étape. -->
        "width": 0000,
        "items": [
          {
            "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page/p1/1",
            "type": "AnnotationPage",
            "items": [
              {
                "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/annotation/p0001-image",
                "type": "Annotation",
                "motivation": "painting",
                "body": {
                  "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page1/full/max/0/default.jpg",
                  "type": "Image",
                  "format": "image/jpeg",
                  "service": [
                    {
                      "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page1",
                      "type": "ImageService3",
                      "profile": "level2",
                      "service": [
                        {
                          "@id": "https://iiif.unige.ch/iiif/2/visualcontagions/auth/login",
                          "@type": "AuthCookieService1"
                        }
                      ]
                    }
                  ],
                  "height": 0000,<!-- Les informations concernant la taille de l'image sont à ajouter dans une seconde étape. -->
                  "width": 0000
                },
                "target": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p1"
              }
            ]
          }
        ],
        "annotations": [
          {
            "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/p1/1",
            "type": "AnnotationPage"
          }
        ]
      },
      {
        "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p2",
        "type": "Canvas",
        "label": { "none": [ "p. 2" ] },
        "height": 0000,<!-- Les informations concernant la taille de l'image sont à ajouter dans une seconde étape. -->
        "width": 0000,
        "items": [
          {
            "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page/p2/1",
            "type": "AnnotationPage",
            "items": [
              {
                "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/annotation/p0002-image",
                "type": "Annotation",
                "motivation": "painting",
                "body": {
                  "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page2/full/max/0/default.jpg",
                  "type": "Image",
                  "format": "image/jpeg",
                  "service": [
                    {
                      "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page2",
                      "type": "ImageService3",
                      "profile": "level2"
                    }
                  ],
                  "height": 0000,<!-- Les informations concernant la taille de l'image sont à ajouter dans une seconde étape. -->
                  "width": 0000
                },
                "target": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p2"
              }
            ]
          }
        ]
      },
      {
        "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p3",
        "type": "Canvas",
        "label": { "none": [ "p. 3" ] },
        "height": 0000,<!-- Les informations concernant la taille de l'image sont à ajouter dans une seconde étape. -->
        "width": 0000,
        "items": [
          {
            "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page/p3/1",
            "type": "AnnotationPage",
            "items": [
              {
                "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/annotation/p0003-image",
                "type": "Annotation",
                "motivation": "painting",
                "body": {
                  "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page3/full/max/0/default.jpg",
                  "type": "Image",
                  "format": "image/jpeg",
                  "service": [
                    {
                      "id": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/page3",
                      "type": "ImageService3",
                      "profile": "level2"
                    }
                  ],
                  "height": 0000,<!-- Les informations concernant la taille de l'image sont à ajouter dans une seconde étape. -->
                  "width": 0000
                },
                "target": "https://iiif.unige.ch/iiif/2/visualcontagions/<xsl:value-of select="$folderName"/>/canvas/p3"
              }
            ]
          }
        ]
      }
    ]
  }    
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>