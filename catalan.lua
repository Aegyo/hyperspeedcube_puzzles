
puzzles:add{
    id = 'rhombic_triacontahedron',
    name = 'Rhombic Triacontahedron',
    version = '0.1.0',
    ndim = 3,
    build = function(self)
        local shape = lib.util.shape.rhombic_triacontahedron(2)

        for _, p in shape:iter_poles() do
            print(p.mag)
        end
        self:carve(shape:iter_poles())
        self.axes:add(shape:iter_poles(), {INF, 0.88 * shape.pole.mag})

        print(shape.pole.mag)
        for _, a, t in shape.sym.chiral:orbit(self.axes[shape.pole], shape.sym.chiral:thru(3,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = shape.pole.mag })
        end
    end,
    tags = {
        author = { 'Jessica Chen' },
        'shape/3d/catalan',
        'turns_by/facet',
        'algebraic/doctrinaire',
        'cuts/depth/shallow',
        'type/puzzle',
        'axes/3d/catalan',
    }
}