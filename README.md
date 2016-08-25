## OPENCV BUILD FARM

#### DEVELOPER TARGET 

* any deb based Linux 
* any rpm based Linux
* macos 10.11 and newer with clang installed


#### build.sh options
* --clean : clean build directories
* --opencv : build opencv
* --tesseract : build tesseract
* --install : install builded library (for developer only!)
* --pack : create deploy packet for installing on target platform


#### DEVELOPER MODE :

		git clone --recursive git@gitlab.i-free.com:k.shabordin1/opencv-dist.git
		cd opencv-dist
		./prereq.sh
		./build.sh --clean --opencv --tesseract --install 


#### DEVOPS MODE : 

		git clone --recursive git@gitlab.i-free.com:k.shabordin1/opencv-dist.git
		cd opencv-dist
		./prereq.sh
		./build.sh --clean --opencv --pack



#### DEPLOY ON TARGET SYSTEM

...WiP 		 
	
		



