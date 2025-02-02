local tribonacci_constant = (1 + 4*cosh(1/3 * acosh(2 + 3/8))) / 3

color_systems:add{
    id = 'snub_cube_jess',
    name = "snub_cube_jess",

    colors = {
    { name = 'A',  display = "A",  default = "Mono Tetrad [1]" },
    { name = 'B',  display = "B",  default = "Mono Tetrad [2]" },
    { name = 'C',  display = "C",  default = "Mono Tetrad [3]" },
    { name = 'D',  display = "D",  default = "Mono Tetrad [4]" },
    { name = 'E',  display = "E",  default = "Red Tetrad [1]" },
    { name = 'F',  display = "F",  default = "Red Tetrad [2]" },
    { name = 'G',  display = "G",  default = "Red Tetrad [3]" },
    { name = 'H',  display = "H",  default = "Red Tetrad [4]" },
    { name = 'I',  display = "I",  default = "Orange Tetrad [1]" },
    { name = 'J',  display = "J",  default = "Orange Tetrad [2]" },
    { name = 'K',  display = "K",  default = "Orange Tetrad [3]" },
    { name = 'L',  display = "L",  default = "Orange Tetrad [4]" },
    { name = 'M',  display = "M",  default = "Yellow Tetrad [1]" },
    { name = 'N',  display = "N",  default = "Yellow Tetrad [2]" },
    { name = 'O',  display = "O",  default = "Yellow Tetrad [3]" },
    { name = 'P',  display = "P",  default = "Yellow Tetrad [4]" },
    { name = 'Q',  display = "Q",  default = "Green Tetrad [1]" },
    { name = 'R',  display = "R",  default = "Green Tetrad [2]" },
    { name = 'S',  display = "S",  default = "Green Tetrad [3]" },
    { name = 'T',  display = "T",  default = "Green Tetrad [4]" },
    { name = 'U',  display = "U",  default = "Blue Tetrad [1]" },
    { name = 'V',  display = "V",  default = "Blue Tetrad [2]" },
    { name = 'W',  display = "W",  default = "Blue Tetrad [3]" },
    { name = 'X',  display = "X",  default = "Blue Tetrad [4]" },
    { name = 'Y',  display = "Y",  default = "Purple Tetrad [1]" },
    { name = 'Z',  display = "Z",  default = "Purple Tetrad [2]" },
    { name = 'AA', display = "AA", default = "Purple Tetrad [3]" },
    { name = 'AB', display = "AB", default = "Purple Tetrad [4]" },
    { name = 'AC', display = "AC", default = "Magenta Tetrad [1]" },
    { name = 'AD', display = "AD", default = "Magenta Tetrad [2]" },
    { name = 'AE', display = "AE", default = "Magenta Tetrad [3]" },
    { name = 'AF', display = "AF", default = "Magenta Tetrad [4]" },
    { name = 'AG', display = "AG", default = "Black" },
    { name = 'AH', display = "AH", default = "Brown" },
    { name = 'AI', display = "AI", default = "Teal" },
    { name = 'AJ', display = "AJ", default = "#cfdfaf" },
    { name = 'AK', display = "AK", default = "#dfafc7" },
    { name = 'AL', display = "AL", default = "#afcadf" },
    },
}

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
  colors = "snub_cube_jess",
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

    local i = 0
    for _, p in pairs(carve_poles) do
        for t, a in sym:orbit(p) do
            i = i+1
            self:carve(a, { stickers = self.colors[i]})
        end
    end

    -- only twist these ones
    local poles = { pole2, pole3 }

    -- cuts
    for _, p in pairs(poles) do
        local depth = p == pole2 and 1 - 0.12 or 1 - 0.03
        for t, axis in sym:orbit(p) do
            self.axes:add(axis, {INF, depth })
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
