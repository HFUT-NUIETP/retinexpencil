# Retinex-Pencil
Implementation of "Robust Pencil Drawing Generation via Fast Retinex Decomposition".

:point_right: ​[project page](https://www.terrytengli.com/papers/CAG-D-21-00089.html)

:point_right: ​[paper]()

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

1. Change work directory to the root of this repo.
2. Change your options in ```demo.m```.

```matlab
mode = "color"; % # is test mode, "color" or "gray" or "decom"
resize_factor = 0.5; % # is resize factor, the small value may speed up your programs.
filename = 'input4.jpg';
filepath = 'input\';
outputfoldpath = 'output\';
```

3. Run the following command in MATLAB terminal.

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
@article{rtxpencil,
  title={Robust Pencil Drawing Generation via Fast Retinex Decomposition},
  author={Li, Teng and Hao, Shijie and Guo, Yanrong},
  journal={Computers \& Graphics},
  volume={},
  pages={},
  year={2021},
  publisher={Elsevier}
}
```

## License

[MIT](https://github.com/RichardLitt/standard-readme/blob/master/LICENSE) © Richard Littauer