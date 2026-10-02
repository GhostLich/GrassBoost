# GrassBoost

works on both Stable 0.6.1.3 and Unstable 0.7.0.2

doubles the presently set grass distance setting, and attempts to better improve the fade transition to reduce the hard edge cutoffs that you can often see moving the camera around. it does impact the fps a bit, 0.7 seems to have more effecient grass rendering over 0.6 so results may vary

glsl/ has the shader sources and spv/ the compiled shaders. they're edited copies of the game's grass shaders, so to build them you need the game's GameResources/glsl folder for the includes, then glslc -std=450 --target-env=vulkan1.0

scripts are MIT, see LICENSE
