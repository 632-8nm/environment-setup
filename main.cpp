#include <opencv2/opencv.hpp>
#include <QApplication>
#include <QtGlobal>
#include <iostream>
#include <fstream>

int main(int argc, char* argv[]){
    QApplication app(argc, argv);
    std::cout << "OpenCV version : " << cv::getVersionString() << std::endl;
    std::cout << "Qt version : " << qVersion() << std::endl;

    std::ifstream infile("resources/data.txt");
    std::string line;
    while (std::getline(infile, line)) { 
        std::cout << line << std::endl;
    }
    infile.close();    

    cv::Mat image = cv::imread("resources/picture.jpg", cv::IMREAD_COLOR);
    std::cout << "Image shape before resized : " << image.size() << std::endl;
    cv::resize(image, image, cv::Size(), 0.5, 0.5, cv::INTER_AREA);
    std::cout << "Image shape after resized : " << image.size() << std::endl;
    // cv::imshow("image", image);
    // cv::waitKey(1000);

    return 0;
}