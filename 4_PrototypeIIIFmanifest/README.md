## Prototype IIIF manifest

### Presentation

This folder presents the step of development of a IIIF manifest template. The manifests are in accordance with to [Presentation API 3.0](https://iiif.io/api/presentation/3.0/).

**1.** "**1-1_PrototypeManifest-v3presentation.json**" shows a model of IIIF manifest with comments intended to explain the different sections of the manifest.
The "metadata" property chiefly contains the information coming from the TEI headers. 

**2.** "**1-2_PrototypeCollection-v3presentation.json**" is a template of a Collection document.
The collection brings together a list of manifests. For example, it can list the manifests of a book published in several volumes.
As part of the project, it is planned to use the collection to bring together manifests corresponding to the different issues of a same periodical. The collection system can also be considered to bring together the manifests of catalogs that are regularly published (such as biennials or salons).

**3.** "**2-1_ExhibCatExampleManifest-v3presentation_simpleVersion.json**" is an example of a IIIF manifest (XML document named "exhibCat_1924_NewYork_JapaneseLandscapeFromHokusaiToKyosai"). It is a simple version of the manifest (without optional properties).

Note that only three canvases have been listed in the items property, but the manifest should normally contain as many canvases as there are images composing the resource.
Moreover, the normal file naming should be "manifest.json" but since I present several versions of this example, I chose to name it differently.

**4.** "**2-2_ExhibCatExampleManifest-v3presentation_withOptions.json**" corresponds to the same manifest but with the optional properties.
Depending on the progress and the needs of the project, the team may possibly implement other options within the manifests.

The XSLT script made in "**5_TEItoIIIF**" folder generates the simple version of the manifests.

**5.** "**2-2_ExhibCatExampleManifest-v3presentation_withOptions.json**" is an example of Collection document which lists three manifests of three issues of the periodical "L’Architecture vivante".

The three other documents are the manifests corresponding to the three issues of the review.

**6.** The "**RepositoryExample**" folder is an example of repository containing the same manifests as described above. The purpose is to provide an example of file organization.
This repository is based on this [one](https://github.com/biblissima/iiif-manifests-demo), published by the Biblissima project.