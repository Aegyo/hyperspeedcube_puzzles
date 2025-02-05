puzzles:add{
    id = 'truncated_tetrahedron',
    name = 'Truncated Tetrahedron',
    version = '0.1.0',
    ndim = 3,
    build = function(self)
        local shape = lib.util.shape.truncated_tetrahedron()

        self:carve(shape:iter_hex_poles())
        self:carve(shape:iter_tri_poles())

        self.axes:add(shape:iter_hex_poles(), { INF, 0.7 * shape.hex_pole.mag })
        self.axes:add(shape:iter_tri_poles(), { INF, 0.8 * shape.tri_pole.mag })

        for _, a, t in shape.sym.chiral:orbit(self.axes[shape.hex_pole], shape.sym:thru(3,2)) do
            self.twists:add(a, t, {gizmo_pole_distance = shape.hex_pole.mag})
        end
        for _, a, t in shape.sym.chiral:orbit(self.axes[shape.tri_pole], shape.sym:thru(2,1)) do
            self.twists:add(a, t, {gizmo_pole_distance = shape.tri_pole.mag})
        end
    end,
    tags = {
        author = { 'Jessica Chen' }
    }
}

puzzles:add{
    id = 'truncated_octahedron',
    name = 'Truncated Octahedron',
    version = '0.1.0',
    ndim = 3,
    build = function(self)
        local shape = lib.util.shape.truncated_octahedron(3/2)
        
        self:carve(shape:iter_hex_poles())
        self:carve(shape:iter_square_poles())
        
        self.axes:add(shape:iter_hex_poles(), {INF, 0.78 * shape.hex_pole.mag})
        self.axes:add(shape:iter_square_poles(), {INF, 0.85 * shape.square_pole.mag})
        
        for _, a, t in shape.sym.chiral:orbit(self.axes[shape.hex_pole], shape.sym:thru(3,2)) do
            self.twists:add(a, t, { gizmo_pole_distance = shape.hex_pole.mag })
        end
        for _, a, t in shape.sym.chiral:orbit(self.axes[shape.square_pole], shape.sym:thru(2,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = shape.square_pole.mag })
        end

        lib.utils.unpack_named(_ENV, self.axes)
        self:mark_piece(F(1) & ~FLU(1) & ~FLD(1) & ~FRU(1) & ~FRD(1), 'square_center', 'Square Center')
        self:mark_piece(FLU(1) & ~F(1) & ~L(1) & ~U(1) & ~FRU(1) & ~FLD(1) & ~BLU(1), 'hex_center', 'Hexagon Center')
        self:mark_piece(F(1) & FLU(1) & ~FLD(1) & ~FRU(1), 'square_edge', 'Square Edge')
        self:mark_piece(FLU(1) & FRU(1) & ~F(1) & ~U(1), 'hex_edge', 'Hexagon Edge')
        self:mark_piece(F(1) & FLU(1) & FRU(1), 'corner', 'Corner')
        self:unify_piece_types(shape.sym.chiral)
    end,
    tags = {
        author = { 'Jessica Chen' },
        'shape/3d/archimedean'
    },
}

puzzles:add{
    id = 'icosidodecahedron',
    name = 'Icosidodecahedron',
    version = '0.1.0',
    ndim = 3,
    build = function(self)
        local shape = lib.util.shape.icosidodecahedron(3/2)
        local sym = shape.sym

        self:carve(shape:iter_penta_poles('Penta_'))
        self:carve(shape:iter_tri_poles('Tri_'))

        self.axes:add(shape:iter_penta_poles('Penta_'), { INF, shape.penta_pole.mag * 0.85 })
        self.axes:add(shape:iter_tri_poles('Tri_'), { INF, shape.tri_pole.mag * 0.925 })
        
        for _, a, t in sym.chiral:orbit(self.axes[shape.penta_pole], sym:thru(2,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = shape.penta_pole.mag })
        end
        for _, a, t in sym.chiral:orbit(self.axes[shape.tri_pole], sym:thru(3,2)) do
            self.twists:add(a, t, { gizmo_pole_distance = shape.tri_pole.mag })
        end
        
        lib.utils.unpack_named(_ENV, self.axes)
        self:mark_piece(Penta_F(1) & ~Tri_U(1) & ~Tri_F(1) & ~Tri_R(1) & ~Tri_UR(1) & ~Tri_FR(1), 'penta_center', 'Pentagon Center')
        self:mark_piece(Penta_F(1) & Penta_L(1) & Penta_DL(1), 'tri_center', 'Triangle Center')
        self:mark_piece(Penta_F(1) & Tri_U(1) & ~Penta_L(1) & ~Penta_U(1), 'two_col_edge', '2C Edge')
        self:mark_piece(Tri_U(1) & Penta_F(1) & Penta_L(1) & ~Tri_F(1) & ~Penta_U(1), 'three_col_edge', '3C Edge')
        self:mark_piece(Penta_F(1) & Penta_L(1) & Tri_F(1) & Tri_U(1), 'corner', 'Corner')
        self:unify_piece_types(sym.chiral)

        for i = 1,12 do
            self.colors[i].default = 'Turbo[' .. i ..'/12]'
        end
        for i = 13,32 do
            self.colors[i].default = 'Dark Rainbow['.. i ..'/20]'
        end
    end,
    tags = {
        author = { 'Jessica Chen' },
        'shape/3d/archimedean'
    },
}