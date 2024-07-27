#pragma once
#include <string>

namespace backend {
    int init(std::string resDir = "");
    void beginFrame();
    void render(bool vsync = true, bool ignoreVsync = false);
    void getMouseScreenPos(double& x, double& y);
    void setMouseScreenPos(double x, double y);
    void renderLoopBody();
    int renderLoop();
    int end();
}