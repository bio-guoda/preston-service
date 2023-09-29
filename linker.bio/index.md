---
title: linker.bio
subtitle: Unleashing Digital Knowledge
authors: made possible by thriving Open Science and Open Source communities
date: 2023-09-28
---

[edit this page](https://github.com/bio-guoda/preston-service/linker.bio/edit/main/linker.bio/index.md) / [share suggestions](https://github.com/bio-guoda/preston/issues/new)

# Welcome to linker.bio

The internet is a powerful tool to exchange digital information. And, content available through the internet changes constantly: websites come and go, and webpages change.  

https://linker.bio builds a bridge ^[linker.bio is not the only bridge to the content-verse. In fact, linker.bio re-uses existing bridges provided by [Zenodo](https://github.com/bio-guoda/preston/issues/149), [DataOne](https://github.com/bio-guoda/preston/issues/181), [WikiMedia Commons](https://github.com/bio-guoda/preston/issues/239), and [Software Heritage Library](https://github.com/bio-guoda/preston/issues/70) to the massive amount of content they keep. Note also that [Carl Boettiger](https://www.carlboettiger.info/) maintains a bridge from R to the content-verse via the R package [contentid](https://github.com/cboettig/contentid).].  from the exciting, dynamic internet to their reliable, yet a bit boring, cousin: the **content-verse**. In this content-verse, **digital fingerprints are used as links** instead of resource locators (or URLs). Contrary to URLs, these digital fingerprints **do *not* break, nor expire** ^[Digital finger prints are cryptographic objects that are mathematically linked to the content they reference. They can be generated with most digital devices. And, by embedding fingerprints into other digital content, you can pretty much reference anything and everything digital using a digital fingerprint that fits on a T-shirt.].

Where the internet excels in spreading new information, the content-verse excels at referencing *known* information. 

On the internet, you'd say:

> "I'd like to get the latest content from this web location."

, and *trust* that the retrieved content is what you asked for.

In the content-verse, you'd say: 

> "I'd like to get the content associated with this fingerprint."

, and *verify* that the retrieved content is *exactly* what you asked for.

Today, through digital fingerprints, linker.bio provides a bridge to access billions of openly available biodiversity data records ^[Biodiversity records include snapshot version of digital collections registered with [iDigBio](https://idigbio.org), [GBIF](https://gbif.org), [BioCase](https://biocase.org), [Biodiversity Heritage Library](https://biodiversitylibrary.org), [OBIS](https://obis.org) and [CheckListbank](https://checklistbank.org)], millions of Open Science publications through [Zenodo](https://zenodo.org), over 800k datasets via [DataOne](https://dataone.org), billions of open source files [Software Heritage Library](https://softwareheritage.org), and over 97M freely usable media file from [WikiMedia Commons](https://commons.wikimedia.org/). 

And, 50 years from now, you may use that same fingerprint to find that content, regardless where it may be located, or how the content may be stored, or transmitted ^[In other words, digital fingerprints are agnostic of location, technology, and ... time.].

## How to Request Content

https://linker.bio/ helps to request content, wherever they may be, using a notation like:

```
https://linker.bio/[fingerprint][.extension]
```

The extension is optional. 

## Examples

For instance, to get a copy of a **scientific paper**, you can ask for:

[https://linker.bio/hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d.pdf](https://linker.bio/hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d).

or, to get a copy of a **scientific dataset**, like a historical CO2 Record from the Vostok Ice Core, you can ask for:

[https://linker.bio/hash://md5/e27c99a7f701dab97b7d09c467acf468](https://linker.bio/hash://md5/e27c99a7f701dab97b7d09c467acf468)

or, perhaps even better, you can also ask for a **picture of a 🐇** (*Oryctolagus cuniculus*) by JM Ligero Loarte -

[https://linker.bio/hash://sha1/86fa30f32d9c557ea5d2a768e9c3595d3abb17a2.jpg](https://linker.bio/hash://sha1/86fa30f32d9c557ea5d2a768e9c3595d3abb17a2).

or, to review an initial draft of **the Hash URI Specification by Ben Trask** - 

[https://linker.bio/hash://sha256/3fee21854fb6d81573b166c833db2771b21f0c77daa3095aab542764d89c94c1](https://linker.bio/hash://sha256/3fee21854fb6d81573b166c833db2771b21f0c77daa3095aab542764d89c94c1)

or, if you are ambitious, you can retrieve a digital corpus containing billions of biodiversity records ^[To compile this corpus from their referenced parts, you may benefit from using a tool like [Preston](https://github.com/bio-guoda/preston).] via:

[https://linker.bio/hash://sha256/a755a6ac881e977bc32f11536672bfb347cf1b7657446a8a699abb639de59419](https://linker.bio/hash://sha256/a755a6ac881e977bc32f11536672bfb347cf1b7657446a8a699abb639de59419). 

For more information and background, see: 

Elliott, M.J., Poelen, J.H. & Fortes, J.A.B. Signing data citations enables data verification and citation persistence. <em>Sci Data</em> 10, 419 (2023). [https://doi.org/10.1038/s41597-023-02230-y](https://doi.org/10.1038/s41597-023-02230-y) [hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d](https://linker.bio/hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d.pdf)
