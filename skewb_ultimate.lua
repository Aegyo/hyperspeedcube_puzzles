puzzles:add {
    id = 'skewb_ultimate',
    name = "Skewb Ultimate",
    version = '1.0.0',
    ndim = 3,
    colors = 'dodecahedron',
    build = function(self)
        local dodeca = lib.symmetries.h3.dodecahedron()
        local octa = lib.symmetries.bc3.octahedron()

        local face_edge_angle = acos(-sqrt(1 / (phi * sqrt(5))))
        local adjust = rot { fix = vec(1, 0, 0), angle = face_edge_angle }

        for t, axis, name in dodeca:iter_poles() do
            self:carve(adjust:transform(axis), { stickers = self.colors[tostring(name)] })
        end

        self.axes:add(octa:iter_poles(), { INF, 0, -INF })

        for t, axis, twist_t in octa.sym.chiral:orbit(self.axes[1], octa.sym:thru(3, 2)) do
            self.twists:add(axis, twist_t, { gizmo_pole_distance = 3 / 4 })
        end

        lib.utils.unpack_named(_ENV, self.axes)
        self:mark_piece(F(1) & R(1) & U(1) & L(1), 'edge', 'Edge')
        self:mark_piece(D(1) & L(1) & R(1), 'corner', 'Corner')
        self:unify_piece_types(octa.sym.chiral)
    end,

    tags = {
        builtin = '2.0.0',
        inventor = "Tony Fisher",
        external = { museum = 656 },
        author = { "Jessica Chen" },

        'shape/3d/platonic/dodecahedron',
        axes = { '3d/elementary/octahedral' },
        algebraic = { 'doctrinaire' }
    },
}
