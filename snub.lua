local tribonacci_constant = (1 + 4*cosh(1/3 * acosh(2 + 3/8))) / 3

puzzles:add{
  id = 'snub_cube_jess',
  version = '0.1.0',
  name = "Snub Cube (modified)",
  tags = {
    "type/shape",
    experimental = true,
    author = { "Andrew Farkas", "Jessica Chen"}
  },
  ndim = 3,
  build = function(self)
    local sym = cd'bc3'.chiral

    local v1 = vec(1, 2*tribonacci_constant + 1, tribonacci_constant^2)
    local v2 = vec(tribonacci_constant^3)
    local v3 = vec(1,1,1) * tribonacci_constant^2

    local scale = v2.mag

    local function dual_vertex_to_pole(v)
      return v / v.mag2 * scale
    end

    local pole1 = dual_vertex_to_pole(v1)
    local pole2 = dual_vertex_to_pole(v2)
    local pole3 = dual_vertex_to_pole(v3)
    local carve_poles = { pole1, pole2, pole3 }

    for _, p in pairs(carve_poles) do
        self:carve(sym:orbit(p))
    end

    -- only twist these ones
    local poles = { pole2, pole3 }

    -- cuts
    for _, p in pairs(poles) do
        local depth = p == pole2 and 1 - 0.12 or 1 - 0.03
        for t, axis in sym:orbit(p) do
            self.axes:add(axis, {INF, depth})
        end
    end
    
    -- twists
    for _, p in pairs(poles) do
        local axis = self.axes[p]
        local angle = p == pole2 and tau/4 or tau/3

        for _, a, r in sym:orbit(axis, rot{fix = axis.vector, angle = angle }) do
            self.twists:add(a, r, { gizmo_pole_distance = 1})
        end
    end
  end,
}