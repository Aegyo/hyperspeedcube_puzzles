
puzzles:add{
    id = 'skewb_ultimate',
    name = "Skewb Ultimate",
    version = '1.0.0',
    ndim = 3,
    colors = 'dodecahedron',
    build = function(self)
        local dodeca = lib.symmetries.h3.dodecahedron()
        local octa = lib.symmetries.bc3.octahedron()

        local face_edge_angle = acos(-sqrt(1/(phi * sqrt(5))))
        local adjust = rot{ fix = vec(1, 0, 0), angle = face_edge_angle}

        for t, axis in dodeca:iter_poles() do
            self:carve(adjust:transform(axis))
        end

        self.axes:add(octa:iter_poles(), { INF, 0, -INF })

        for t, axis, twist_t in octa.sym.chiral:orbit(self.axes[1], octa.sym:thru(3,2)) do
            self.twists:add(axis, twist_t, { gizmo_pole_distance = 1/2 })
        end

        lib.piece_types.mark_everything_core(self)
    end,

    tags = {
        builtin = '2.0.0',
        author = { "Jessica Chen" },
        inventor = "Uwe Mèffert",
        'type/puzzle',
        'shape/3d/platonic/dodecahedron',

        axes = { '3d/elementary/octahedral'},
    },
}

