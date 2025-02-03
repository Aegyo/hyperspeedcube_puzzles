puzzles:add{
    id = 'hyperskewb',
    name = 'Hyperskewb',
    version = '0.1.0',
    ndim = 4,
    tags = {
        author = { 'Jessica Chen' },
    },
    build = function(self)
        local sym = cd'bc4'
        self:carve(sym:orbit(sym.ooox.unit))
        self.axes:add(sym:orbit(sym.xooo), {INF, 0, -INF})
        for _, a, t in sym:orbit(self.axes[sym.xooo], sym:thru(3,2)) do
            self.twists:add(a, t, { gizmo_pole_distance = 1})
        end
    end
}

puzzles:add{
    id = 'face_turning_rhombic_dodecahedron',
    name = 'Face Turning Rhombic Dodecahedron',
    version = '0.1.0',
    ndim = 3,
    tags = { author = { 'Jessica Chen' } },
    build = function(self)
        local sym = cd'bc3'
        self:carve(sym:orbit(sym.oxo.unit))
        self.axes:add(sym:orbit(sym.oxo.unit), { INF, 2/3 })
        for _, a, t in sym:orbit(self.axes[sym.oxo], sym:thru(3,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = 1 })
        end
    end
}