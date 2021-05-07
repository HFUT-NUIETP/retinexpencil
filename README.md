# Retinex-Pencil
Implementation of "Robust Pencil Drawing Generation via Fast Retinex Decomposition".

CAD/Graphics 2021

Visit our  :page_facing_up: [project page](https://hfut-nuietp.github.io/retinexpencil/) .

Paper can be downloaded here :memo: [paper](https://drive.google.com/uc?export=view&id=1VA6RObeL2BUQdBorKU6IAI6tWM-q9pEf) .



![](https://drive.google.com/uc?export=view&id=1W-FqBj6COnQ2DpaQ4l4u6FCN6yxyNSZ-)

## Environment

1. System: Windows 10
2. MATLAB 2020a

## File Structure

```bash
.
│  demo.m # main
│  method.p # method function
├─fast_solution
├─input # input images
├─output # output save path
└─textures # template texture
```

## Usage

1. Clone the repository.

```bash
git clone https://github.com/HFUT-NUIETP/retinexpencil.git
```
2. Change work directory to the root of this repository.

```bash
cd retinexpencil
```

3. Change branch.

- If you want try the demo, please change current branch to ```demo``` .

```bash
git checkout remotes/origin/demo
```

- if you want check the source code, please change current branch to ```source``` .

```bash
git checkout remotes/origin/source
```

3. Change your options in ```demo.m```.

```matlab
mode = "color"; % # is test mode, "color" or "gray" or "decom"
resize_factor = 0.5; % # is resize factor, the small value may speed up your programs.
filename = 'input4.jpg';
filepath = 'input\';
outputfoldpath = 'output\';
```

4. Run the following command in MATLAB terminal.

```bash
>> demo
```

## Benchmark

The proposed Retinex Decomposition method are faster then the previous methods with a huge gap. 

![](https://drive.google.com/uc?export=view&id=1FdOspvqSaRjo7AsMPleHfHa020tOwsxv)

## Visual quality comparisons

![](https://drive.google.com/uc?export=view&id=1D8qO0OgLbTn3uH76n-qCPNrNaOUBifRL)

## Cite Us

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

## Acknowledgement

The research was supported by the National Undergraduate In- novation and Entrepreneurship Training Program with Grant No. [202010359089](https://hfut-nuietp.github.io/HFUT-NUIETP).

## License

[MIT](https://github.com/HFUT-NUIETP/retinexpencil/blob/main/LICENSE) © Teng Li & HFUT-NUIETP

## Reference

> - [CVPR19](): Y. Li, C. Fang, A. Hertzmann, E. Shechtman and M. Yang, "Im2Pencil: Controllable Pencil Illustration From Photographs", 2019 IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR), 2019, pp. 1525-1534.
> - [NPAR12](): C. Lu, L. Xu and J. Jia, "Combining sketch and tone for pencil drawing production", Proceedings of the symposium on non-photorealistic animation and rendering, 2012, pp. 65-73.
