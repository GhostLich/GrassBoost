#include "wind.vert"

layout(binding = 0) uniform UniformBufferObject {
    mat4 mv_matrix;
    mat4 shadow_matrices[4];
    mat4 windMatrix;
    vec4 camPosDecalRenderDistance;
    vec4 sunPosAnimationTimer;
    vec4 originWindStrength;
    vec4 windDir;
} ubo;

layout(binding = 1) uniform cameraUniformBufferObject {
  mat4 proj;
  mat4 view;
  mat4 worldView;
  mat4 worldRotation;
	vec4 camOffsetPos;
	vec4 camOffsetPosWorld;
} camera;

layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 centerPos;
layout(location = 2) in vec4 stst;
layout(location = 3) in vec4 normal;
layout(location = 4) in vec4 forwardNormal;

layout(location = 0) out vec3 outView;
layout(location = 1) out vec4 outTex;
layout(location = 2) out float alpha;
layout(location = 3) out vec3 outForwardNormal;

invariant gl_Position;

void main()
{
    float fadeEnd = min((ubo.camPosDecalRenderDistance.w - 0.05) * 0.75, 1.8);
    if(length((camera.camOffsetPosWorld.xyz + ubo.camPosDecalRenderDistance.xyz) - centerPos) > fadeEnd + 0.05)
    {
        gl_Position = vec4(0.0, 0.0, 2.0, 1.0);
        return;
    }

    vec3 windPos = pos.xyz;
    vec3 normalToUse = normal.xyz;

    if(stst.w > 0.5)
    {
        windPos = getTerrainDecalWindPos(ubo.windMatrix, ubo.windDir.xy, windPos - centerPos, centerPos, 1.0, ubo.sunPosAnimationTimer.w, normalToUse, ubo.originWindStrength.w) + centerPos;

    }
    vec4 V = camera.worldView * ubo.mv_matrix * vec4(windPos, 1.0);
    gl_Position = camera.proj * V;

    outTex = stst;
    outForwardNormal = forwardNormal.xyz;
    
    outView = (camera.camOffsetPosWorld.xyz + ubo.camPosDecalRenderDistance.xyz) - windPos;

    alpha = 1.0 - smoothstep(fadeEnd * 0.8, fadeEnd, length(outView));
}
