puzzle_generators:add {
    id = 'mastermorphix',
    name = "N-layer Morphix",
    version = '1.0.0',
    params = {
        { name = "Layers", type = 'int', default = 2, min = 2, max = 9 },
    },

    gen = function(params)
        local size = params[1]

        return {
            name = size .. "-Layer Morphix",
            colors = 'tetrahedron',
            ndim = 3,

            build = function(self)
                local tetra = lib.symmetries.tetrahedral.tetrahedron(2/3)
        
                self:carve(tetra:iter_poles())
                self.axes:add(tetra.sym:orbit(tetra.sym.oxo.unit), lib.utils.layers.inclusive_inf(1/3, -1/3, size))
        
                for _, axis in ipairs(self.axes) do
                    self.twists:add(axis, rot{ fix = axis.vector, angle = tau / 4}, { gizmo_pole_distance = 2/3})
                end
            end,
        }
    end,

    examples = {
        {
            params = {2}, name = "Pyramorphix",
            tags = {
                external = { museum = 542 },
                inventor = "Manfred Fritsche",
            },
        },

        {
            params = {3}, name = "Mastermorphix",
            tags = {
                external = { museum = 675 },
                inventor = "Tony Fisher",
            },
        },

        {
            params = {4}, name = "Megamorphix",
            tags = {
                external = { museum = 1762 },
                inventor = "Adam Zamora"
            },
        },

        {
            params = {5}, name = "Ultramorphix",
            tags = {
                external = { museum = 1751 },
                inventor = "Chiou Sheng Wen"
            },
        },
    },

    tags = {
        builtin = '2.0.0',
        author = { "Jessica Chen" },
        'shape/3d/platonic/tetrahedron',
        'axes/elementary/cubic'
    },
}
