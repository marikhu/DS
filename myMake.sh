#!/bin/bash

function getbazel(){
	LINE=`readlink -f /home/$USER/code1/tensorflow-1.4.0-rc0/bazel-bin/`

	POS1="_bazel_$USER/"
	STR=${LINE##*$POS1}

	BAZEL=${STR:0:32}

	echo $BAZEL
}



BAZEL=`getbazel`




INCLUDEPATH="-I/usr/local/opencv-2.4.13.2/include -I/usr/local/opencv-2.4.13.2/include/opencv -I/usr/include -I /usr/include/eigen3/Eigen -I /usr/include/tbb "


LLIBPATH="-L/usr/local/opencv-2.4.13.2/lib -L/usr/local/lib -L/usr/lib -L/media/marikhu/work/GitHub/DS/deepsort/FeatureGetter"

#rm -rf DS


function BOPENMP(){
	LLIBS="-lopencv_core -lopencv_imgproc  -lopencv_highgui -lopencv_imgcodecs -lFeatureGetter -lboost_system -lglog -ltcmalloc"
	g++ --std=c++14 -O3 -fopenmp -DUDL -o DS $INCLUDEPATH $LLIBPATH  deepsort/munkres/munkres.cpp deepsort/munkres/adapters/adapter.cpp deepsort/munkres/adapters/boostmatrixadapter.cpp  NT.cpp fdsst/fdssttracker.cpp fdsst/fhog.cpp Main.cpp $LLIBS
}


function BTBB(){
	LLIBS="-lopencv_core -lopencv_imgproc -lopencv_highgui -lFeatureGetter -lboost_system -lglog -ltbb"
	g++ --std=c++14 -DUSETBB -o DS $INCLUDEPATH $LLIBPATH deepsort/munkres/munkres.cpp deepsort/munkres/adapters/adapter.cpp deepsort/munkres/adapters/boostmatrixadapter.cpp fdsst/fdssttracker.cpp fdsst/fhog.cpp NT.cpp Main.cpp $LLIBS
}


function BOPENMPHOG(){
	LLIBS="-lopencv_core -lopencv_imgproc  -lopencv_highgui  -lboost_system -lglog -ltcmalloc"
	g++ --std=c++14 -O3 -fopenmp -o DS $INCLUDEPATH $LLIBPATH  deepsort/munkres/munkres.cpp deepsort/munkres/adapters/adapter.cpp deepsort/munkres/adapters/boostmatrixadapter.cpp  NT.cpp fdsst/fdssttracker.cpp fdsst/fhog.cpp Main.cpp $LLIBS
}

#BOPENMPHOG
BTBB




