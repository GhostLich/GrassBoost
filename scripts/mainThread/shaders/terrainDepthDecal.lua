local mod = {
    loadOrder = 1,
}

function mod:onload(shader)
    shader.vertPath = "terrainDepthDecalBoost.vert.spv"
end

return mod
