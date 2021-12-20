# Retinex-Pencil

Implementation of "Robust Pencil Drawing Generation via Fast Retinex Decomposition".

CAD/Graphics 2021

Visit our  :page_facing_up: [project page](https://hfut-nuietp.github.io/retinexpencil/) .

![](https://www.terrytengli.com/src/pics/2021-12-20_22-36-45_retinex_model.png)

## Environment

1. System: Windows 10
2. MATLAB 2020a

## File Structure

```
.
├── demo, demo code(encrypted)
└── source, source code
```

## Usage

This repo contains too many large files on legacy branchs, please download the master branch only for flexible usage.

```bash
wget https://github.com/HFUT-NUIETP/retinexpencil/archive/refs/heads/master.zip
```
## Acceleration Comparisons

The proposed method is faster then the previous methods with a huge gap. 

![](https://www.terrytengli.com/src/pics/2021-12-20_22-31-11_68747470733a2f2f64726976652e676f6f676c652e636f6d2f75633f6578706f72743d766965772669643d3146644f737076715361526a6f3741734d506c6548664861303230744f77737876.png)

## Visual Quality Comparisons

![](https://www.terrytengli.com/src/pics/2021-12-20_22-33-42_first_fig.png)

## Cite Us

If the code is useful for your further work, please cite us with the bellow bib and give a star for this repo. Thanks so much.

```
@article{LI202167,
title = {Robust pencil drawing generation via fast Retinex decomposition},
journal = {Computers & Graphics},
volume = {97},
pages = {67-77},
year = {2021},
issn = {0097-8493},
doi = {https://doi.org/10.1016/j.cag.2021.04.008},
url = {https://www.sciencedirect.com/science/article/pii/S0097849321000509},
author = {Teng Li and Shijie Hao and Yanrong Guo},
}
```

## Reference

> - [CVPR19](): Y. Li, C. Fang, A. Hertzmann, E. Shechtman and M. Yang, "Im2Pencil: Controllable Pencil Illustration From Photographs", 2019 IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR), 2019, pp. 1525-1534.
> - [NPAR12](): C. Lu, L. Xu and J. Jia, "Combining sketch and tone for pencil drawing production", Proceedings of the symposium on non-photorealistic animation and rendering, 2012, pp. 65-73.
