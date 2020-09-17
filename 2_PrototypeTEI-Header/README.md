## Prototype TEI header

### Presentation

This folder concerns the intermediate stages of my work. In order to meet the needs of the project, we have chosen to use XML-TEI as a pivot format.
The objective was therefore to automatically encode the metadata collected in the CSV in TEI headers. Thus data production can be centralized in this format.

The headers can be retrieved to complete the work of another member of the team, Caroline Corbières, who has carried out a workflow to automatically encode exhibition catalogs with GROBID-Dictionaries. You can consult all her work [here](https://github.com/carolinecorbieres/ArtlasCatalogues).

For my part, from these TEI files which could have been completed, I had to think of a way to automatically generate IIIF manifests.
Indeed, the TEI also offers advantages that we do not have when using a simple CSV table. In this way, the tags containing the information are repeatable in TEI. For example, you can add as many names of authors, editors or notes as necessary, when in a table, you are limited by rows and columns (only one row per resource and so a cell must only contain one item).


### Folder 1: 1_DataMapping

In this folder, you can find the data mapping describing the matching fields between the CSV column names and the chosen TEI tags. The tree structure corresponding to each TEI tag is also described. This document is available in three formats: .docx, .odt and .pdf.


### Folder 2: 2_TEI-Header_Template

The present folder is composed of a TEI header template and of examples of exhibition catalogs and manually encoded periodicals headers, in order to test the model and to verify its validity.

The header template has been designed to be used to encode both exhibition catalogs and periodicals. Furthermore, as well as the CSV, it had to contain the necessary metadata for BasArt and the IIIF manifests.


### Folder 3: 3_ODD

Here, there is the ODD ("One Document Does it all") of the project.

The ODD provides a framework for encoding and offers the possibility to control the code and to validate it. It is an essential document which aims, among other things, to maintain the code and its documentation. So it ensures the sustainability of data. 

This ODD was created in collaboration with Caroline Corbières. It gathers her work concerning the text body of exhibition catalogs (encoded with GROBID-Dictionaries) and my work relating to the headers of these exhibition catalogs (and also to the headers of periodicals as for me) together.
The ODD had therefore to adapt itself both to the needs and constraints of GROBID, as well as those relating to the headers (themselves being adapted to the needs of BasArt and IIIF, as it has already been mentioned). For example, we restricted, among other things, some of attribute values, and in some cases the accepted values come from BasArt (@type attribute of the <orgName> element or @type attribute of the <head> element which specifies the type of exhibition).

In addition to the ODD in .xml format, the documentation generated in .html format and the RELAX NG file allowing to associate the ODD with the XML-TEI file, you can find the "Examples" folder containing two examples of fully encoded catalogs (header and text body), that have been validated by the ODD.
