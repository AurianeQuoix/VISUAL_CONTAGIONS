# VISUAL CONTAGIONS


## Introduction

This repository presents the different stages of my three months and a half internship with the IMAGO Jean Monnet Excellence Center (Paris, Ecole normale supérieure, ENS). You will also find the technical deliverables produced then. During this internship I worked on the VISUAL CONTAGIONS project. The goal was to help the team to implement the IIIF standards in the project.

### Presentation of the project

The aim of the VISUAL CONTAGIONS project is to study the global circulation of images from the 1890s to the advent of the Internet. It involves an innovative research on a corpus of images that need to be recovered, described, dated and georeferenced. Then, they will be analysed with the help of artificial vision algorithms, in order to identify the reproduced images and the patterns that circulated the more between 1890 and 1990.

To visualize the circulation of images, VISUAL CONTAGIONS deploys a global IIIF database of images. This portal will group scanned images (which will be stored on UNIGE servers) and external images (accessible through their IIIF manifests).


### Composition of the repository

During my internship, I had to think about a process to generate IIIF manifests from CSV files listing exhibition catalogs and periodicals available online.
Each folder corresponds to the different stages of my internship.
In each of these, you will find a README.md file describing each step as well as the contents of the folders and subfolders (except for the **3_CSVtoTEI** and **5_TEItoIIIF** folders).

These over here contain data transformation steps (CSV to TEI, and then TEI to IIIF). The README.md files constitute a tutorial to start the transformations.
Below, there is a description of the contents of these folders.

**1. 3_CSVtoTEI** 

The folder contains: 
- the sample of CSV files (the same as those in this folder: VISUAL_CONTAGIONS/1_PrototypeCSV/2_FinalPrototype) imported as XML documents
- there are also two XSLT scripts (one for the resources without manifests and the other for the resources with manifests) which are used to automatically generate XML-TEI headers
- the two subfolders contain the results, that is to say, the automatically generated files.

**2. 5_TEItoIIIF**

In this folder, you can find:
- the XSLT script used to automatically generate IIIF manifests
- one subfolder which contains the results, that is to say, the manifests.


### Requirements

To complete the two steps described above, you will need to download this repository. To do this, use this command in your terminal:
```
git clone https://github.com/AurianeQuoix/VISUAL_CONTAGIONS.git
```

You can also click on `Code` > `Download ZIP`.


### Acknowledgements

I would like to acknowledge and thank all those who have collaborated and helped me in my work: Béatrice Joyeux-Prunel, Simon Gabay, Caroline Corbières, Barbara Topalov.

I would also thank Mathieu Vonlanthen and Régis Robineau for all their valuable advice.

## Credits

This repository has been created by Auriane Quoix under the direction of Béatrice Joyeux-Prunel and Simon Gabay, for the [VISUAL CONTAGIONS project](https://www.imago.ens.fr/).

## Licence

This repository is CC-BY.
<br/>
<a rel="license" href="https://creativecommons.org/licenses/by/2.0"><img alt="Creative Commons License" src="https://i.creativecommons.org/l/by/2.0/88x31.png" /></a>

## Cite this repository

Auriane Quoix, Béatrice Joyeux-Prunel and Simon Gabay, _Process to generate IIIF manifests_, 2020, https://github.com/AurianeQuoix/VISUAL_CONTAGIONS.git.
