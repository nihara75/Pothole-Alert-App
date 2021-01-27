#Prototype
• The App was designed using the Flutter framework
• Google Maps functionality was integrated to it using a plugin and an API key
• Users could send the location of a pothole through an email if they report it

#Dataset
We used Pothole dataset of Kaggle with our own pothole image colections.It consists of
10,000+ images. All these images were preprocessed using opencv. The preprocessing done
includes resizing, converting to grayscale, and adaptive thresholding. All the images are
treated as numpy arrays. After preprocessing each image, they’re added to the trainX list and
the corresponding labels are added to trainY list.

#Training
The training was done using Google Colab so that we could get TeslaK80 GPU for faster and
efficient training of the network. After preprocessing dataset i.e.creating labels file , splitting
up the list of training and testing data the images and the list of their locations are kept
together.The yolo.cfg file was used for training configurations which include fifteen yolo
layers.
Colab Link[Colab](https://colab.research.google.com/drive/1FUpkxm1IMW_DiwcaqoGtxIv_IYojfzsl?usp=sharing)

*Before use: Need to provide your own API key to the code
