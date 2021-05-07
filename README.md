# Retinex-Pencil
Implementation of "Robust Pencil Drawing Generation via Fast Retinex Decomposition".

CAD/Graphics 2021

Visit our  :page_facing_up: [project page](https://www.terrytengli.com/papers/CAG-D-21-00089.html) .

Paper can be downloaded here :memo: [paper]() .



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

## Reference

Pencil lines generation module in the released code is partly adopted from **[fumin](https://github.com/fumin)**/**[pencil](https://github.com/fumin/pencil)**.

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

## License

[MIT](https://github.com/HFUT-NUIETP/retinexpencil/blob/main/LICENSE) © Teng Li
