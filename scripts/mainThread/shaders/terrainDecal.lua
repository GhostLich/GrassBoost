local mod = {
    loadOrder = 1,
}

function mod:onload(shader)
    shader.vertPath = "terrainDecalBoost.vert.spv"
end

return mod
