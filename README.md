# Wind Turbine Damage Detection Using SatNet

## Overview
This project focuses on detecting damage and damage types in wind turbines using the **SatNet** deep learning model. The implementation includes all necessary application files and was developed as part of a research study.

## Dataset
The dataset used in this project is publicly available and can be accessed at the following link:  
[https://universe.roboflow.com/gtek/zeliha-t04](https://universe.roboflow.com/gtek/zeliha-t04)

## Model
The deep learning model, **SatNet**, was developed as part of a doctoral thesis. It has been specifically designed and optimized for damage detection tasks in wind turbines.

## Dependencies
This project was implemented using the following software and hardware:

- **Operating System:** Windows 11 Pro  
- **Processor:** Intel Core i9-14900  
- **RAM:** 48 GB  
- **Storage:** 3 TB SSD  
- **Graphics Card:** NVIDIA RTX 4080 (16 GB VRAM)  
- **Software:** MATLAB 2024a with Deep Learning Toolbox  

## Installation
To run this project, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/doganferdi/windturbinedefectdetection.git
   cd windturbinedefectdetection
   ```
2. Install the required dependencies:
   - Ensure you have MATLAB 2024a installed with the Deep Learning Toolbox.
   - Additional dependencies can be installed as needed.

## Usage
To use the model for detecting damage in wind turbines, run the appropriate MATLAB scripts. For example:
```matlab
run('z_5_sinifli_FasterRCNN_alexnet_02102024.m')
```
Replace `'z_5_sinifli_FasterRCNN_alexnet_02102024.m'` with the script corresponding to the model you want to use.

## Files information
1. `z_5_sinifli_FasterRCNN_alexnet_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained AlexNet deep learning model.
2. `z_5_sinifli_FasterRCNN_GoogleNet_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained GoogleNet deep learning model.
3. `z_5_sinifli_FasterRCNN_inceptionResnetV2_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained InceptionResnetV2 deep learning model.
4. `z_5_sinifli_FasterRCNN_inceptionV3_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained InceptionV3 deep learning model.
5. `z_5_sinifli_FasterRCNN_MobilNetV2_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained MobilNetV2 deep learning model.
6. `z_5_sinifli_FasterRCNN_ResNet18_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained ResNet18 deep learning model.
7. `z_5_sinifli_FasterRCNN_ResNet101_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained ResNet101 deep learning model.
8. `z_5_sinifli_FasterRCNN_Vgg19_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained vgg19 deep learning model.
9. `z_5_sinifli_FasterRCNN_ResNet50_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained ResNet50 deep learning model.
10. `z_5_sinifli_FasterRCNN_SqueezeNet_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained SequeezeNet deep learning model.
11. `z_5_sinifli_FasterRCNN_Vgg16_02102024.m`: Matlab code for training and testing processes for detecting objects in the dataset with the Faster RCNN object detection model using the trained Vgg16 deep learning model.
12. `z_5_sinifli_FasterRCNN_SatNET_3v1.m`: Matlab code for the training and testing processes of the proposed SatNET deep learning model to detect objects in the dataset with the Faster RCNN object detection model.
13. `SatNET_ruzgarturbini_icin.mat`: Layered structure of the SatNET deep learning model.
14. `z_data_augmention_v1.m`: This file contains the data augmentation algorithm applied to increase the image size by 4 times.
15. `z_image_resize.m`: This file contains the codes used to automatically resize the image.

## Contributing
Contributions are welcome! Please read the [CONTRIBUTING.md](./CONTRIBUTING.md) document for guidelines on how to contribute to this project.

## License
This project is licensed for research and educational purposes only. See the [LICENSE](./LICENSE) file for details.

## Author
This project was created and published by **Ferdi DOĞAN** as part of a research study on wind turbine damage detection.

## Contact
For any inquiries or questions, please contact Ferdi DOĞAN at [fdogan@adiyaman.edu.tr](mailto:fdogan@adiyaman.edu.tr).

## Screenshots
Include some screenshots of your application here.

## GitHub Repository
The files have been added to GitHub and can be accessed at: [GitHub Repository](https://github.com/doganferdi/windturbinedefectdetection)
