# memCS
This is the source code for our paper: *Yunrui Jiao, Han Zhao, Jianshi Tang, et al., A memristor-based energy-efficient compressed sensing accelerator with hardware-software co-optimization for edge computing, National Science Review, 2025; nwaf499*.

### code

#### AMP algorithm
- The source code of the approximate message passing (AMP) algorithm comes from the formulas in [this paper](https://arxiv.org/pdf/0907.3574).

#### MMM & SE strategies
- These two strategies are used to optimize the measurement matrix $\Phi$ and the sparse transform matrix $\Psi$ in the AMP algorithm, respectively.



### classification

- The dataset and source code for this section are saved [here](https://cloud.tsinghua.edu.cn/f/8a21622bb87c4c8a8dd1/?dl=1).

#### pretrained_models
- A pre-trained convolutional neural network (default: ResNet50) is used here to perform classification inference on the reconstructed images.

#### ImageNet

- For the source of the ImageNet-1k dataset, see [here](https://huggingface.co/datasets/ILSVRC/imagenet-1k).
- A tool code (./ImageNet/parquet_to_image.ipynb) is used to extract images from a specific data structure for experiments.
