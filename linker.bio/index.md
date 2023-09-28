---
title: linker.bio
subtitle: Unleashing Digital Knowledge
authors: made possible by thriving Open Science and Open Source communities
date: 2023-09-28
---

[edit this page](https://github.com/bio-guoda/preston-service/linker.bio/edit/main/linker.bio/index.md) / [share suggestions](https://github.com/bio-guoda/preston/issues/new)

# Welcome to linker.bio.

The internet is a powerful tool to exchange digital information. And, content available through the internet changes constantly: websites come and go, and webpages change.  

https://linker.bio builds a bridge from the exciting, dynamic internet to their reliable, yet a bit boring, cousin: the **content-verse**. In this content-verse, **digital fingerprints are used as links** instead of resource locators (or URLs). Contrary to URLs, these digital fingerprints **do *not* break, nor expire** ^[Digital finger prints are cryptographic objects mathematically linked to the content they reference. They can be generated with most digital devices. And, by embedding fingerprints into other digital content, you can pretty much reference anything and everything digital using a digital fingerprint that fits on a t-shirt.].

Where the internet excels in spreading new information, the content-verse excels at referencing *known* information. 

On the internet, you'd say:

> "I'd like to get the latest content from this web location."

, and *trust* that the retrieved content is what you asked for.

In the content-verse, you'd say: 

> "I'd like to get the content associated with this fingerprint."

, and *verify* that the retrieved content is *exactly* what you asked for.

Through digital fingerprints, content that is hosted by Zenodo, DataOne, Software Heritage Library, or WikiMedia Commons today, may be found in their new location(s) 50 years from now using that same exact fingerprint.

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

or, perhaps even better, you can also ask for a **picture** of a Oryctolagus cuniculus, of a 🐇 by JM Ligero Loarte -

[https://linker.bio/hash://sha1/86fa30f32d9c557ea5d2a768e9c3595d3abb17a2.jpg](https://linker.bio/hash://sha1/86fa30f32d9c557ea5d2a768e9c3595d3abb17a2).

or, if you are ambitious, you can retrieve a digital corpus of billions of biodiversity records ^[To compile this corpus from their referenced parts, you may benefit from using a tool like [Preston](https://github.com/bio-guoda/preston).] collected in period 2018/2023 via:

[https://linker.bio/hash://sha256/a755a6ac881e977bc32f11536672bfb347cf1b7657446a8a699abb639de59419](https://linker.bio/hash://sha256/a755a6ac881e977bc32f11536672bfb347cf1b7657446a8a699abb639de59419). 

For more information and background, see: 

Elliott, M.J., Poelen, J.H. & Fortes, J.A.B. Signing data citations enables data verification and citation persistence. <em>Sci Data</em> 10, 419 (2023). [https://doi.org/10.1038/s41597-023-02230-y](https://doi.org/10.1038/s41597-023-02230-y) [hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d](https://linker.bio/hash://sha256/f849c870565f608899f183ca261365dce9c9f1c5441b1c779e0db49df9c2a19d.pdf)
